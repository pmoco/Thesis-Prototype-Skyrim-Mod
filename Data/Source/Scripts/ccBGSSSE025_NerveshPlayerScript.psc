Scriptname ccBGSSSE025_NerveshPlayerScript extends ReferenceAlias  

Quest property nerveshatterQuest auto
MiscObject property amberOre auto
MiscObject property madnessOre auto
ccBGSSSE025_NerveshQuestScript property nerveshatterQuestScript auto

Event OnInit()
	AddInventoryEventFilter(amberOre)
	AddInventoryEventFilter(madnessOre)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	checkOre(akBaseItem)
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	checkOre(akBaseItem)
endEvent

function checkOre(Form akBaseItem)
	if nerveshatterQuest.GetStageDone(10) && nerveshatterQuest.GetStage() < 30
		if akBaseItem == amberOre || akBaseItem == madnessOre
			nerveshatterQuestScript.countOre()
		endif
	endif
endFunction