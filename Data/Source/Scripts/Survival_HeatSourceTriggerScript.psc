scriptname Survival_HeatSourceTriggerScript extends ObjectReference

Survival_ConditionsScript property conditions auto

; Player filtered by Interaction Keyword on Activator
Event OnTriggerEnter(ObjectReference akActionRef)
	conditions.lastHeatSourceTrigger = self
EndEvent
