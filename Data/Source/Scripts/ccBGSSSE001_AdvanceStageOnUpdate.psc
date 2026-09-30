Scriptname ccBGSSSE001_AdvanceStageOnUpdate extends Quest  

int property stageToSet auto

function RegisterForStageUpdate()
	RegisterForSingleUpdate(0.5)
endFunction

Event OnUpdate()
	SetStage(stageToSet)
endEvent