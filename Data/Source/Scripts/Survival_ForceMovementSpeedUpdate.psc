scriptname Survival_ForceMovementSpeedUpdate extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ForceMovementSpeedUpdate(akTarget)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ForceMovementSpeedUpdate(akTarget)
EndEvent

function ForceMovementSpeedUpdate(Actor akTarget)
	akTarget.DamageActorValue("CarryWeight", 0.1)
	akTarget.RestoreActorValue("CarryWeight", 0.1)
endFunction