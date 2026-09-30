Scriptname ccBGSSSE001_SpeedEnchScript extends ActiveMagicEffect  

function ForceMovementSpeedUpdate(Actor akTarget)
    akTarget.DamageActorValue("CarryWeight", 0.1)
    akTarget.RestoreActorValue("CarryWeight", 0.1)
endFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ForceMovementSpeedUpdate(akTarget)
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ForceMovementSpeedUpdate(akTarget)
endEvent