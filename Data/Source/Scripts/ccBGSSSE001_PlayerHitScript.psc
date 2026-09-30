Scriptname ccBGSSSE001_PlayerHitScript extends ReferenceAlias

ccBGSSSE001_FishingSystemScript property FishingSystem auto

State Waiting
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		GoToState("Hit")
		FishingSystem.OnPlayerHit()
		GoToState("Waiting")
	endEvent
endState

State Hit
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; Do nothing
	endEvent
endState
