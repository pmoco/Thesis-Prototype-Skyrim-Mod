scriptName Survival_MagicImodBeginLoopEnd extends ActiveMagicEffect
{ A modified version of magicImodBeginLoopEnd for use with Survival needs. }

float property delay = 0.0 auto
{ Time to wait before switching to constant Imod. Default: 0.0 }
ImageSpaceModifier property IntroFX auto
{ IsMod applied at the start of the spell effect. }
ImageSpaceModifier property LoopFX auto
{ Main isMod for need stage. }
ImageSpaceModifier property OutroFX auto
{ IsMod applied at the end of the spell effect. }
Float Property fImodStrength = 1.0 auto
{ IsMod Strength from 0.0 to 1.0 }

bool bIsFinishing = false

Event OnEffectStart(Actor Target, Actor Caster)
	if !HasImods()
		return
	endif

	IntroFX.remove()
	LoopFX.remove()
	OutroFX.remove()
	
	introFX.apply(fImodStrength)
	utility.wait(delay)
	
	if !bIsFinishing
		introFX.PopTo(LoopFX, fImodStrength)
	endif
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	if !HasImods()
		return
	endif

	bIsFinishing = true
	introFX.remove()
	LoopFX.PopTo(OutroFX,fImodStrength)
endEvent

bool function HasImods()
	if IntroFX && LoopFX && OutroFX
		return true
	else
		return false
	endif
endFunction