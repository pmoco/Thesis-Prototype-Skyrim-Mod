scriptname Survival_AttributeEffectWatchScript extends ReferenceAlias
{ A script for monitoring changes to the player's total attribute values. }

import Survival_GlobalFunctions

float lastTotalAV
float updateFrequency = 3.0
Actor property PlayerRef auto
string property PenaltyAVName auto
string property AttributeAVName auto
Survival_NeedBase property Need auto
GlobalVariable property Survival_ModeEnabled auto
bool property locked = false auto hidden

Event OnInit()
	RegisterForSingleUpdate(updateFrequency)
EndEvent

Event OnPlayerLoadGame()
	RegisterForSingleUpdate(updateFrequency)
EndEvent

Event OnUpdate()
	if Survival_ModeEnabled.GetValueInt() == 1
		CheckAttributePenalty()
	endif
	RegisterForSingleUpdate(updateFrequency)
EndEvent

function WaitForUnlock()
	while locked
		Utility.Wait(0.5)
	endWhile
endFunction

function CheckAttributePenalty()
	WaitForUnlock()
	locked = true
	float totalAV = Need.GetTotalAV(AttributeAVName, PenaltyAVName)
	if totalAV != lastTotalAV
		Need.ApplyAttributePenalty(totalAV, Need.NeedValue.GetValue(), AttributeAVName, PenaltyAVName)
	endif
	lastTotalAV = totalAV
	locked = false
endFunction

function HandleAttributeDiseaseApply(Spell akDisease, ActiveMagicEffect akEffectToDispel, Actor akTarget)
	WaitForUnlock()
	locked = true
	Need.HandleAttributeDiseaseApply(akDisease, akEffectToDispel, akTarget)
	locked = false
endFunction

bool function Within(float afFirstValue, float afSecondValue, float afLowerTolerance, float afUpperTolerance)
	float delta = afFirstValue - afSecondValue
	return delta >= afLowerTolerance && delta <= afUpperTolerance
endFunction