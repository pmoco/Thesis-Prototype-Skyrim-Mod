Scriptname RPDefault_SetStageOnHit extends RPDefault_OnHit
{ Sets a stage this is hit }

Quest Property TargetQuest auto
{ Quest to set the stage on }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on TargetQuest before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on TargetQuest }

Bool Function HandleHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if(preReqStage < 0 || TargetQuest.GetStageDone(preReqStage))
		TargetQuest.SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction