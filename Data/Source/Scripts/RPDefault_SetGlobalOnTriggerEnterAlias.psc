Scriptname RPDefault_SetGlobalOnTriggerEnterAlias extends RPDefault_OnTriggerEnterAlias
{ Sets a global when an actor enters this trigger box }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleTriggerEnter(ObjectReference akActionRef)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction