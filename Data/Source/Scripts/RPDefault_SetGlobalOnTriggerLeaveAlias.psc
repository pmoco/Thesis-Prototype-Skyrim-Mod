Scriptname RPDefault_SetGlobalOnTriggerLeaveAlias extends RPDefault_OnTriggerLeaveAlias
{ Sets a global when an actor leaves this trigger box }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleTriggerLeave(ObjectReference akActionRef)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction