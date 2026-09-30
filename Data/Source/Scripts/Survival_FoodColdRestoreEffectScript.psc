scriptname Survival_FoodColdRestoreEffectScript extends ActiveMagicEffect

Survival_NeedCold property Cold auto
GlobalVariable property AmountToRestore auto
{ A global variable that stores the amount of hunger to restore. }

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Cold.DecreaseCold(AmountToRestore.GetValue(), Cold.needStage1Value)
EndEvent