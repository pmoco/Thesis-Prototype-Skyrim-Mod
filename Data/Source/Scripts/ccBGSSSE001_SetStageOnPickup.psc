Scriptname ccBGSSSE001_SetStageOnPickup extends ReferenceAlias  

Quest property myQuest auto
int property stageToSet auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akNewContainer == Game.GetPlayer()
		GoToState("done")
		myQuest.SetStage(stageToSet)
	endif
endEvent

State done
	Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
		; do nothing
	endEvent
endState