Scriptname RPDefault_SetStageLockStateChangeAlias extends RPDefault_OnLockStateChangeAlias
{ Sets a stage when this door or container is locked or unlocked }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest this alias is a part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest this alias is a part of }


Bool Function HandleLockStateChanged()
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction