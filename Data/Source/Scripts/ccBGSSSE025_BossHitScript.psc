Scriptname ccBGSSSE025_BossHitScript extends ReferenceAlias  

Quest property BossQuest auto
ccBGSSSE025_BossControllerScript property BossScript auto

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if aeCombatState == 0
		BossScript.OnBossExitCombat()
	elseif aeCombatState == 1
		BossScript.OnBossEnterCombat()
	endif
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	GoToState("Done")
	BossQuest.SetStage(30)
endEvent

State Done
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	endEvent
endState