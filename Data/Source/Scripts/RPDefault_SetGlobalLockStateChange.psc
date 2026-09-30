Scriptname RPDefault_SetGlobalLockStateChange extends RPDefault_OnLockStateChange
{ Sets a global when this door or container is locked or unlocked }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }
	
Bool Function HandleLockStateChanged()
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction