Scriptname RPDefault_FerryPlayerSeatAlias extends ReferenceAlias  
{ watch for player to sit in ferry}

Event OnActivate(ObjectReference akActionRef)
	if(akActionRef == Game.GetPlayer())
		RPDefault_FerrySystem FerryQuest = GetOwningQuest() as RPDefault_FerrySystem
		
		Clear()
		
		Bool bSuccess = FerryQuest.HandlePlayerSat()
	endif
endEvent

Event OnUnload()
	RPDefault_FerrySystem FerryQuest = GetOwningQuest() as RPDefault_FerrySystem
	FerryQuest.ClearWaitingState()
endEvent
