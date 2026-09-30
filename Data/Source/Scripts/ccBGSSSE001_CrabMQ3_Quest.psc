Scriptname ccBGSSSE001_CrabMQ3_Quest extends Quest  

float property timeToBuildStall auto
float property timeForCourier auto
int property stallBuiltStage auto
int property startCourierStage auto

function StartCourierTimer()
	GoToState("CourierTimer")
	RegisterForSingleUpdateGameTime(timeForCourier)
endFunction

function StartMarketStallTimer()
	GoToState("StallTimer")
	RegisterForSingleUpdateGameTime(timeToBuildStall)
endFunction

State CourierTimer
	Event OnUpdateGameTime()
		SetStage(startCourierStage)
	endEvent
endState

State StallTimer
	Event OnUpdateGameTime()
		SetStage(stallBuiltStage)
	endEvent
endState
