Scriptname RPDefault_SetGlobalLocationChange extends RPDefault_OnLocationChange
{ Sets a global when this actor enters or leaves a particular location }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleLocationChange(Location akOldLoc, Location akNewLoc)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction