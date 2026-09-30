Scriptname ccBGSSSE001_WhiterunChestScript extends ReferenceAlias  

Quest property myQuest auto
int property doneStage auto

Event OnLockStateChanged()
	if !self.GetRef().IsLocked()
		myQuest.SetStage(doneStage)
	endif
endEvent