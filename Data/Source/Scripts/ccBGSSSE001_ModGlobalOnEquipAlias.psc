Scriptname ccBGSSSE001_ModGlobalOnEquipAlias extends ReferenceAlias

GlobalVariable property myGlobal auto

ReferenceAlias myItemAliasToCheck

function SetInventoryFilter(ReferenceAlias akAliasToCheck)
	; Set explicitly as the alias may not be filled when this object initalizes.
	myItemAliasToCheck = akAliasToCheck
	AddInventoryEventFilter(akAliasToCheck.GetRef())
endFunction

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if myItemAliasToCheck && akReference == myItemAliasToCheck.GetRef()
		myGlobal.Mod(1.0)
	endif
endEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if myItemAliasToCheck && akReference == myItemAliasToCheck.GetRef()
		myGlobal.Mod(-1.0)
	endif
endEvent