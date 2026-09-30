scriptname Survival_MovementUIUpdateScript extends Quest

Survival_NeedCold property cold auto
Survival_ConditionsScript property conditions auto
bool wasNearHeat = false
float updateTime = 0.25

function EffectStarted()
	conditions.isMoving = false
	RegisterForSingleUpdate(updateTime)
endFunction

function EffectFinished()
	conditions.isMoving = true
	RegisterForSingleUpdate(updateTime)
endFunction

Event OnUpdate()
	if conditions.isMoving
		UpdateUIMoving()
	else
		UpdateUIStanding()
	endif
EndEvent

function UpdateUIMoving()
	if wasNearHeat
		wasNearHeat = false
		int level = cold.GetTemperatureLevelForUI()
		cold.ForceTemperatureLevelUI(level)
	endif
endFunction

function UpdateUIStanding()
	if conditions.IsPlayerNearHeat()
		wasNearHeat = true
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
