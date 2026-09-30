scriptname Survival_HungerRestoreEffectScript extends ActiveMagicEffect

Survival_NeedHunger property Hunger auto
GlobalVariable property AmountToRestore auto
{ A global variable that stores the amount of hunger to restore. }

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Hunger.DecreaseHungerBuffered(AmountToRestore.GetValue())
EndEvent
