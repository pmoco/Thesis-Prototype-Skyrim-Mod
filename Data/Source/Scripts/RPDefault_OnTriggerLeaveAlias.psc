Scriptname RPDefault_OnTriggerLeaveAlias extends ReferenceAlias Hidden

Bool Property bPlayerOnly = true auto
{ Set to true to only trigger if the player was who entered the trigger }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }


Event OnTriggerLeave(ObjectReference akActionRef)
	GoToState("Completed")
	
	bool bTriggered = false
	if(akActionRef as Actor)
		if( ! bPlayerOnly || akActionRef == Game.GetPlayer())
			bTriggered = HandleTriggerLeave(akActionRef)
		endif
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent

State Completed
	Event OnTriggerLeave(ObjectReference akActionRef)
		; Do nothing
	EndEvent
EndState

Bool Function HandleTriggerLeave(ObjectReference akActionRef)
	; Extend me
	return true
EndFunction