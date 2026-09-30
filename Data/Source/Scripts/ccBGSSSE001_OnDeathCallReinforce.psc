Scriptname ccBGSSSE001_OnDeathCallReinforce extends ReferenceAlias  

ccBGSSSE001_CrabMQ4BodyCleanup property BodyCleanup auto
ccBGSSSE001_CrabMQ4Reinforcements property Reinforcements auto

Event OnDeath(Actor akKiller)
	BodyCleanup.GuardDied(self.GetRef())
	Reinforcements.GuardDied(self)
endEvent