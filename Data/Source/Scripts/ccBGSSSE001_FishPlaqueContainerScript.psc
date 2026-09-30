scriptname ccBGSSSE001_FishPlaqueContainerScript extends Actor

ccBGSSSE001_FishPlaqueScript myPlaque

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	GoToState("Working")
	if myPlaque.IsFishDisplayed()
		ReturnItemToPlayer(akBaseItem, aiItemCount)
	else
		if aiItemCount > 1
			ReturnItemToPlayer(akBaseItem, aiItemCount - 1, false)
		endif

		myPlaque.DisplayFish(akBaseItem)
		ccBGSSSE001_FishPlaqueSuccessMsg.Show()
	endif
	GoToState("")
endevent

function SetPlaque(ccBGSSSE001_FishPlaqueScript akPlaque)
	myPlaque = akPlaque
endFunction

function ReturnItemToPlayer(Form akBaseItem, int aiAmountToReturn, bool abShowMultipleItemError = true)
	self.RemoveItem(akBaseItem, aiAmountToReturn, false)
	Game.GetPlayer().AddItem(akBaseItem, aiAmountToReturn)

	if abShowMultipleItemError
		ccBGSSSE001_FishPlaqueOnlyOneItemMsg.Show()
	endif
endFunction

state Working
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		ReturnItemToPlayer(akBaseItem, aiItemCount, false)
	endEvent
endState

Message property ccBGSSSE001_FishPlaqueOnlyOneItemMsg auto
Message property ccBGSSSE001_FishPlaqueSuccessMsg auto


