scriptname Survival_RidingDragonDetectorScript extends ActiveMagicEffect

import Survival_GlobalFunctions

Survival_ConditionsScript property conditions auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	conditions.isRidingDragon = true
	SurvivalLogMessage("Now riding a dragon.")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	conditions.isRidingDragon = false
	SurvivalLogMessage("No longer riding a dragon.")
EndEvent