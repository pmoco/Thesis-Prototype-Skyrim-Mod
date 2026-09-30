Scriptname RPDefault_SetStageOnTopicSpoken extends TopicInfo
{ To use, add to TopicInfo, and then add a fragment: "((Self as TopicInfo) as RPDefault_SetStageOnTopicSpoken).Trigger()" }

Quest Property TargetQuest auto
{ (Optional) Quest to set the stage on. If left blank - will use current quest this dialogue is on. }

int Property preReqStage = -1 auto
{ (Optional) Requires this stage to be done before it will set the new stage. }

int Property StageToSet auto
{ Stage to set }

Function Trigger()
	Quest QuestToSet = TargetQuest
	
	if(QuestToSet == None)
		QuestToSet = GetOwningQuest()
	endif
	
	if(preReqStage < 0 || QuestToSet.GetStageDone(preReqStage))
		QuestToSet.SetStage(StageToSet)
	endif
EndFunction