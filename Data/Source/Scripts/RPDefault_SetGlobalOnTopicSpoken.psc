Scriptname RPDefault_SetGlobalOnTopicSpoken extends TopicInfo
{ To use, add to TopicInfo, and then add a fragment: "((Self as TopicInfo) as RPDefault_SetGlobalOnTopicSpoken).Trigger()" }

GlobalVariable Property TargetGlobal auto
{ Global to set the value on }

int Property ValueToSet auto
{ Value to set on TargetGlobal }

Bool Property bOnlySetOnce = true auto
{ Set to false if this global should be set every time this occurs }

Function Trigger()
	GoToState("Completed")
	
	TargetGlobal.SetValue(ValueToSet)
	
	if( ! bOnlySetOnce)
		GoToState("")
	endif
EndFunction

State Completed
	Function Trigger()
		; Do nothing
	EndFunction
EndState