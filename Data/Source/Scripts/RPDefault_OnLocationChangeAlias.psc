Scriptname RPDefault_OnLocationChangeAlias extends ReferenceAlias Hidden

Bool Property bLocationEnter = true auto
{ Set to false if this should trigger when they leave this location }

Location Property LocationToWatch auto
{ The location to monitor for the actor entering or leaving }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	GoToState("Completed")
	
	bool bTriggered = false
	if(LocationToWatch == None || (bLocationEnter && akNewLoc == LocationToWatch) || ( ! bLocationEnter && akOldLoc == LocationToWatch))
		; Correct location state
		bTriggered = HandleLocationChange(akOldLoc, akNewLoc)
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
endEvent

State Completed
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		; Do nothing
	EndEvent
EndState

Bool Function HandleLocationChange(Location akOldLoc, Location akNewLoc)
	; Extend me
	return true
EndFunction