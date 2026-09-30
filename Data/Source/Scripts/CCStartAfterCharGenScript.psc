Scriptname CCStartAfterCharGenScript extends Quest  

Quest Property MQ101  Auto
Int Property CharGenStageToWatch = 1000 Auto  
Int property optionalRequiredPlayerLevel = 1 auto
{ Optional: The level the player must be (at least) in order for the quest to start. Default: 1 }
Int Property MyQuestStageToSet  Auto 
Float Property SecondsBetweenChecks = 30.0 Auto

Event OnInit()
	CheckStageToStart()
EndEvent

Event OnUpdate()
	CheckStageToStart()
EndEvent

Function CheckStageToStart()
	if MQ101.GetStageDone(ChargenStageToWatch) == true && Game.GetPlayer().GetLevel() >= optionalRequiredPlayerLevel
		SetStage(MyQuestStageToSet)
	else
		RegisterForSingleUpdate(SecondsBetweenChecks)
	endif
EndFunction