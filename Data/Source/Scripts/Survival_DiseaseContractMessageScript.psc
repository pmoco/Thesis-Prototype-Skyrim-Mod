scriptname Survival_DiseaseContractMessageScript extends ActiveMagicEffect

Message property DiseaseMessage auto
{ The message to display when contracting this disease. }
Spell property DiseaseSpell auto
{ The disease to remove after the effect is dispelled. }
bool property ProgressibleDisease auto
{ Whether this disease progresses or not. }
bool property AffectsAttribute auto
{ Whether this disease affects an attribute (Health, Magicka, Stamina). }
Survival_AttributeEffectWatchScript property NeedAlias auto
{ The ReferenceAlias for the Need. }
Spell property DiseaseToProgressInto auto
{ The disease that this disease progresses into. }
GlobalVariable property Survival_DiseaseProgressionSpeed auto
{ How quickly this disease progresses, in hours. }

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if DiseaseMessage
		DiseaseMessage.Show()
	endif
	if ProgressibleDisease
		RegisterForSingleUpdateGameTime(Survival_DiseaseProgressionSpeed.GetValueInt())
	endif
EndEvent

Event OnUpdateGameTime()
	Actor target = self.GetTargetActor()
	if target
		if AffectsAttribute
			NeedAlias.HandleAttributeDiseaseApply(DiseaseToProgressInto, self, target)
		else
			self.Dispel()
			target.AddSpell(DiseaseToProgressInto, false)
		endif
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if DiseaseSpell
		akTarget.RemoveSpell(DiseaseSpell)
	endif
EndEvent
