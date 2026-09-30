ScriptName ccBGSSSE025_DisableOnResetAfterDone extends objectReference
{Disables this object when the cell resets after a quest stage has been completed.}

Quest property MyQuest auto
Int property QuestStage auto

Event OnReset()
	if MyQuest.GetStageDone(QuestStage)
		Self.Disable()
	endif
EndEvent