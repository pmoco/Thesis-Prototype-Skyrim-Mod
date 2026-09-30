Scriptname RPDefault_SetGlobalOnActivate extends RPDefault_OnActivate
{ Sets a Global when object is activated }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }


Bool Function HandleActivate(ObjectReference akActivatedBy)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction