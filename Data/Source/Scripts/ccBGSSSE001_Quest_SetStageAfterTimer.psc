Scriptname ccBGSSSE001_Quest_SetStageAfterTimer extends Quest  

int stageToSet

Event OnUpdateGameTime()
	SetStage(stageToSet)
endEvent

function StartWaitTimer(float afTimeToWait, int aiStageToSetAfterTimer)
	stageToSet = aiStageToSetAfterTimer
	RegisterForSingleUpdateGameTime(afTimeToWait)
endFunction