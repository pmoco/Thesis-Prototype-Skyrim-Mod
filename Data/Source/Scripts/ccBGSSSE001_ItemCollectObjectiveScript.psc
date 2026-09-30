Scriptname ccBGSSSE001_ItemCollectObjectiveScript extends ReferenceAlias
{ Script that tracks the collection of multiple objective items for a quest. Used by numerous fishing quests. }

Actor property PlayerRef auto
FormList property questItems auto
{ The list of items to obtain for this quest. }
Quest property myQuest auto
{ This quest. }
GlobalVariable[] property optCountGlobals auto
{ Optional: The text replacement count globals for each quest item. }
GlobalVariable[] property optTotalGlobals auto
{ Optional: The text replacement totals globals for each quest item. }
int property hasAllItemsObjective auto
{ The objective to display once the player has collected all of the required fish. }
int property readNoteStage auto
{ The quest stage set after the player has read the quest bounty / note, so we know to begin tracking items. }
int property givenItemsStage auto
{ The quest stage set once the player has turned in the quest fish. }
int property auxObjective = -1 auto
{ An optional auxiliary objective of this quest. }

bool working = false

Event OnInit()
	AddInventoryEventFilter(questItems)
endEvent

function DisplayAllObjectives()
	while working
		Utility.Wait(0.1)
	endWhile
	working = true

	if auxObjective > -1
		myQuest.SetObjectiveDisplayed(auxObjective)
	endif

	UpdateObjectivesFirstTime()

	working = false
endFunction

function CompleteAuxObjective()
	if auxObjective > -1
		myQuest.SetObjectiveCompleted(auxObjective)
	endif

	CheckFinalObjective()
endFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	OnItemAddedOrRemoved(akBaseItem)
endEvent



Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	OnItemAddedOrRemoved(akBaseItem)
endEvent

function OnItemAddedOrRemoved(Form akBaseItem)
	int currentStage = myQuest.GetStage()
	if currentStage >= readNoteStage && currentStage < givenItemsStage
		while working
			Utility.Wait(0.1)
		endWhile
		working = true

		TrackedItemChanged(akBaseItem)

		working = false
	endif
endFunction

function UpdateObjectivesFirstTime()
	int objectiveLength = questItems.GetSize()
	int i = 0
	while i < objectiveLength
		Form theItem = questItems.GetAt(i)
		int itemCount = PlayerRef.GetItemCount(theItem)
		if itemCount > 0
			TrackedItemChanged(theItem)
		else
			myQuest.SetObjectiveDisplayed(i)
		endif

		i += 1
	endWhile

	CheckFinalObjective()
endFunction

function CheckFinalObjective()
	bool allObjectivesComplete = true

	bool hasAuxObjective = auxObjective > -1
	bool auxObjectiveComplete = true
	if hasAuxObjective && !myQuest.IsObjectiveCompleted(auxObjective)
		auxObjectiveComplete = false
	endif

	int i = 0
	while i < questItems.GetSize() && allObjectivesComplete
		if !myQuest.IsObjectiveCompleted(i)
			allObjectivesComplete = false
		endif
		i += 1
	endWhile

	if allObjectivesComplete && (!hasAuxObjective || auxObjectiveComplete)
		myQuest.SetObjectiveDisplayed(hasAllItemsObjective)
	else
		myQuest.SetObjectiveDisplayed(hasAllItemsObjective, false)
	endif
endFunction

function TrackedItemChanged(Form akItem)
	int idx = questItems.Find(akItem)
	int newValue = PlayerRef.GetItemCount(akItem)
	int totalValue = 1

	if optCountGlobals.length > 0 && optTotalGlobals.length > 0
		GlobalVariable itemCountGlobal = optCountGlobals[idx]
		itemCountGlobal.SetValueInt(newValue)
		myQuest.UpdateCurrentInstanceGlobal(itemCountGlobal)
		totalValue = optTotalGlobals[idx].GetValueInt()
	endif

	if newValue >= totalValue && !myQuest.IsObjectiveCompleted(idx)
		if !myQuest.IsObjectiveDisplayed(idx)
			myQuest.SetObjectiveDisplayed(idx)
		endif
		myQuest.SetObjectiveCompleted(idx)
	elseif newValue < totalValue
		if myQuest.IsObjectiveCompleted(idx)
			myQuest.SetObjectiveCompleted(idx, false)
			myQuest.SetObjectiveDisplayed(idx, abForce = true)
		else
			myQuest.SetObjectiveDisplayed(idx, abForce = true)
		endif
	endif

	CheckFinalObjective()
endFunction
