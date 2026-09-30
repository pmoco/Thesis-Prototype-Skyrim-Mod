Scriptname ccBGSSSE001_CrabMQ2EncAlias extends ReferenceAlias  

ccBGSSSE001_CrabEncMonitor property encounterQuest auto

Event OnDeath(Actor akKiller)
	encounterQuest.CrabKilled()
endEvent
