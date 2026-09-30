scriptname ccBGSSSE001_FishingActMarkarth extends ccBGSSSE001_FishingActScript
{ Handles saying lines of dialogue during fishing specific to the Miscellaneous fishing quest in Markarth. }

ccBGSSSE001_MiscMarkarthScript property MarkarthQuest auto
GlobalVariable property caughtFishGlobal auto
GlobalVariable property totalFishGlobal auto
int property fishCountObjective auto

bool saidCommentThisCast = false

function UpdateNibble()
	if MarkarthQuest.GetStage() == myQuestRequiredStage && !saidCommentThisCast
		saidCommentThisCast = true
		MarkarthQuest.SayNibbleLine()
	endif
endFunction

function UpdateFishCatchSuccess()
	MarkarthQuest.SayAweLine()

	if MarkarthQuest.GetStage() == myQuestRequiredStage
		if MarkarthQuest.ModObjectiveGlobal(1.0, caughtFishGlobal, fishCountObjective, totalFishGlobal.GetValue())
			MarkarthQuest.RegisterForUpdateObjectivesComplete()
		endif
	endif
endFunction

function UpdateFish()
	saidCommentThisCast = false
endFunction