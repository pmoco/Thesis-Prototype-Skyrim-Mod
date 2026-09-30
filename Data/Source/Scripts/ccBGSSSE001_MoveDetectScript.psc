scriptname ccBGSSSE001_MoveDetectScript extends ObjectReference

ccBGSSSE001_FishingSystemScript property FishingSystem auto

Auto State Waiting
	Event OnTriggerLeave(ObjectReference akActionRef)
		if akActionRef == Game.GetPlayer()
			FishingSystem.OnPlayerMoveAway()
		endif
	endEvent
endState

State Ignoring
	Event OnTriggerLeave(ObjectReference akActionRef)
		; Do nothing
	endEvent
endState

function IgnoreTriggerEvents(bool abIgnore = true)
	if abIgnore
		GoToState("Ignoring")
	else
		GoToState("Waiting")
	endif
endFunction