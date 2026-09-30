scriptname Survival_DiseaseTrackedStatsEvent extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Game.IncrementStat("Diseases Contracted")
EndEvent
