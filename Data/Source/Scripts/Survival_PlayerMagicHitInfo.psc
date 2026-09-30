scriptname Survival_PlayerMagicHitInfo extends ReferenceAlias

import Survival_GlobalFunctions

Survival_NeedCold property Cold auto
Actor property PlayerRef auto
Keyword property MagicDamageFrost auto
Keyword property MagicDamageFire auto
FormList property Survival_FrostbitePoisonEffects auto
float amountToChangeColdOnSpellHit = 30.0
GlobalVariable property Survival_ColdNeedValue auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	GoToState("")
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	GoToState("Processing")
	if akEffect.HasKeyword(MagicDamageFrost)
		GetColderFromSpellHit(amountToChangeColdOnSpellHit)
	elseif akEffect.HasKeyword(MagicDamageFire)
		GetWarmerFromSpellHit(amountToChangeColdOnSpellHit)
	elseif Survival_FrostbitePoisonEffects.HasForm(akEffect)
		GetColderFromSpellHit(amountToChangeColdOnSpellHit)
	endif
	Utility.Wait(2.0)
	GoToState("")
EndEvent

function GetColderFromSpellHit(float amount)
	if Survival_ColdNeedValue.GetValue() < Cold.needStage4Value
		SurvivalLogMessage("{{INFO}} Hit by frost attack or frostbite poison, get colder.")
		Cold.IncreaseCold(amount, Cold.needStage4Value)
	endif
endFunction

function GetWarmerFromSpellHit(float amount)
	if Survival_ColdNeedValue.GetValue() > Cold.needStage2Value
		SurvivalLogMessage("{{INFO}} Hit by fire attack, get warmer.")
		Cold.DecreaseCold(amount, Cold.needStage2Value, true)
	endif
endFunction

State Processing
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	EndEvent
endState