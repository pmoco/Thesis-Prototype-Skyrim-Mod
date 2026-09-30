Scriptname RPDefault_SetGlobalOnHit extends RPDefault_OnHit
{ Sets a global when this is hit }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Function HandleHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	TargetGlobal.SetValue(ValueToSet)
	return true
EndFunction