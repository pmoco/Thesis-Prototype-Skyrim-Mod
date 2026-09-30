Scriptname RPDefault_FerrySystem extends Quest Conditional

; -------------------------------------------
; Read-Only
; -------------------------------------------
String Property sDriverChatterControlAV = "variable01" autoReadOnly
String Property sCarryWeightAV = "CarryWeight" autoReadOnly
String Property sInventoryWeightAV = "InventoryWeight" autoReadOnly

int Property iTravelResult_Failed = 0 autoReadOnly
int Property iTravelResult_Success = 1 autoReadOnly
int Property iTravelResult_WaitingForSit = 2 autoReadOnly

; -------------------------------------------
; Editor Properties
; -------------------------------------------
	; Autofill
MiscObject Property Gold Auto
Topic Property DialogueCarriageChatterTopic Auto

Idle property IdleCartDriverIdle Auto

ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto

    ; Config
Bool Property bWaitForPlayerToSit = true Auto Conditional
Bool Property bPreventPlayerTravelingOverencumbered = true Auto
Bool Property bTravelServicesCostGold = true Auto
GlobalVariable Property gAllowCarriageDriverChatterTime Auto
{ Controls time driver is given for talking before the actual fast travel occurs. Default value in the vanilla script is 6.0 }

ReferenceAlias Property PlayerSeat Auto
{ Must have RPDefault_FerryPlayerSeatAlias script }
ReferenceAlias Property PlayerSeat2 Auto
{ Must have RPDefault_FerryPlayerSeatAlias script }
	
	; Load via GetFormFromFile
Keyword Property DLC1LinkFerrySeat1 Auto
Keyword Property DLC1LinkFerrySeat2 Auto
GlobalVariable Property FerryCost Auto

; -------------------------------------------
; Hidden Properties
; -------------------------------------------

Actor Property kCurrentDriver Auto Hidden
ObjectReference Property kTargetDestination Auto Hidden

; -------------------------------------------
; Events
; -------------------------------------------

Event OnInit()
	if(IsRunning())
		; Using GetFormFromFile here to avoid dependency on Dawnguard.esm
		if(!DLC1LinkFerrySeat1)
			DLC1LinkFerrySeat1 = Game.GetFormFromFile(0x0001685A, "Dawnguard.esm") as Keyword
		endif
		
		if(!DLC1LinkFerrySeat2)
			DLC1LinkFerrySeat2 = Game.GetFormFromFile(0x0001685B, "Dawnguard.esm") as Keyword
		endif
		
		if(!FerryCost)
			FerryCost = Game.GetFormFromFile(0x0001684B, "Dawnguard.esm") as GlobalVariable ; Defaults to DLC1FerryCostSmall
		endif
	endif
EndEvent

Event OnUpdate()
	; player has asked to travel, single update to prevent function call from blocking
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 2) ; to allow chatter
	kCurrentDriver.Say(DialogueCarriageChatterTopic)
	utility.wait(gAllowCarriageDriverChatterTime.GetValue())
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 0) ; turn it back off
	SkipToDestinationSimple()
EndEvent

; -------------------------------------------
; Functions
; -------------------------------------------

Int Function TryToTravel(ObjectReference akDestinationRef, Actor akDriver)
	kTargetDestination = akDestinationRef
	kCurrentDriver = akDriver

	ObjectReference kSitMarker = kCurrentDriver.GetLinkedRef(DLC1LinkFerrySeat1)
	ObjectReference kSitMarker2 = kCurrentDriver.GetLinkedRef(DLC1LinkFerrySeat2)
	
	if(bWaitForPlayerToSit)
		; just start watching for player to sit
		
		PlayerSeat.ForceRefTo(kSitMarker)		
		PlayerSeat2.ForceRefTo(kSitMarker2)
		
		kCurrentDriver.SetActorValue(sDriverChatterControlAV, 3) ; to allow "waiting" chatter
		
		; if player is sitting already, let's go
		if(kSitMarker.IsFurnitureInUse() || kSitMarker2.IsFurnitureInUse())
			PlayerSeat.Clear()
			Bool bSuccess = HandlePlayerSat()
			
			if(bSuccess)
				return iTravelResult_Success
			else
				return iTravelResult_Failed
			endif
		endif
	else
		PayForTravel()

		; Force player to sit in marker
		if(kSitMarker.IsFurnitureInUse())
			kSitMarker.Activate(Game.GetPlayer())
		elseif(kSitMarker2.IsFurnitureInUse())
			kSitMarker2.Activate(Game.GetPlayer())
		endif
		
		RegisterForSingleUpdate(1)
	endif
	
	return iTravelResult_WaitingForSit
