Scriptname RPDefault_OnContainerChangedAlias extends ReferenceAlias Hidden

ObjectReference Property SpecificOldContainer Auto
{ If set, it will only trigger if removed from this container. If monitoring for the player to deposit this item, place Player here. }

ObjectReference Property SpecificNewContainer Auto
{ If set, it will only trigger if placed in this container. If monitoring for the player to loot this item, place Player here. }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	GoToState("Completed")
	
	Bool bTriggered = false
	if(SpecificOldContainer == None || akOldContainer == SpecificOldContainer)
		; Correct person deposited item
		if(akNewContainer != None && (SpecificNewContainer == None || akNewContainer == SpecificNewContainer))
			; Moved to correct container
			bTriggered = HandleContainerChanged(akNewContainer, akOldContainer)
		endif
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")		
	endif
EndEvent

State Completed
	Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
		; Do nothing
	EndEvent
EndState

Bool Function HandleContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	; Extend me
	return true
EndFunction