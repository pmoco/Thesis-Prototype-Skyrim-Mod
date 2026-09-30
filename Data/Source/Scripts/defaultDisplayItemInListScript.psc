scriptname defaultDisplayItemInListScript extends ObjectReference

Actor property PlayerRef auto

FormList property itemsToDisplay auto
{ The FormList whose item(s) to display. }

Message property ItemNotInInventoryMessage auto
{ The message to display if the item is not in the player's inventory. }

Keyword property LinkedMarkerKeyword auto
{ The keyword of the linked marker reference. }

int MAX_3D_CHECK = 30

State Busy
	Event OnActivate(ObjectReference akActionRef)
	endEvent
endState

Event OnActivate(ObjectReference akActionRef)
	if akActionRef == PlayerRef
		GoToState("Busy")
		if !IsOneOfItemsOnDisplay()
			; Display the first unique item found in the array, if the player has it.
			int size = itemsToDisplay.GetSize()

			int i = 0
			bool itemFound = false
			while i < size && !itemFound
				Form item = itemsToDisplay.GetAt(i)
				if PlayerRef.GetItemCount(item) > 0
					DisplayItem(item)
					itemFound = true
				endif
				i += 1
			endWhile

			if !itemFound
				; If the player doesn't have any of the items, and 
				; none of them are already on display, show an error.
				ItemNotInInventoryMessage.Show()
			endif
		endif
		GoToState("")
	endif
EndEvent

function DisplayItem(Form akItem)
	ObjectReference theItem = PlayerRef.DropObject(akItem)
	theItem.BlockActivation()
	PositionItemAndDisablePhysics(theItem)
	theItem.BlockActivation(false)
endFunction

function PositionItemAndDisablePhysics(ObjectReference akItemOnDisplayRef)
	if akItemOnDisplayRef
		int i = 0
		while !akItemOnDisplayRef.Is3DLoaded() && i < MAX_3D_CHECK
			i += 1
			Utility.Wait(0.1)
		endWhile

		if i < MAX_3D_CHECK
			; Place the item.
			akItemOnDisplayRef.SetMotionType(Motion_Keyframed, false)
			ObjectReference triggerMarker = GetLinkedRef(LinkedMarkerKeyword)
			akItemOnDisplayRef.MoveTo(triggerMarker)
		else
			; We failed to load the 3D for this item, abort.
			PlayerRef.AddItem(akItemOnDisplayRef)
		endif
	endif
endFunction

bool function IsOneOfItemsOnDisplay()
	return Game.FindClosestReferenceOfAnyTypeInListFromRef(itemsToDisplay, GetLinkedRef(LinkedMarkerKeyword), 32.0)
endFunction
