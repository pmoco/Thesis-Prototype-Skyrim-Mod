Scriptname ccBGS_ARBladeTrapScript extends MovingTrap
{Shared script for Ayleid Blade Traps. Inherits from MovingTrap.}

;PLEASE NOTE: This inherits from MovingTrap, so some of the functions and states are overrides dictated by that script

Bool FinishedPlaying = False

Auto State Waiting
	;Activated by external activate parent e.g. trigger box.
	Event OnActivate(ObjectReference akActionRef)
		GoToState("TrapActive")
		FireTrap()
	EndEvent
EndState

State TrapActive
EndState

Function FireTrap()
	ResolveLeveledDamage()
	isFiring = True
	RegisterForAnimationEvent(self, "DamageStart")
	RegisterForAnimationEvent(self, "DamageEnd")
	PlayAnimation("Stage2ReturnStage1") ;begin animation (looping)
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If(asEventName == "DamageStart")
		hitBase.goToState("CanHit")
	ElseIf(asEventName == "DamageEnd")
		hitBase.goToState("CannotHit")
	EndIf
EndEvent

Function ResetTrap()
	isFiring = False
	hitBase.goToState("CannotHit")
	GoToState("Waiting")
	PlayAnimation("reset")
EndFunction

Event OnReset()
	ResetTrap()
EndEvent