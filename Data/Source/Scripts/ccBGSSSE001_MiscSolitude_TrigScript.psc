Scriptname ccBGSSSE001_MiscSolitude_TrigScript extends ObjectReference  

Actor property PlayerRef auto
FormList property foodList auto
Quest property myQuest auto
int property myQuestStageToSet auto
Message property missingItemsMsg auto

Auto State Waiting
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		int listLength = foodList.GetSize()

		int i = 0
		while i < listLength
			if PlayerRef.GetItemCount(foodList.GetAt(i)) == 0
				missingItemsMsg.Show()
				GoToState("Waiting")
				return
			endif
			i += 1
		endWhile

		myQuest.SetStage(myQuestStageToSet)
	endEvent
endState

State Busy
	Event OnActivate(ObjectReference akActionRef)
		; Do nothing
	endEvent
endState