Scriptname RPDefault_SetStageOnAggroAlias extends RPDefault_OnAggroAlias
{ Sets a stage when this actor enters combat or is hit }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest this alias is a part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest this alias is a part of }

Bool Function HandleAggro()
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction