Scriptname RPDefault_SetStageContainerChange extends RPDefault_OnContainerChanged
{ Sets a stage when object is moved to a physical container }

Quest Property TargetQuest auto
{ Quest to set the stage on }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on TargetQuest before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on TargetQuest }

Bool Function HandleContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(preReqStage < 0 || TargetQuest.GetStageDone(preReqStage))
		TargetQuest.SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction