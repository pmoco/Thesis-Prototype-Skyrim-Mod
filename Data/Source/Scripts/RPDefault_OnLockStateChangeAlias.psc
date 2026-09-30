Scriptname RPDefault_OnLockStateChangeAlias extends ReferenceAlias Hidden


Bool Property bOnLock = false auto
{ Set to true if detecting when this becomes locked instead }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnLockStateChanged()
	GoToState("Completed")
	
	Bool bTriggered = false
	if(GetRef().IsLocked() == bOnLock)
		; Correct lockstate state
		bTriggered = HandleLockStateChanged()
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent

State Completed
	Event OnLockStateChanged()
		; Do nothing
	EndEvent
EndState

Bool Function HandleLockStateChanged()
	; Extend me
	return true
EndFunction