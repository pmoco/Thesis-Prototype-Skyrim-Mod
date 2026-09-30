Scriptname RPDefault_SetGlobalOnAggro extends RPDefault_OnAggro
{ Sets a stage when this actor enters combat or is hit }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleAggro()
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction