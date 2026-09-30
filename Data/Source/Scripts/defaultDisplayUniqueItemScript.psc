scriptname defaultDisplayUniqueItemScript extends ObjectReference

Actor property PlayerRef auto

Armor property optArmorToDisplay auto
{ Choose one 'opt' property to fill. The Armor to display. }
Weapon property optWeaponToDisplay auto
{ Choose one 'opt' property to fill. The Weapon to display. }
MiscObject property optMiscObjectToDisplay auto
{ Choose one 'opt' property to fill. The MiscObject to display. }
Book property optBookToDisplay auto
{ Choose one 'opt' property to fill. The Book to display. }

Message property ItemNotInInventoryMessage auto
{ The message to display if the item is not in the player's inventory. }

Keyword property LinkedMarkerKeyword auto
{ The keyword of the linked marker reference. }


Event OnActivate(ObjectReference akActionRef)
	if akActionRef == PlayerRef
		Form itemToDisplay = GetDisplayItem()

		if PlayerRef.GetItemCount(itemToDisplay) > 0
			; If the player has the item, place it.
			DisplayItem(itemToDisplay)
		else
			; If the player doesn't have the item, and 
			; it's not already on display, show an error.
			if !IsItemOnDisplay(itemToDisplay)
				ItemNotInInventoryMessage.Show()
			endif
		endif
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
		while !akItemOnDisplayRef.Is3DLoaded()
			Utility.Wait(0.1)
		endWhile

		akItemOnDisplayRef.SetMotionType(Motion_Keyframed, false)
		ObjectReference triggerMarker = GetLinkedRef(LinkedMarkerKeyword)
		akItemOnDisplayRef.MoveTo(triggerMarker)
	endif
endFunction

Form function GetDisplayItem()
	if optArmorToDisplay
		return optArmorToDisplay
	elseif optWeaponToDisplay
		return optWeaponToDisplay
	elseif optMiscObjectToDisplay
		return optMiscObjectToDisplay
	elseif optBookToDisplay
		return optBookToDisplay
	endif
endFunction

bool function IsItemOnDisplay(Form akItem)
	return Game.FindClosestReferenceOfTypeFromRef(akItem, GetLinkedRef(LinkedMarkerKeyword), 32.0)
endFunction
