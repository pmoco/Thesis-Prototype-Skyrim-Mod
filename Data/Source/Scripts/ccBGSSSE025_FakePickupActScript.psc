Scriptname ccBGSSSE025_FakePickupActScript extends ObjectReference  

Weapon property weaponToPickup auto
Actor property PlayerRef auto
Quest property myQuest auto
int property myStageToSet auto

Auto State Waiting
	Event OnActivate(ObjectReference akActionRef)
		if akActionRef == PlayerRef
			GoToState("Done")
			self.Disable()
			self.Delete()
			PlayerRef.AddItem(weaponToPickup, 1)
			myQuest.SetStage(myStageToSet)
		endif
	endEvent
endState

State Done
	Event OnActivate(ObjectReference akActionRef)
		; do nothing
	endEvent
endState