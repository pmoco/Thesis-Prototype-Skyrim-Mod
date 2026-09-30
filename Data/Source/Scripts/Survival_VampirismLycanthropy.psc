scriptname Survival_VampirismLycanthropy extends ReferenceAlias

import Survival_GlobalFunctions

Survival_NeedHunger property Hunger auto
Survival_NeedExhaustion property Exhaustion auto
FormList property Survival_SurvivalDiseases auto

Event OnLycanthropyStateChanged(bool abIsWerewolf)
	SurvivalLogMessage("OnLycanthropyStateChanged " + abIsWerewolf)
	if abIsWerewolf
		RemoveSurvivalDiseases()
	endif
	Exhaustion.SelectCorrectEffects()
EndEvent

Event OnVampirismStateChanged(bool abIsVampire)
	SurvivalLogMessage("OnVampirismStateChanged " + abIsVampire)
	if abIsVampire
		RemoveSurvivalDiseases()
	endif
	Exhaustion.SelectCorrectEffects()
EndEvent

Event OnVampireFeed(Actor akTarget)
	SurvivalLogMessage("{{HUNGER}} Decreasing Hunger due to vampire feeding.")
	Hunger.DecreaseHungerLarge()
EndEvent

function RemoveSurvivalDiseases()
	Actor playerRef = self.GetActorRef()
	int i = 0
	while i < Survival_SurvivalDiseases.GetSize()
		playerRef.RemoveSpell(Survival_SurvivalDiseases.GetAt(i) as Spell)
		i += 1
	endWhile
endFunction