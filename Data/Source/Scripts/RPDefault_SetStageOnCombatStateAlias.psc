Scriptname RPDefault_SetStageOnCombatStateAlias extends RPDefault_OnCombatStateAlias
{ Sets a stage when this actor enters or leaves combat, or is searching for their target. }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done on quest alias is a part of before it will set the new stage. }

int Property StageToSet auto
{ Stage to set on quest alias is a part of }

Bool Function HandleCombatStateChanged(Actor akTarget, int aeCombatState)
	if(preReqStage < 0 || GetOwningQuest().GetStageDone(preReqStage))
		GetOwningQuest().SetStage(StageToSet)
		return true
	else
		return false
	endif
EndFunction