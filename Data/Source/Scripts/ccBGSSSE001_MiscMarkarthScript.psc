Scriptname ccBGSSSE001_MiscMarkarthScript extends Quest  

ReferenceAlias property Student auto
Topic property NibbleComment auto
Topic property AweComment auto
GlobalVariable property myQuestItemCaughtGlobal auto
int property allFishCaughtStage auto

function SayNibbleLine()
	Student.GetActorRef().Say(NibbleComment)
endFunction

function SayAweLine()
	Student.GetActorRef().Say(AweComment)
endFunction

function RegisterForUpdateObjectivesComplete()
	RegisterForSingleUpdate(2)
endFunction

Event OnUpdate()
	myQuestItemCaughtGlobal.SetValueInt(1)
	SetStage(allFishCaughtStage)
endEvent