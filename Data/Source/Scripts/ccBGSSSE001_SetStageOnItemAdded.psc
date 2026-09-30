Scriptname ccBGSSSE001_SetStageOnItemAdded extends ReferenceAlias  

Quest property myQuest auto
{ The quest to set the stage on. }
int property stageToSet auto
{ The stage to set on the quest. }
int property requiredStage auto
{ The stage that must be set in order for the set stage to process. }
FormList property questItems auto
{ The item(s), that when added, cause the stage to be set. }

Event OnInit()
	AddInventoryEventFilter(questItems)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if questItems.Find(akBaseItem) > -1 && myQuest.GetStage() == requiredStage
		myQuest.SetStage(stageToSet)
	endif
endEvent