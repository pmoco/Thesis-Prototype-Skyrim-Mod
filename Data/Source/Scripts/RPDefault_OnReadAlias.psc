Scriptname RPDefault_OnReadAlias extends ReferenceAlias Hidden

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnRead()
	GoToState("Completed")
	
	Bool bTriggered = HandleRead()
		
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent

State Completed
	Event OnRead()
		; Do nothing
	EndEvent
EndState

Bool Function HandleRead()
	; Extend me
	return true
EndFunction