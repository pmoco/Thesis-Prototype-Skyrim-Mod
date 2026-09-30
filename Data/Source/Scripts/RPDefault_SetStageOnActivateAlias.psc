Scriptname RPDefault_SetStageOnActivateAlias extends RPDefault_OnActivateAlias
{ Sets a stage when object in Alias is activated }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on the quest this alias is a part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on the quest this alias is part of }

Bool Function HandleActivate(ObjectReference akActivatedBy)
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction

