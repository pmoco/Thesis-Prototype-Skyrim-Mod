Scriptname RPDefault_CarriagePlayerSeatAlias extends ReferenceAlias  
{ watch for player to sit in carriage}

Event OnActivate(ObjectReference akActionRef)
	GoToState("ActivationInProgress")
	
	if(akActionRef == Game.GetPlayer())
; 		debug.trace(self + " OnActivate " + akActionRef)
		RPDefault_CarriageSystem CarriageQuest = GetowningQuest() as RPDefault_CarriageSystem
		
		Clear()
		
		Bool bSuccess = CarriageQuest.HandlePlayerSat()
	endif
	
	GoToState("")
endEvent

event OnUnload()
; 	debug.trace(self + " current carriage unloading - clear waiting state")
	RPDefault_CarriageSystem CarriageQuest = GetowningQuest() as RPDefault_CarriageSystem
	CarriageQuest.ClearWaitingState()
endEvent


State ActivationInProgress
	Event OnActivate(ObjectReference akActionRef)
	EndEvent
EndState