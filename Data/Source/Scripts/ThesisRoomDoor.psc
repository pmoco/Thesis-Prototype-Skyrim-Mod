Scriptname ThesisRoomDoor extends ObjectReference  


ThesisRoomController Property Controller Auto

bool Property bMoveForward =  True  Auto 



Event OnActivate(ObjectReference akActionRef)

    if (akActionRef == Game.GetPlayer())
	ObjectReference 	nextRoom 

	if (bMoveForward )
        	nextRoom = Controller.GetNextRoom()
	else 
		nextRoom = Controller.GetPrevRoom()
	EndIf 
	if (nextRoom)		
		Debug.Notification( Controller.GetCurrentIndex())
           	Game.GetPlayer().MoveTo(nextRoom)
       endif

    endif

EndEvent
