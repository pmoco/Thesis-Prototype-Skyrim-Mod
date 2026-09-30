Scriptname ccBGSSSE001_PlayerTrackedCatches extends ReferenceAlias  

ReferenceAlias[] property trackedItemAliases auto
{ The aliases to fill (in order) when the tracked item is caught. }
int[] property trackedItemCaughtStages auto
{ Optional: The stages to set (in order) when a tracked item is caught. }


GlobalVariable property trackedItemsCaughtCountGlobal auto
{ The global that tracks the amount of tracked items we've caught in the quest objective. }
GlobalVariable property trackedItemsCaughtTotalGlobal auto
{ The global that tracks the total amount of tracked items to catch in the quest objective. }
GlobalVariable property allTrackedItemsCaughtGlobal auto
{ The global to set to 1 once all tracked items have been caught (to prevent further catches). }

int property trackedItemObjective auto
{ The objective ID that displays when a tracked item is caught. }
int property allTrackedItemsCaughtStage = -1 auto
{ Optional: Set if we should set a stage once all tracked items have been caught. Default: -1 }
Quest property myQuest auto
{ The quest associated with these objectives and items. }

Event OnInit()
	AddInventoryEventFilter(GetTrackedItem())
endEvent

Auto State ready
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		GoToState("working")
		Form trackedItem = GetTrackedItem()
		if akBaseItem == trackedItem
			if myQuest.ModObjectiveGlobal(1.0, trackedItemsCaughtCountGlobal, trackedItemObjective, trackedItemsCaughtTotalGlobal.GetValue())
				allTrackedItemsCaughtGlobal.SetValueInt(1)
				if allTrackedItemsCaughtStage > -1
					myQuest.SetStage(allTrackedItemsCaughtStage)
				endif
			endif

			int i = 0
			bool exitLoop = false
			while i < trackedItemAliases.Length && !exitLoop
				if trackedItemAliases[i].GetRef() == None
					if trackedItemCaughtStages && trackedItemCaughtStages[i] >= 0
						myQuest.SetStage(trackedItemCaughtStages[i])
					endif
					GivePlayerAliasQuestItem(trackedItem, trackedItemAliases[i])
					exitLoop = true
				endif
				i += 1
			endWhile
		endif
		GoToState("ready")
	endEvent
endState

function GivePlayerAliasQuestItem(Form trackedItem, ReferenceAlias trackedItemAlias)
	Actor player = self.GetActorRef()
	player.RemoveItem(trackedItem, 1, true)
	ObjectReference trackedItemRef = player.PlaceAtMe(trackedItem)
	trackedItemAlias.ForceRefTo(trackedItemRef)
	player.AddItem(trackedItemRef, 1, true)
endFunction

Form function GetTrackedItem()
	; EXTEND
	return none
endFunction

State working
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		; Do nothing
	endEvent
endState