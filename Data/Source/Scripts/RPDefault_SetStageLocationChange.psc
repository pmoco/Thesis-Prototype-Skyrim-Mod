Scriptname RPDefault_SetStageLocationChange extends RPDefault_OnLocationChange
{ Sets a stage when this actor enters or leaves a particular location }

Quest Property TargetQuest auto
{ Quest to set the stage on }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on TargetQuest before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on TargetQuest }


Bool Function HandleLocationChange(Location akOldLoc, Location akNewLoc)
	if(preReqStage < 0 || TargetQuest.GetStageDone(preReqStage))
		TargetQuest.SetStage(StageToSet)
		
		return true
	else
		return false
	endif
EndFunction