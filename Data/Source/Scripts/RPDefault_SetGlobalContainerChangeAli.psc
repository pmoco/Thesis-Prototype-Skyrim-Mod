Scriptname RPDefault_SetGlobalContainerChangeAli extends RPDefault_OnContainerChangedAlias
{ Sets a global when object is moved to a physical container }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction