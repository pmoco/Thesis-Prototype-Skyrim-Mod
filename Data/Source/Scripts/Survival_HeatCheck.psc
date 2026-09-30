scriptname Survival_HeatCheck extends Quest

import Survival_GlobalFunctions

Survival_NeedCold property cold auto
Survival_ConditionsScript property conditions auto

Actor property PlayerRef auto
GlobalVariable property Survival_ColdRestoreSmallAmount auto

; Heat Locator
Quest property Survival_HeatSourceLocatorQuest auto
ObjectReference[] property LastKnownHeatRefs auto

bool firstUpdate = true
float lastTimeInGameHours
float updateInterval = 6.0


function StartUpdating()
	if !self.IsRunning()
		self.Start()
	endif
	RegisterForSingleUpdate(updateInterval)
	RegisterForSingleUpdateGameTime(cold.NeedUpdateGameTimeInterval.GetValue())
endFunction

function StopUpdating()
	if self.IsRunning()
		int i = 0
		while i < LastKnownHeatRefs.length
			LastKnownHeatRefs[i] = None
			i += 1
		endWhile
		self.Stop()
	endif
endFunction

Event OnUpdate()
	if self.IsRunning()
		LocateHeatSources()
		CheckHeat()
		RegisterForSingleUpdate(updateInterval)
	endif
EndEvent

Event OnUpdateGameTime()
	float currentTimeInGameHours = Utility.GetCurrentGameTime() * 24

	if firstUpdate
		SurvivalLogMessage("{{HEAT}} Ignoring the first update and storing update time.")
		firstUpdate = false
	else
		if currentTimeInGameHours - lastTimeInGameHours >= 1.0 && conditions.IsPlayerNearHeat()
			SurvivalLogMessage("{{HEAT}} Player waited near fire, warming up to max.")
			cold.DecreaseCold(cold.NeedMaxValue.GetValue())
		endif
	endif

	lastTimeInGameHours = currentTimeInGameHours
	RegisterForSingleUpdateGameTime(cold.NeedUpdateGameTimeInterval.GetValue())
EndEvent

bool function IsPlayerNearHeatAndStanding()
	if conditions.IsPlayerNearHeat() && !conditions.isMoving
		return true
	else
		return false
	endif
endFunction

function LocateHeatSources()
	Survival_HeatSourceLocatorQuest.Stop()
	Survival_HeatSourceLocatorQuest.Start()
endFunction

function CheckHeat()
	if IsPlayerNearHeatAndStanding()
		cold.DecreaseCold(Survival_ColdRestoreSmallAmount.GetValue())
		UpdateUIWhenNearHeat()
	endif
endFunction

function UpdateUIWhenNearHeat()
	if cold.NeedValue.GetValue() > 0.0
		cold.ForceTemperatureUINearHeat()
	else
		cold.ForceTemperatureUINeutral()
	endif
endFunction
