scriptname Survival_ResistDiseaseWatchScript extends ReferenceAlias

MagicEffect property AbResistDisease auto

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	if akEffect == AbResistDisease
		(self.GetOwningQuest() as Survival_NeedExhaustion).SelectCorrectEffects()
	endif
EndEvent