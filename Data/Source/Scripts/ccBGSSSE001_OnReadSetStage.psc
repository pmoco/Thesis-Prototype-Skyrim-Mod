Scriptname ccBGSSSE001_OnReadSetStage extends ReferenceAlias  

int property myStage auto
int property preReqStage auto

Quest Property myQuest Auto  

event onRead()
	if myQuest.IsRunning() && myQuest.GetStage() >= preReqStage
		myQuest.setStage(myStage)
	endif
endEvent

