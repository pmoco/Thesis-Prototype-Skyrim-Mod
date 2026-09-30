Scriptname ccBGSSSE001_MiscSol_DinnerGuestScript extends ReferenceAlias  

int property stageToWatch auto
int property stageToSetOnSit auto
Quest property myQuest auto
ReferenceAlias property myDiningChair auto

Auto State Waiting
	Event OnSit(ObjectReference akFurniture)
		; Watch for the guest sitting in the
		; dining chair during the correct stage.

		if myQuest.GetStage() == stageToWatch && akFurniture == myDiningChair.GetRef()
			GoToState("Done")
			myQuest.SetStage(stageToSetOnSit)
		endif
	endEvent
endState

State Done
	Event OnSit(ObjectReference akFurniture)
		; do nothing
	endEvent
endState
