Scriptname RPDefault_SetGlobalOnCombatStateAlias extends RPDefault_OnCombatStateAlias
{ Sets a global when this actor enters or leaves combat, or is searching for their target. }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleCombatStateChanged(Actor akTarget, int aeCombatState)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction