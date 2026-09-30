scriptname ccBGSSSE001_CrabMQ4CrabSpawner extends Quest

Actor property PlayerRef auto
ActorBase property lvlCrab auto
ActorBase property potCrab auto
int property crabObjective auto
ObjectReference[] property spawners auto
ReferenceAlias[] property guards auto
ReferenceAlias[] property potCrabs auto
MiscObject property flamingPot auto
GlobalVariable property ccBGSSSE001_MQ4CrabsKilled auto
GlobalVariable property ccBGSSSE001_MQ4CrabsKilledPct auto
GlobalVariable property ccBGSSSE001_CrabMQ4CatapultCount auto
GlobalVariable property ccBGSSSE001_CrabMQ4CatapultTotal auto
int property wave1StageToSetOnDone auto
int property wave2StageToSetOnDone auto
int property wave2MidObjectiveStageToSet auto

int property LEVELMOD_BOSS = 3 AutoReadOnly
int property LEVELMOD_HARD = 2 AutoReadOnly
int property LEVELMOD_MEDIUM = 1 AutoReadOnly
int property LEVELMOD_EASY = 0 AutoReadOnly

int property CRABS_TO_KILL_WAVE_1 = 8 Auto
{ The number of normal crabs to kill in the first wave. }
int property CRABS_TO_KILL_WAVE_2 = 15 Auto
{ The number of normal crabs to kill in the second wave. }
int property CRABS_TO_KILL_WAVE_3 = 10 Auto
{ The number of normal crabs allowed to be killed before they no longer respawn in the third wave. }
int property FLAMING_POT_CRABS_TO_KILL_WAVE_3 = 12 Auto
{ The number of flaming pot crabs allowed to be killed before they no longer respawn in the third wave. }

int property MAX_CRABS_WAVE_1 = 4 Auto
{ The maximum number of normal crabs that can be on the battlefield at one time in the first wave. }
int property MAX_CRABS_WAVE_2 = 6 Auto
{ The maximum number of normal crabs that can be on the battlefield at one time in the second wave. }
int property MAX_CRABS_WAVE_3 = 3 Auto
{ The maximum number of normal crabs that can be on the battlefield at one time in the third wave. }
int property CRAB_COUNT_NORMAL_SPAWN = 2 Auto
{ The number of normal crabs that should spawn when one is killed. }

int property INITIAL_CRABS_WAVE_1 = 3 Auto
{ The number of initial crabs that spawn at the beginning of the first wave. }
int property INITIAL_CRABS_WAVE_2 = 6 Auto
{ The number of initial crabs that spawn at the beginning of the second wave. }
int property INITIAL_CRABS_WAVE_3 = 3 Auto
{ The number of initial crabs that spawn at the beginning of the third wave. }

int property THRESHOLD_BOSS_WAVE_1 = 6 Auto
{ The number of crabs that must be killed before Boss-level crabs begin spawning in the first wave. }
int property THRESHOLD_HARD_WAVE_1 = 4 Auto
{ The number of crabs that must be killed before Hard-level crabs begin spawning in the first wave. }
int property THRESHOLD_MEDIUM_WAVE_1 = 2 Auto
{ The number of crabs that must be killed before Medium-level crabs begin spawning in the first wave. }
int property THRESHOLD_BOSS_WAVE_2 = 12 Auto
{ The number of crabs that must be killed before Boss-level crabs begin spawning in the second wave. }
int property THRESHOLD_HARD_WAVE_2 = 8 Auto
{ The number of crabs that must be killed before Hard-level crabs begin spawning in the second wave. }
int property THRESHOLD_MEDIUM_WAVE_2 = 6 Auto
{ The number of crabs that must be killed before Medium-level crabs begin spawning in the second wave. }
int property THRESHOLD_BOSS_WAVE_3 = 4 Auto
{ The number of crabs that must be killed before Boss-level crabs begin spawning in the third wave. }
int property THRESHOLD_HARD_WAVE_3 = 3 Auto
{ The number of crabs that must be killed before Hard-level crabs begin spawning in the third wave. }
int property THRESHOLD_MEDIUM_WAVE_3 = 2 Auto
{ The number of crabs that must be killed before Medium-level crabs begin spawning in the third wave. }

int property OBJECTIVE_MODULO_WAVE_1 = 4 Auto
{ The modulo that dictates objective display when crabs are killed in the first wave. }
int property OBJECTIVE_MODULO_WAVE_2 = 5 Auto
{ The modulo that dictates objective display when crabs are killed in the second wave. }

int wave1CrabsSpawned = 0
int wave1CrabsKilled = 0
int wave2CrabsSpawned = 0
int wave2CrabsKilled = 0
int wave3CrabsSpawned = 0
int wave3CrabsKilled = 0
int wave3FlamingPotCrabsSpawned = 0
bool workingCrabKilled = false
bool workingFlamingPotCrabKilled = false

function SetWave(int aiWave)
	if aiWave == 1
		GoToState("WaveOne")
	elseif aiWave == 2
		GoToState("WaveTwo")
	elseif aiWave == 3
		GoToState("WaveThree")
	endif
endFunction

function SpawnInitialCrabs()
	; Do nothing
endFunction

function ModObjectiveGlobalAndCheckObjectiveRedisplay(int aiObjectiveModulo, int aiCrabsKilledThisWave, int aiTargetCrabsToKillThisWave)
	bool shouldRedisplayObjective = false

	; Redisplay the objective at certain intervals. Don't display it when we're finished
	; (we have a separate notification to handle that).
	if aiCrabsKilledThisWave % aiObjectiveModulo == 0 && aiCrabsKilledThisWave != aiTargetCrabsToKillThisWave
		shouldRedisplayObjective = true
	endif

	float amountToDecreaseBy = 100.0 / aiTargetCrabsToKillThisWave
	ccBGSSSE001_MQ4CrabsKilledPct.Mod(-amountToDecreaseBy)
	UpdateCurrentInstanceGlobal(ccBGSSSE001_MQ4CrabsKilledPct)
	if shouldRedisplayObjective
		SetObjectiveDisplayed(crabObjective, abForce = true)
	endif
endFunction

function CrabKilled()
	; Do nothing
endFunction

int function SpawnCrabs(int aiMaxSpawnCount, int aiCrabsSpawnedThisWave, int aiCrabsKilledThisWave, int aiMaxCrabsThisWave, int aiTargetCrabsToKillThisWave, int aiBossThreshold, int aiHardThreshold, int aiMediumThreshold, bool isInitialSpawn = false)
	; Spawn crabs until we reach the target number or the maximum simultaneous number of crabs, getting progressively harder.
	; Crabs are spawned when:
	;	The wave starts
	;	A crab dies

	int i = 0
	int crabsSpawned = 0
	while i < aiMaxSpawnCount
		bool simultaneousCrabsNotExceeded = (aiCrabsSpawnedThisWave - aiCrabsKilledThisWave) < aiMaxCrabsThisWave
		bool waveCountNotExceeded = (crabsSpawned + aiCrabsSpawnedThisWave) < aiTargetCrabsToKillThisWave

		if simultaneousCrabsNotExceeded && waveCountNotExceeded
			ObjectReference spawner = spawners[GetRandomSpawner()]
			int lvlMod
			if aiCrabsSpawnedThisWave >= aiBossThreshold
				lvlMod = LEVELMOD_BOSS
			elseif aiCrabsSpawnedThisWave >= aiHardThreshold
				lvlMod = LEVELMOD_HARD
			elseif aiCrabsSpawnedThisWave >= aiMediumThreshold
				lvlMod = LEVELMOD_MEDIUM
			else
				lvlMod = LEVELMOD_EASY
			endif
			Actor crab = spawner.PlaceActorAtMe(lvlCrab, lvlMod)

			if isInitialSpawn && crabsSpawned == 0
				; Always target the player with the first crab spawned in a wave.
				crab.StartCombat(PlayerRef)
			else
				; Pick a random guard to target. If the guard is dead, fall back to the player.
				int randomGuardIndex = Utility.RandomInt(0, guards.Length - 1)
				Actor guard = guards[randomGuardIndex].GetActorRef()
				if !guard.IsDead()
					crab.StartCombat(guard)
				else
					crab.StartCombat(PlayerRef)
				endif
			endif

			crabsSpawned += 1
		endif
		i += 1
	endWhile

	return crabsSpawned
endFunction

function SpawnFlamingPotCrab(int aiCount)
	; Do nothing
endFunction

function FlamingPotCrabKilled()
	; Do nothing
endFunction

Auto State WaveOne
	function SpawnInitialCrabs()
		wave1CrabsSpawned += SpawnCrabs(INITIAL_CRABS_WAVE_1, wave1CrabsSpawned, wave1CrabsKilled, MAX_CRABS_WAVE_1, CRABS_TO_KILL_WAVE_1, THRESHOLD_BOSS_WAVE_1, THRESHOLD_HARD_WAVE_1, THRESHOLD_MEDIUM_WAVE_1, true)
	endFunction

	function CrabKilled()
		while workingCrabKilled
			Utility.Wait(0.1)
		endWhile

		workingCrabKilled = true
		wave1CrabsKilled += 1
		ModObjectiveGlobalAndCheckObjectiveRedisplay(OBJECTIVE_MODULO_WAVE_1, wave1CrabsKilled, CRABS_TO_KILL_WAVE_1)

		if wave1CrabsKilled >= CRABS_TO_KILL_WAVE_1
			SetStage(wave1StageToSetOnDone)
		else
			wave1CrabsSpawned += SpawnCrabs(CRAB_COUNT_NORMAL_SPAWN, wave1CrabsSpawned, wave1CrabsKilled, MAX_CRABS_WAVE_1, CRABS_TO_KILL_WAVE_1, THRESHOLD_BOSS_WAVE_1, THRESHOLD_HARD_WAVE_1, THRESHOLD_MEDIUM_WAVE_1)
		endif
		workingCrabKilled = false
	endFunction
endState

State WaveTwo
	Event OnBeginState()
		ccBGSSSE001_MQ4CrabsKilled.SetValueInt(0)
		ccBGSSSE001_MQ4CrabsKilledPct.SetValueInt(100)
		UpdateCurrentInstanceGlobal(ccBGSSSE001_MQ4CrabsKilledPct)
	EndEvent

	function SpawnInitialCrabs()
		wave2CrabsSpawned += SpawnCrabs(INITIAL_CRABS_WAVE_2, wave2CrabsSpawned, wave2CrabsKilled, MAX_CRABS_WAVE_2, CRABS_TO_KILL_WAVE_2, THRESHOLD_BOSS_WAVE_2, THRESHOLD_HARD_WAVE_2, THRESHOLD_MEDIUM_WAVE_2, true)
	endFunction

	function CrabKilled()
		while workingCrabKilled
			Utility.Wait(0.1)
		endWhile

		workingCrabKilled = true
		wave2CrabsKilled += 1
		ModObjectiveGlobalAndCheckObjectiveRedisplay(OBJECTIVE_MODULO_WAVE_2, wave2CrabsKilled, CRABS_TO_KILL_WAVE_2)

		int halfwayPoint = CRABS_TO_KILL_WAVE_2 / 2
		
		if wave2CrabsKilled >= CRABS_TO_KILL_WAVE_2
			SetStage(wave2StageToSetOnDone)
		elseif wave2CrabsKilled == halfwayPoint
			SetStage(wave2MidObjectiveStageToSet)
			wave2CrabsSpawned += SpawnCrabs(CRAB_COUNT_NORMAL_SPAWN, wave2CrabsSpawned, wave2CrabsKilled, MAX_CRABS_WAVE_2, CRABS_TO_KILL_WAVE_2, THRESHOLD_BOSS_WAVE_2, THRESHOLD_HARD_WAVE_2, THRESHOLD_MEDIUM_WAVE_2)
		else
			wave2CrabsSpawned += SpawnCrabs(CRAB_COUNT_NORMAL_SPAWN, wave2CrabsSpawned, wave2CrabsKilled, MAX_CRABS_WAVE_2, CRABS_TO_KILL_WAVE_2, THRESHOLD_BOSS_WAVE_2, THRESHOLD_HARD_WAVE_2, THRESHOLD_MEDIUM_WAVE_2)
		endif
		workingCrabKilled = false
	endFunction
endState

State WaveThree
	Event OnBeginState()
		ccBGSSSE001_MQ4CrabsKilled.SetValueInt(0)
	EndEvent

	function SpawnInitialCrabs()
		; A flaming pot crab is also spawned by default by the quest stage.
		wave3CrabsSpawned += SpawnCrabs(INITIAL_CRABS_WAVE_3, wave3CrabsSpawned, wave3CrabsKilled, MAX_CRABS_WAVE_3, CRABS_TO_KILL_WAVE_3, THRESHOLD_BOSS_WAVE_3, THRESHOLD_HARD_WAVE_3, THRESHOLD_MEDIUM_WAVE_3, true)
		SpawnFlamingPotCrab(2)
	endFunction

	function CrabKilled()
		while workingCrabKilled
			Utility.Wait(0.1)
		endWhile

		workingCrabKilled = true
		wave3CrabsKilled += 1
		
		if wave3CrabsKilled < CRABS_TO_KILL_WAVE_3
			wave3CrabsSpawned += SpawnCrabs(CRAB_COUNT_NORMAL_SPAWN, wave3CrabsSpawned, wave3CrabsKilled, MAX_CRABS_WAVE_3, CRABS_TO_KILL_WAVE_3, THRESHOLD_BOSS_WAVE_3, THRESHOLD_HARD_WAVE_3, THRESHOLD_MEDIUM_WAVE_3)
		endif
		workingCrabKilled = false
	endFunction

	function FlamingPotCrabKilled()
		; Spawn 2 more until the battle is complete
		while workingFlamingPotCrabKilled
			Utility.Wait(0.1)
		endWhile
		workingFlamingPotCrabKilled = true
		
		; If the player still has catapult hits to make and hasn't killed the maximum number of flaming pot crabs,
		; spawn more flaming pot crabs.
		if wave3FlamingPotCrabsSpawned < FLAMING_POT_CRABS_TO_KILL_WAVE_3 && \
			ccBGSSSE001_CrabMQ4CatapultCount.GetValueInt() < ccBGSSSE001_CrabMQ4CatapultTotal.GetValueInt()
			SpawnFlamingPotCrab(1)
		endif

		workingFlamingPotCrabKilled = false
	endFunction

	function SpawnFlamingPotCrab(int aiCount)
		; Find an available alias for this crab. If there are none, abort.
		ReferenceAlias crabAlias
		Actor potentialActor

		int crabsSpawned = 0
		while crabsSpawned < aiCount
			; First, try a random alias once, which can randomize the package it uses. 
			; If that doesn't work, go down the list.
			int roll = Utility.RandomInt(0, potCrabs.Length - 1)
			if IsValidAlias(potCrabs[roll].GetActorRef())
				crabAlias = potCrabs[roll]
			else
				int i = 0
				while i < potCrabs.Length
					if IsValidAlias(potCrabs[i].GetActorRef())
						crabAlias = potCrabs[i]
					endif
					i += 1
				endWhile
			endif

			if !crabAlias
				; We've already spawned the maximum number of flaming pot crabs.
				return
			endif

			ObjectReference spawner = spawners[GetRandomSpawner()]

			Actor myPotCrab = spawner.PlaceActorAtMe(potCrab)
			ObjectReference myPot = myPotCrab.PlaceAtMe(flamingPot)
			myPotCrab.AddItem(myPot)
			crabAlias.ForceRefTo(myPotCrab)
			myPotCrab.EvaluatePackage()
			wave3FlamingPotCrabsSpawned += 1

			crabsSpawned += 1
		endWhile
	endFunction
endState

bool function IsValidAlias(Actor akActor)
	return !akActor || akActor.IsDead()
endFunction

int function GetRandomSpawner()
	return Utility.RandomInt(0, spawners.length - 1)
endFunction
