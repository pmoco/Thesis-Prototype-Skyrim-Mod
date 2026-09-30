Scriptname RPDefault_SetStageOnCombatState extends RPDefault_OnCombatState
{ Sets a stage when this actor enters or leaves combat, or is searching for their target. }

Quest Property TargetQuest auto
{ Quest to set the stage on }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on TargetQuest before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on TargetQuest }

Bool Function HandleCombatStateChanged(Actor akTarget, int aeCombatState)
	if(preReqStage < 0 || TargetQuest.GetStageDone(preReqStage))
		TargetQuest.SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction