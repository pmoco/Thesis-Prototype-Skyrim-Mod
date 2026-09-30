Scriptname RPDefault_SetStageOnHitAlias extends RPDefault_OnHitAlias
{ Sets a stage this is hit }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest this alias is part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest this alias is part of }

Bool Function HandleHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction