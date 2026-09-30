Scriptname RPDefault_SetGlobalOnDeath extends RPDefault_OnDeath
{ Sets a Global when this actor dies }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleDeath(Actor akKiller)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction