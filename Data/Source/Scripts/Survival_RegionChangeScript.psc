scriptname Survival_RegionChangeScript extends ActiveMagicEffect

string property regionName auto
{ The name of the region. }

Survival_PlayerLocationInfo property locationinfo auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	locationinfo.RegionEntered(regionName)
	RegisterForSingleUpdate(5)
EndEvent

Event OnUpdate()
	locationinfo.RegionEntered(regionName)
	RegisterForSingleUpdate(5)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(0.5)
	locationinfo.RegionLeft(regionName)
EndEvent