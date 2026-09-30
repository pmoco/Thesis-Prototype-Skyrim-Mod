Scriptname ccBGSSSE025_SaintsSeducersFX extends ActiveMagicEffect  

EffectShader property UnsummonDeathFXS auto

Actor selfRef

Event OnEffectStart(Actor Target, Actor Caster)
	selfRef = Caster
endEvent

Event OnDying(Actor akKiller)
	UnsummonDeathFXS.Play(selfRef)
endEvent
