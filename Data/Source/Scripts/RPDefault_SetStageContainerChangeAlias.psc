Scriptname RPDefault_SetStageContainerChangeAlias extends RPDefault_OnContainerChangedAlias
{ Sets a stage when object is moved to a physical container }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest this alias is part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest this alias is part of }

Bool Function HandleContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		
		return true
	else
		return false
	endif
EndFunction