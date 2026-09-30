scriptname Survival_WarmUpWhenStandingScript extends ActiveMagicEffect

Survival_MovementUIUpdateScript property movement auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	movement.EffectStarted()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	movement.EffectFinished()
EndEvent
