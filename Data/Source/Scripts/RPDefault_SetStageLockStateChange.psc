Scriptname RPDefault_SetStageLockStateChange extends RPDefault_OnLockStateChange
{ Sets a stage when this door or container is locked or unlocked }

Quest Property TargetQuest auto
{ Quest to set the stage on }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on TargetQuest before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on TargetQuest }

Bool Function HandleLockStateChanged()
	if(preReqStage < 0 || TargetQuest.GetStageDone(preReqStage))
		TargetQuest.SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction