Scriptname ccBGSSSE001_FishingMapScript extends ObjectReference  
{ Displays objectives to navigate the player to fishing spots when this item is picked up. }

Actor property PlayerRef auto

int property objectiveId auto
{ The objective ID for this Hold. }

Book property thisMap auto
{ This item. }

Quest property ccBGSSSE001_FishingMapQuest auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akOldContainer == PlayerRef
		if PlayerRef.GetItemCount(thisMap) == 0
			ccBGSSSE001_FishingMapQuest.SetObjectiveDisplayed(objectiveId, false)
		endif
	elseif akNewContainer == PlayerRef
		if !ccBGSSSE001_FishingMapQuest.IsObjectiveDisplayed(objectiveId)
			ccBGSSSE001_FishingMapQuest.SetObjectiveDisplayed(objectiveId, true, abForce = true)
		endif
	endif
endEvent
