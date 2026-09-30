Scriptname RPDefault_SetGlobalOnReadAlias extends RPDefault_OnReadAlias
{ Sets a Global when this book is read }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleRead()
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction