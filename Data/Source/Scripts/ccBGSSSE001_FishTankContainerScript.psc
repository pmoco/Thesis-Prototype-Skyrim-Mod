ScriptName ccBGSSSE001_FishTankContainerScript extends ObjectReference

import Utility

FormList property placeableFishList auto
{ The list of inventory items that can be placed in this tank. }
FormList property placeableFishActivatorList auto
{ The list of corresponding swimming fish activators for each inventory item. }
FormList property hostileFishList auto
{ The list of inventory items of hostile fish. }
Keyword property ccBGSSSE001_FishTankMarkerKW01 Auto
{ The keyword corresponding to the first fish tank fish marker. }
Keyword property ccBGSSSE001_FishTankMarkerKW02 Auto
{ The keyword corresponding to the second fish tank fish marker. }
Keyword property ccBGSSSE001_FishTankMarkerKW03 Auto
{ The keyword corresponding to the third fish tank fish marker. }
Message property fishTankFirstTimeMsg auto
{ Display message when a fish tank of this size is used for the first time. Only displays once. }
Message property notAllowedFishMsg auto
{ Message displayed when the player places a non-fish form (or the wrong size of fish) in the container. }
Message property ccBGSSSE001_fishTankNoMoreRoomMsg auto
{ Message displayed when the amount of fish in the tank would exceed the tank limit. }
Message property ccBGSSSE001_fishTankHostileFishMsg auto
{ Message displayed when the player places a hostile fish form (i.e. Slaughterfish) in the container. }
Message property ccBGSSSE001_fishTankRoomLeftMsg auto
{ Notification that tells the player how much room is left in the fish tank. }
GlobalVariable property fishTankActivated auto
{ Tracks whether or not the player has ever activated a fish tank of this size. }

; --- Tracked fish forms, and fish refs
Activator placedFishForm01
Activator placedFishForm02
Activator placedFishForm03

ccBGSSSE001_FishTankCritterScript placedFishRef01
ccBGSSSE001_FishTankCritterScript placedFishRef02
ccBGSSSE001_FishTankCritterScript placedFishRef03

; --- Local state
int property maxFishAllowed = 3 autoreadOnly
int currentFishCount = 0
bool skipRemovalProcessing = false
bool queuedUpdate = false

Event OnActivate(ObjectReference akActionRef)
	ccBGSSSE001_fishTankRoomLeftMsg.Show(maxFishAllowed - currentFishCount)

	if fishTankActivated.GetValueInt() == 0
		fishTankFirstTimeMsg.Show()
		fishTankActivated.SetValue(1)
	endif

	self.Activate(Game.GetPlayer(), abDefaultProcessingOnly = true)

	; Wait until the player exits the container inventory.
	Wait(0.25)

	UpdateFish()
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if placeableFishList.HasForm(akBaseItem)
		if !skipRemovalProcessing
			RemoveFish(akBaseItem, aiItemCount)
			currentFishCount -= aiItemCount
		else
			skipRemovalProcessing = false
		endif
	endif
endEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if placeableFishList.HasForm(akBaseItem)
		if (aiItemCount + currentFishCount) <= maxFishAllowed
			AddFish(akBaseItem, aiItemCount)
			currentFishCount += aiItemCount
		else
			ccBGSSSE001_fishTankNoMoreRoomMsg.Show()
			skipRemovalProcessing = true
			self.RemoveItem(akBaseItem, aiItemCount, true, Game.GetPlayer())
		endif
	else
		if hostileFishList.HasForm(akBaseItem)
			ccBGSSSE001_fishTankHostileFishMsg.Show()
		else
			notAllowedFishMsg.Show()
		endif

		self.RemoveItem(akBaseItem, aiItemCount, true, Game.GetPlayer())
	endif
endEvent

Event OnLoad()
	if queuedUpdate
		queuedUpdate = false
		UpdateFish()
	endif
endEvent

Function UpdateFish()
	GoToState("UpdatingFish")

	if Is3DLoaded()
		placedFishRef01 = UpdateSingleFish(placedFishForm01, placedFishRef01, GetLinkedRef(ccBGSSSE001_FishTankMarkerKW01))
		placedFishRef02 = UpdateSingleFish(placedFishForm02, placedFishRef02, GetLinkedRef(ccBGSSSE001_FishTankMarkerKW02))
		placedFishRef03 = UpdateSingleFish(placedFishForm03, placedFishRef03, GetLinkedRef(ccBGSSSE001_FishTankMarkerKW03))	
	else
		; Run the update the next time this container loads.
		queuedUpdate = true
	endif
	
	GoToState("")
EndFunction

ccBGSSSE001_FishTankCritterScript Function UpdateSingleFish(Form targetFish, ccBGSSSE001_FishTankCritterScript placedFishRef, ObjectReference targetMarker)
	ccBGSSSE001_FishTankCritterScript returnFishRef

	if placedFishRef
		placedFishRef.StopPathing()
		placedFishRef.Disable()
		placedFishRef.Delete()
	endIf

	if targetFish
		returnFishRef = targetMarker.PlaceAtMe(targetFish) as ccBGSSSE001_FishTankCritterScript
		returnFishRef.StartPathing(targetMarker)

		while !returnFishRef.Is3DLoaded()
			Wait(0.1)
		endWhile

		returnFishRef.SetScale(0.75)

		; Random Anim Start doesn't work on this activator type, so wait some variable amount of time before
		; spawning the next fish
		Wait(RandomFloat(0.0, 0.3))
	endIf

	return returnFishRef
EndFunction

State UpdatingFish
	Function UpdateFish()
		; Do nothing
	EndFunction
EndState

Function AddFish(Form akFish, int fishCount)
	Activator fishActivator = placeableFishActivatorList.GetAt(placeableFishList.Find(akFish)) as Activator

	if !fishActivator
		return
	endif

	while fishCount > 0
		if !placedFishForm01
			placedFishForm01 = fishActivator
		elseif !placedFishForm02
			placedFishForm02 = fishActivator
		elseif !placedFishForm03
			placedFishForm03 = fishActivator
		endif
		
		fishCount -= 1
	endWhile
endFunction

Function RemoveFish(Form akFish, int fishCount)
	Activator fishActivator = placeableFishActivatorList.GetAt(placeableFishList.Find(akFish)) as Activator

	if !fishActivator
		return
	endif

	while fishCount > 0
		if placedFishForm01 == fishActivator
			placedFishForm01 = None
		elseif placedFishForm02 == fishActivator
			placedFishForm02 = None
		elseif placedFishForm03 == fishActivator
			placedFishForm03 = None
		endif
		
		fishCount -= 1
	endWhile
endFunction

function MakeFishPanic()
	if placedFishRef01
		placedFishRef01.TryToMoveToNextMarker(true)
	endif

	if placedFishRef02
		placedFishRef02.TryToMoveToNextMarker(true)
	endif

	if placedFishRef03
		placedFishRef03.TryToMoveToNextMarker(true)
	endif
endFunction