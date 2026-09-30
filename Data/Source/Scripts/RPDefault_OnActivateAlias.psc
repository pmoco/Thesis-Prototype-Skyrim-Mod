Scriptname RPDefault_OnActivateAlias extends ReferenceAlias Hidden


Bool Property bPlayerOnly = true auto
{ Set to false if NPCs activating the item should also trigger the stage change. }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnActivate(ObjectReference akActivatedBy)
	GoToState("Completed")
	
	Bool bTriggered = false
	if( ! bPlayerOnly || akActivatedBy == Game.GetPlayer())
		; Correct person activated
		bTriggered = HandleActivate(akActivatedBy)
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent

State Completed
	Event OnActivate(ObjectReference akActivatedBy)
		; Do nothing
	EndEvent
EndState

Bool Function HandleActivate(ObjectReference akActivatedBy)
	; Extend Me
	return true
EndFunction