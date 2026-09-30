scriptname ccBGSSSE025_BossControllerScript extends Quest conditional

; /// Properties
ReferenceAlias property Boss auto
ObjectReference[] property summonMarkerRefs auto
Quest property BossMainQuest auto
Actor property PlayerRef auto
Activator property SummonFX Auto
ActorBase property summonedGoldenSaintWarrior auto
ActorBase property summonedGoldenSaintArcher auto
ActorBase property summonedDarkSeducerWarrior auto
ActorBase property summonedDarkSeducerArcher auto
ObjectReference property battlefieldCenterRef Auto
ObjectReference property bossCenterTeleportMarkerRef auto
effectShader property fadeOutFX auto
visualEffect property TrailFXAbsorb auto

Actor bossRef
float oldHealthPercent = 1.0
bool shouldUpdate = false
int summonPhase = 1

float property MAX_BOSS_WANDER_DISTANCE = 1600.0 autoReadOnly hidden
float property TELEPORT_SUMMON_FX_DURATION = 0.5 autoReadOnly hidden
float property TELEPORT_TRAIL_FX_DURATION = 0.75 autoReadOnly hidden

; /// Local vars
Actor[] currentSummons
bool initialized = false

; /// Consts
float property HEALTH_CHECK_DURATION = 2.0 autoReadOnly hidden

Event OnInit()
	if !initialized
		initialized = true
		currentSummons = new Actor[2]
		bossRef = Boss.GetActorRef()
	endif
endEvent

Event OnUpdate()
	if bossRef.GetDistance(battlefieldCenterRef) > MAX_BOSS_WANDER_DISTANCE
		TeleportToLocation(bossCenterTeleportMarkerRef, false)
	endif

	float currentHealthPercent = bossRef.GetAVPercentage("Health")

	if oldHealthPercent > 0.90 && currentHealthPercent <= 0.90 && summonPhase <= 1
		TeleportAndSetNewSummonPhase(bossCenterTeleportMarkerRef, 2)
	elseif oldHealthPercent > 0.66 && currentHealthPercent <= 0.66 && summonPhase <= 2
		TeleportAndSetNewSummonPhase(bossCenterTeleportMarkerRef, 3)
	elseif oldHealthPercent > 0.33 && currentHealthPercent <= 0.33 && summonPhase <= 3
		TeleportAndSetNewSummonPhase(bossCenterTeleportMarkerRef, 4)
	endif

	oldHealthPercent = currentHealthPercent

	if shouldUpdate
		RegisterForSingleUpdate(HEALTH_CHECK_DURATION)
	endif
endEvent

function TeleportAndSetNewSummonPhase(ObjectReference teleportTarget, int phase)
	summonPhase = phase
	TeleportToLocation(teleportTarget, true)
	SummonPhase(phase)
endFunction

function OnBossEnterCombat()
	bossRef.SetAV("Aggression", 2)
	bossRef.EvaluatePackage()
	bossRef.StartCombat(PlayerRef)
	bossRef.CreateDetectionEvent(PlayerRef, 100)

	shouldUpdate = true
	RegisterForSingleUpdate(HEALTH_CHECK_DURATION)
endFunction

function OnBossExitCombat()
	shouldUpdate = false
	DispelSummons()
	UnregisterForUpdate()
endFunction

function OnBossDeath()
	OnBossExitCombat()
endFunction

function SummonPhase(int phase)
	DispelSummons()

	ActorBase firstActorToSummon
	ActorBase secondActorToSummon

	if phase == 2
		Summon(summonedGoldenSaintWarrior, 0)
	elseif phase == 3
		Summon(summonedDarkSeducerWarrior, 0)
		Summon(summonedDarkSeducerArcher, 1)
	elseif phase == 4
		Summon(summonedGoldenSaintWarrior, 0)
		Summon(summonedGoldenSaintArcher, 1)
	endif
endFunction

function Summon(ActorBase actorToSummon, int index)
	summonMarkerRefs[index].PlaceAtMe(SummonFX)
	currentSummons[index] = summonMarkerRefs[index].PlaceActorAtMe(actorToSummon)

	; Wait for the 3D of the summon to load, then start combat.
	int waitFor3DCounter = 0
	while !currentSummons[index].Is3DLoaded() && waitFor3DCounter < 10
		Utility.Wait(0.1)
		waitFor3DCounter += 1
	endWhile
	currentSummons[index].StartCombat(PlayerRef)
endFunction

function DispelSummons()
	int summonsCount = currentSummons.length
	int i = 0
	while i < summonsCount
		if currentSummons[i]
			currentSummons[i].Kill()
			currentSummons[i] = None
		endif
		i += 1
	endWhile
endFunction

function TeleportToLocation(ObjectReference teleportMarker, bool abAutodetectPlayer = true)
	; Boss teleports to a given location.

	; //// Code below partially from defaultTeleportAbility.psc : Event Teleport()
	;Perform the swap.
	fadeOutFX.play(bossRef)
	bossRef.setGhost(true)
	ObjectReference previousLoc = bossRef.PlaceAtMe(SummonFX)
	Utility.Wait(TELEPORT_SUMMON_FX_DURATION)
	
	TrailFXAbsorb.Play(previousLoc, TELEPORT_TRAIL_FX_DURATION, teleportMarker)
	
	bossRef.MoveTo(teleportMarker)
	bossRef.PlaceAtMe(SummonFX)
	Utility.Wait(TELEPORT_SUMMON_FX_DURATION)
	
	fadeOutFX.Stop(bossRef)
	bossRef.setGhost(false)

	if abAutodetectPlayer
		bossRef.StartCombat(PlayerRef)
		bossRef.CreateDetectionEvent(PlayerRef, 100)
	endif
endFunction