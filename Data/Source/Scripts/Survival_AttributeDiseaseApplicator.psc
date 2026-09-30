scriptname Survival_AttributeDiseaseApplicator extends ActiveMagicEffect

Spell property ThisDiseaseSpell auto
{ The disease to remove after the effect is dispelled. }
Spell property DiseaseToApply auto
{ The disease to remove after the effect is dispelled. }
Survival_AttributeEffectWatchScript property NeedAlias auto
{ The ReferenceAlias for the Need. }

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget
		; Clear and reapply the attribute penalty to calculate the correct disease magnitude
		NeedAlias.HandleAttributeDiseaseApply(DiseaseToApply, self, akTarget)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemoveSpell(ThisDiseaseSpell)
EndEvent
