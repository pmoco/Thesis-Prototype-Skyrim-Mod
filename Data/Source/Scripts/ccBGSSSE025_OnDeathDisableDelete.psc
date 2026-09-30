Scriptname ccBGSSSE025_OnDeathDisableDelete extends ObjectReference  

Event OnDeath(Actor akKiller)
	self.Disable(true)
	self.Delete()
endEvent