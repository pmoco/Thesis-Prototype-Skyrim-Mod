Scriptname ccBGSSSE025_NerveshQuestScript extends Quest  

Actor property PlayerRef auto
GlobalVariable property amberCountGlobal auto
GlobalVariable property madnessCountGlobal auto
Quest property nerveshatterQuest auto
MiscObject property amberOre auto
MiscObject property madnessOre auto
ObjectReference property offerTriggerRef auto

Function countOre()
	int amberCount = countOreByTypeAndUpdateQuest(amberOre, amberCountGlobal, 20)
	int madnessCount = countOreByTypeAndUpdateQuest(madnessOre, madnessCountGlobal, 21)

	; Quest
	if madnessCount >= 1 && amberCount >= 1
		nerveshatterQuest.SetObjectiveDisplayed(30, true, true)
		offerTriggerRef.EnableNoWait()
	else
		nerveshatterQuest.SetObjectiveDisplayed(30, false)
		offerTriggerRef.DisableNoWait()
	endif
endFunction

int function countOreByTypeAndUpdateQuest(MiscObject ore, GlobalVariable oreCountGlobal, int objectiveToUpdate)
	int oreCount = PlayerRef.GetItemCount(ore)
	oreCountGlobal.SetValueInt(oreCount)
	UpdateCurrentInstanceGlobal(oreCountGlobal)

	if oreCount >= 1
		nerveshatterQuest.SetObjectiveCompleted(objectiveToUpdate, true)
	else
		nerveshatterQuest.SetObjectiveCompleted(objectiveToUpdate, false)
		nerveshatterQuest.SetObjectiveDisplayed(objectiveToUpdate, true, true)
	endif

	return oreCount
endFunction