EndFunction

Function PayForTravel()
	if( ! bTravelServicesCostGold || ! FerryCost)
		return
	endif
	
	; Check if driver is in BYOHCarriageDriverFaction
		; Using GetFormFromFile here to avoid dependency on HearthFires.esm
	Faction BYOHCarriageDriverFaction = Game.GetFormFromFile(0x00007890, "HearthFires.esm") as Faction
	if(BYOHCarriageDriverFaction && kCurrentDriver.IsInFaction(BYOHCarriageDriverFaction))
		return
	endif
	
	; Check for cost override
	int iFerryCost = FerryCost.GetValueInt()
		
	; Expects that dialogue conditions have already confirmed player has enough gold
	if(iFerryCost > 0)
		Game.GetPlayer().RemoveItem(Gold, iFerryCost)
	endif
EndFunction

Function ClearWaitingState()
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 0)
	kCurrentDriver = None
	kTargetDestination = None
	PlayerSeat.Clear()
	PlayerSeat2.Clear()
EndFunction

Bool Function HandlePlayerSat()
	; debug.trace(self + " PlayerIsSitting")
	Actor PlayerRef = Game.GetPlayer()

	; if driver is dead, clear and return
	if(kCurrentDriver.IsDead())
		ClearWaitingState()
		return false
	endif

	; no riding while in combat (because you can't actually sit)
	if(PlayerRef.IsInCombat())
		return false
	endif

	; no riding while encumbered (fast travel will fail)
	if(bPreventPlayerTravelingOverencumbered && PlayerRef.GetActorValue("InventoryWeight") > PlayerRef.GetActorValue("CarryWeight"))
		; debug.trace(self + " PlayerRef is encumbered - do nothing")
		return false
	endif
	
	; Confirm this destination exists
	if(!kTargetDestination)
		return false
	endif
	
	Game.DisablePlayerControls()
		
	PayForTravel()
	
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 2) ; to allow chatter
	kCurrentDriver.Say(DialogueCarriageChatterTopic)
	Utility.wait(gAllowCarriageDriverChatterTime.GetValue()) ; Give time for actor to finish speaking
	FadeToBlackImod.Apply()
	Utility.wait(2)
	FadeToBlackImod.PopTo(FadeToBlackHoldImod)
	Utility.wait(2)
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 0) ; turn chatter off
	SkipToDestinationSimple()
	
	Game.EnablePlayerControls()
	
	return true
EndFunction

Function SkipToDestinationSimple()
	if(kTargetDestination)
		; Temporarily change CarryWeight AV in case bPreventPlayerTravelingOverencumbered is false
		Actor PlayerRef = Game.GetPlayer()
		Float fCarryWeight = PlayerRef.GetActorValue(sCarryWeightAV)
		Float fInventoryWeight = Math.Ceiling(PlayerRef.GetActorValue(sInventoryWeightAV))
		Bool bModdedWeight = false
		if(fInventoryWeight > fCarryWeight)
			bModdedWeight = true
			PlayerRef.ModActorValue(sCarryWeightAV, fInventoryWeight) ; Just set it really high and we'll put it back down when we arrive
		endif
	
		Game.FastTravel(kTargetDestination)
		
		if(PlayerRef.GetCurrentLocation() != kTargetDestination.GetCurrentLocation())
			; FastTravel failed, move to instead
			PlayerRef.MoveTo(kTargetDestination)
		elseif(kTargetDestination.IsInInterior())
			; FastTravel doesn't seem to work with interior destinations, but this system could technically send one
			PlayerRef.MoveTo(kTargetDestination)
		endif
		
		if(bModdedWeight)
			PlayerRef.ModActorValue(sCarryWeightAV, -1 * fInventoryWeight)
		endif
	endif
	
	FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
	FadeToBlackHoldImod.Remove()
	
	ClearWaitingState()
EndFunction