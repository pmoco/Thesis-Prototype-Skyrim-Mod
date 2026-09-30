scriptname ccBGSSSE001_FishTankHitScript extends ObjectReference

Auto State Waiting
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		GoToState("Hit")
		(self.GetLinkedRef() as ccBGSSSE001_FishTankContainerScript).MakeFishPanic()
		GoToState("Waiting")
	endEvent
endState

State Hit
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; Do nothing
	endEvent
endState