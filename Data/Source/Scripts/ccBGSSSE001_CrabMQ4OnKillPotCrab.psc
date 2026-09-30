Scriptname ccBGSSSE001_CrabMQ4OnKillPotCrab extends ObjectReference  

ccBGSSSE001_CrabMQ4CrabSpawner property MQ4CrabSpawner auto

Event OnDeath(Actor akKiller)
	if MQ4CrabSpawner.IsRunning()
		MQ4CrabSpawner.FlamingPotCrabKilled()
	endif
endEvent