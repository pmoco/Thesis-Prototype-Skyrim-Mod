Scriptname RPDefault_SetStageLocationChangeAlias extends RPDefault_OnLocationChangeAlias
{ Sets a stage when this actor enters or leaves a particular location }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest this alias is a part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest this alias is a part of }

Bool Function HandleLocationChange(Location akOldLoc, Location akNewLoc)
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction