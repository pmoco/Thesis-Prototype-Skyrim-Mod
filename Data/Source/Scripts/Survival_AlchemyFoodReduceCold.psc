scriptname Survival_AlchemyFoodReduceCold extends ActiveMagicEffect

Survival_NeedCold property Cold auto
float property amount auto
{ The amount to reduce cold by. }

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Cold.DecreaseCold(amount, suppressWarmUpMessage = true)
EndEvent