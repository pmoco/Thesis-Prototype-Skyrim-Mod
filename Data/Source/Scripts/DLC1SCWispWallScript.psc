Scriptname DLC1SCWispWallScript extends ObjectReference  

import Debug
import Utility

Keyword Property DLC1WispWallEffect auto

Int WispCount = 0
Int DeadCount = 0

Quest Property QuestToSetOnWallDown auto
int Property StageToSet auto

function GetWispNumber()
	WispCount += 1
	;Notification("WispCount+1")
endFunction

function CheckDead()
	DeadCount += 1
	if (DeadCount == WispCount)
		DropWall(GetLinkedRef(DLC1WispWallEffect))
		if (QuestToSetOnWallDown)
			QuestToSetOnWallDown.SetStage(StageToSet)	
		endif
	endif
endFunction

function DropWall(ObjectReference WallEffect)
	WallEffect.disable(TRUE)
	self.Disable()
	;Notification("Wall Down")
endFunction