Scriptname RPDefault_OnAggroAlias extends ReferenceAlias Hidden

Bool Property bPlayerOnly = false auto
{ Set to true if only combat with the player or their companions/summons should trigger this }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	GoToState("TestingCombatState")
	
	Bool bTriggered = false
	if(aeCombatState == 1)
		if( ! bPlayerOnly || akTarget == Game.GetPlayer() || akTarget.IsPlayerTeammate())
			; Correct person was the target
			bTriggered = HandleCombatStateChanged(akTarget, aeCombatState)
		endif
	endif
	
	if(bTriggered && bOnlyTriggerOnce)
		GoToState("Completed")
	else
		GoToState("")
	endif
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	GoToState("TestingOnHit")
	
	Bool bTriggered = false
	if( ! bPlayerOnly || akAggressor == Game.GetPlayer() || (akAggressor as Actor).IsPlayerTeammate())
		; Correct person hit
		bTriggered = HandleHit(akAggressor, akSource, akProjectile, abPowerAttack, abSneakAttack, abBashAttack, abHitBlocked)
	endif
	
	if(bTriggered && bOnlyTriggerOnce)
		GoToState("Completed")
	else
		GoToState("")
	endif
EndEvent

State TestingCombatState
	Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	EndEvent
EndState

State TestingOnHit
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	EndEvent
EndState

State Completed	
	Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	EndEvent
EndState

Bool Function HandleCombatStateChanged(Actor akTarget, int aeCombatState)
	; Extend Me
	
	return HandleAggro()
EndFunction

Bool Function HandleHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Extend Me
	
	return HandleAggro()
EndFunction

Bool Function HandleAggro()
	; Extend Me
	return true
EndFunction