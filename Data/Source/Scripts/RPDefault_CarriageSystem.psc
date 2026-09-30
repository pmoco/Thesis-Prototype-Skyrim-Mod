Scriptname RPDefault_CarriageSystem extends Quest Conditional

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
Keyword Property LinkCarriageSeat Auto
GlobalVariable Property CarriageCost Auto
MiscObject Property Gold Auto
Topic Property DialogueCarriageChatterTopic Auto

Idle property IdleCartDriverIdle Auto

ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto

    ; Config
Bool Property bPreventPlayerTravelingOverencumbered = true Auto
Bool Property bCarriageServicesCostGold = true Auto
GlobalVariable Property gAllowCarriageDriverChatterTime Auto
{ Controls time driver is given for talking before the actual fast travel occurs. Default value in the vanilla script is 6.0 }

ReferenceAlias Property PlayerCarraigeSeat Auto
{ Must have RPDefault_CarriagePlayerSeatAlias script }


; -------------------------------------------
; Hidden Properties
; -------------------------------------------

Actor Property kCurrentDriver Auto Hidden
ObjectReference Property kTargetDestination Auto Hidden

; -------------------------------------------
; Events
; -------------------------------------------
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
	Debug.Trace("TryToTravel(" + akDestinationRef + ", " + akDriver + ")")
	kTargetDestination = akDestinationRef
	kCurrentDriver = akDriver
	ObjectReference kSitMarker = kCurrentDriver.GetLinkedRef(LinkCarriageSeat)
	
	; Start watching for player to sit		
	PlayerCarraigeSeat.ForceRefTo(kSitMarker)
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 3) ; to allow "waiting" chatter
	
	; if player is sitting already, let's go
	if(kSitMarker.IsFurnitureInUse())
		PlayerCarraigeSeat.Clear()
		Bool bSuccess = HandlePlayerSat()
			
		if(bSuccess)
			return iTravelResult_Success
		else
			return iTravelResult_Failed
		endif
	endif
	
	return iTravelResult_WaitingForSit
EndFunction

Function PayForCarriage()
	if( ! bCarriageServicesCostGold || ! CarriageCost)
		return
	endif
	
	; Check if driver is in BYOHCarriageDriverFaction
		; Using GetFormFromFile here to avoid dependency on HearthFires.esm
	Faction BYOHCarriageDriverFaction = Game.GetFormFromFile(0x00007890, "HearthFires.esm") as Faction
	if(BYOHCarriageDriverFaction && kCurrentDriver.IsInFaction(BYOHCarriageDriverFaction))
		return
	endif
	
	; Check for cost override
	int iCarriageCost = CarriageCost.GetValueInt()
	
	; Expects that dialogue conditions have already confirmed player has enough gold
	if(iCarriageCost > 0)
		Game.GetPlayer().RemoveItem(Gold, iCarriageCost)
	endif
EndFunction

Function ClearWaitingState()
	kCurrentDriver.SetActorValue(sDriverChatterControlAV, 0)
	kCurrentDriver = None
	kTargetDestination = None
	PlayerCarraigeSeat.Clear()
EndFunction

Bool Function HandlePlayerSat()
	; debug.trace(self + " PlayerIsSitting")
	; if driver is dead, clear and return
	if(kCurrentDriver.IsDead())
		ClearWaitingState()
		return false
	endif

	Actor PlayerRef = Game.GetPlayer()
	; no riding while in combat (because you can't actually sit)
	if(PlayerRef.IsInCombat())
		return false
	endif

	; no riding while encumbered (fast travel will fail)
	if(bPreventPlayerTravelingOverencumbered && PlayerRef.GetActorValue(sInventoryWeightAV) > PlayerRef.GetActorValue(sCarryWeightAV))
		; debug.trace(self + " PlayerRef is encumbered - do nothing")
		return false
	endif
	
	; Confirm this destination exists
	if(!kTargetDestination)
		return false
	endif
	
	Game.DisablePlayerControls()
	CarriageDriverScript driverScript = (kCurrentDriver as ObjectReference) as CarriageDriverScript
	if(driverScript && driverScript.bSitting)
		kCurrentDriver.PlayIdle(IdleCartDriverIdle)
	endif
	
	PayForCarriage()
	
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
			; Increase the player's carrying capacity to encompass their entire inventory so that fast travel isn't stopped if they were overencumbered. We will restore their capacity after travel.
			PlayerRef.ModActorValue(sCarryWeightAV, fInventoryWeight)
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
			PlayerRef.ModActorValue(sCarryWeightAV, -fInventoryWeight)
		endif
	endif
	
	FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
	FadeToBlackHoldImod.Remove()
	
	ClearWaitingState()
EndFunction