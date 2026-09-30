Scriptname ccBGSSSE001_CrabMQ4OnKillCrab extends ObjectReference  

ccBGSSSE001_CrabMQ4BodyCleanup property BodyCleanup auto
ccBGSSSE001_CrabMQ4CrabSpawner property MQ4CrabSpawner auto

Event OnDeath(Actor akKiller)
	BodyCleanup.CrabDied(self)
	if MQ4CrabSpawner.IsRunning()
		MQ4CrabSpawner.CrabKilled()
	endif
endEvent