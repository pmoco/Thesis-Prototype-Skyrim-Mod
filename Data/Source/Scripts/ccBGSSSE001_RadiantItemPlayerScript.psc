Scriptname ccBGSSSE001_RadiantItemPlayerScript extends ReferenceAlias  

ccBGSSSE001_RadiantItemQuest property myQuest auto

Form itemToWatch = None

function SetPlayerInventoryEventFilter(Form akFormToFilter)
	itemToWatch = akFormToFilter
	AddInventoryEventFilter(akFormToFilter)
endFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == itemToWatch
		myQuest.RadiantItemAdded(aiItemCount)
	endif
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if akBaseItem == itemToWatch
		myQuest.RadiantItemRemoved(aiItemCount)
	endif
endEvent