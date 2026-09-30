Scriptname ccBGSSSE001_CrabEncMonitor extends Quest  

Actor property PlayerRef auto
ActorBase property lvlCrab auto
int property stageToSetOnDone auto
int property killCrabsStage auto
int property crabObjective auto
ObjectReference[] property spawners auto
ReferenceAlias[] property RefAliases auto
GlobalVariable property ccBGSSSE001_MQ2CrabsKilled auto
GlobalVariable property ccBGSSSE001_MQ2CrabsTotal auto
int property LEVELMOD_BOSS = 3 autoReadOnly
int property LEVELMOD_HARD = 2 autoReadOnly
int property LEVELMOD_MEDIUM = 1 autoReadOnly
int property LEVELMOD_EASY = 0 autoReadOnly

int crabsSpawned = 0

function CrabKilled()
	int crabsKilled = ccBGSSSE001_MQ2CrabsKilled.GetValueInt() + 1
	int crabsTotal = ccBGSSSE001_MQ2CrabsTotal.GetValueInt()

	bool shouldRedisplayObjective = false
	if crabsKilled == 4 || crabsKilled == 8 || crabsKilled == crabsTotal
		shouldRedisplayObjective = true
	endif

	if ModObjectiveGlobal(1.0, ccBGSSSE001_MQ2CrabsKilled, crabObjective, ccBGSSSE001_MQ2CrabsTotal.GetValue(), abRedisplayObjective = shouldRedisplayObjective)
		SetStage(stageToSetOnDone)
		return
	endif

	if crabsSpawned < crabsTotal
		SpawnCrabs()
	endif
endFunction

int function GetRandomSpawner()
	return Utility.RandomInt(0, spawners.length - 1)
endFunction

function SpawnCrabs()
	; Spawn 2 crabs for every 1 killed, until we reach the target number, getting progressively harder.
	int i = 0
	while i < 2
		ObjectReference spawner = spawners[GetRandomSpawner()]
		int lvlMod
		if crabsSpawned >= 10
			lvlMod = LEVELMOD_BOSS
		elseif crabsSpawned >= 8
			lvlMod = LEVELMOD_HARD
		elseif crabsSpawned >= 6
			lvlMod = LEVELMOD_MEDIUM
		elseif crabsSpawned >= 4
			lvlMod = LEVELMOD_EASY
		endif
		Actor crab = spawner.PlaceActorAtMe(lvlCrab, lvlMod)
		if crabsSpawned < RefAliases.length
			RefAliases[crabsSpawned].ForceRefTo(crab)
		endif
		crab.StartCombat(PlayerRef)

		crabsSpawned += 1
		i += 1
	endWhile
endFunction