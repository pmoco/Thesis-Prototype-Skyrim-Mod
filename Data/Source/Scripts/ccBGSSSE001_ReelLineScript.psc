scriptname ccBGSSSE001_ReelLineScript extends ObjectReference

ccBGSSSE001_FishingSystemScript property FishingSystem auto

Auto State Waiting
	Event OnActivate(ObjectReference akActivatorRef)
		GoToState("Busy")
		if akActivatorRef == Game.GetPlayer()
			FishingSystem.OnFishingTriggerActivated()
		endif
		GoToState("Waiting")
	endEvent
endState

State Busy
	; Do nothing
endState

function ReturnToOrigin()
	self.MoveTo(self.GetLinkedRef())
EndFunction
