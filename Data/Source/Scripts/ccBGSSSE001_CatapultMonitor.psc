scriptname ccBGSSSE001_CatapultMonitor extends Quest

float property TIME_TO_HIT = 1.5 autoReadOnly
GlobalVariable property CatapultHitCount auto
GlobalVariable property CatapultHitTotal auto
int property catapultObjective auto
int property stageToSetOnDone auto

function RegisterCatapultHit()
	Utility.Wait(TIME_TO_HIT)
	if ModObjectiveGlobal(1.0, CatapultHitCount, catapultObjective, CatapultHitTotal.GetValue())
		SetStage(stageToSetOnDone)
	endif
endFunction