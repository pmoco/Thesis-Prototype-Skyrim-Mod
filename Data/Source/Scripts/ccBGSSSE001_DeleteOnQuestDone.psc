Scriptname ccBGSSSE001_DeleteOnQuestDone extends ReferenceAlias  

Quest property myQuest auto
int property StageToDelete auto
bool property StopQuestOnDelete auto

Event OnUnload()
	DoDelete(self.GetActorRef())
endEvent

function DeleteIfUnloaded()
	Actor mySelf = self.GetActorRef()
	if !mySelf.Is3DLoaded()
		DoDelete(mySelf)
	endif
endFunction

function DoDelete(Actor akActor)
	if myQuest.GetStage() == StageToDelete
		akActor.Disable()
		akActor.Delete()

		if StopQuestOnDelete
			myQuest.Stop()
		endif

		self.Clear()
	endif
endFunction