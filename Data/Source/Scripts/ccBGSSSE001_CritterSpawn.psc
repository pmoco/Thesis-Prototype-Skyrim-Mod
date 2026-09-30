scriptName ccBGSSSE001_CritterSpawn extends CritterSpawn
{ A critter spawn script specific to Fishing for spawning fish. Extends CritterSpawn to remain compatible with the existing Critter / CritterFish scripts. }

import Critter
import Utility

Actor property PlayerRef auto

;/
   Prefixed with aaa_CONFIG for grouping these properties at the top in the Properties window,
   as they now constitute all of a streamlined set of configuration properties, the others can be ignored.

   GameHour and PlayerRef must be filled.
 /;
bool property aaa_CONFIG_isLargeShallowSpawner = true auto
{ Is this a large, shallow spawner? Default: True }
bool property aaa_CONFIG_spawnAlways = true auto
{ Should this always spawn? Default: True }
bool property aaa_CONFIG_spawnWhenClearOrSnowWeather = false auto
{ Should this spawn in Clear or Snow weather? Default: false }
bool property aaa_CONFIG_spawnWhenRainWeather = false auto
{ Should this spawn in Rain weather? Default: false }
FormList property aaa_CONFIG_CritterTypes auto
{ Required. The list of fish to spawn. (Overrides CritterTypes) }
int property aaa_CONFIG_MaxCritterCount = 3 auto
{ How many fish should spawn at this spawner? Default: 3 }


float property UPDATE_INTERVAL = 2.0 AutoReadOnly
float property MAX_PLAYER_DISTANCE = 4000.0 AutoReadOnly

; "Small and Deep" spawning profile
float property LEASH_LENGTH_SMALL_DEEP = 128.0 AutoReadOnly
float property LEASH_HEIGHT_SMALL_DEEP = 128.0 AutoReadOnly
float property LEASH_DEPTH_SMALL_DEEP = 128.0 AutoReadOnly

; "Large and Shallow" spawning profile
float property LEASH_LENGTH_LARGE_SHALLOW = 256.0 AutoReadOnly
float property LEASH_HEIGHT_LARGE_SHALLOW = 256.0 AutoReadOnly
float property LEASH_DEPTH_LARGE_SHALLOW = 64.0 AutoReadOnly


Event OnInit()
	; fMaxPlayerDistance is always MAX_PLAYER_DISTANCE for fish, so configure it now.
	fMaxPlayerDistance = MAX_PLAYER_DISTANCE

	; Set base script properties with the values from their equivalents in this script.
	CritterTypes = aaa_CONFIG_CritterTypes
	iMaxCritterCount = aaa_CONFIG_MaxCritterCount
endEvent

Event OnLoad()
	OnUpdate()
endEvent

Event OnUpdate()
	if ShouldSpawnWithinDistanceAndWeather(PlayerRef.GetDistance(self))
		SpawnCritters()
	else
		RegisterForSingleUpdate(UPDATE_INTERVAL)
	endif
endEvent

Event OnUnload()
	UnregisterForUpdate()
endEvent

Event OnCellDetach()
	UnregisterForUpdate()
endEvent

Function SpawnCritters()
	int crittersToSpawn = iMaxCritterCount - iCurrentCritterCount
	
	int i = 0
	while (i < crittersToSpawn)
		SpawnCritterAtRef(self)
		i += 1
	endWhile
endFunction

bool working = false
Event OnCritterDied()
	while working
		Wait(0.25)
	endWhile
	working = true

	if iCurrentCritterCount > 0
		iCurrentCritterCount -= 1
	endif

	working = false
endEvent

Function SpawnCritterAtRef(ObjectReference arSpawnRef)
	Activator critterAct = CritterTypes.GetAt(RandomInt(0, CritterTypes.GetSize() - 1)) as Activator
	
	ObjectReference critterRef = arSpawnRef.PlaceAtMe(critterAct, abInitiallyDisabled = true)
	Critter theCritter = critterRef as Critter
	
	; Set the spawner properties according to a "large and shallow" profile, or a "small and deep" profile, instead of hand-editing each of these values for each spawner.
	if aaa_CONFIG_isLargeShallowSpawner
		theCritter.SetInitialSpawnerProperties(LEASH_LENGTH_LARGE_SHALLOW, LEASH_HEIGHT_LARGE_SHALLOW, LEASH_DEPTH_LARGE_SHALLOW, fMaxPlayerDistance + LEASH_LENGTH_LARGE_SHALLOW, self)
	else
		theCritter.SetInitialSpawnerProperties(LEASH_LENGTH_SMALL_DEEP, LEASH_HEIGHT_SMALL_DEEP, LEASH_DEPTH_SMALL_DEEP, fMaxPlayerDistance + LEASH_LENGTH_SMALL_DEEP, self)
	endif
	iCurrentCritterCount += 1
endFunction

bool Function ShouldSpawnWithinDistanceAndWeather(float afDistanceToPlayer)
	; Used instead of CritterSpawn.ShouldSpawn(), which had a time component that
	; was not desirable by Fishing.

	if afDistanceToPlayer > fMaxPlayerDistance
		return false
	endIf

	if aaa_CONFIG_spawnAlways || PlayerRef.IsInInterior()
		return true
	else
		Weather currentWeather = Weather.GetCurrentWeather()
		int weatherClass = -1
		if currentWeather
			weatherClass = currentWeather.GetClassification()
		endif

		if aaa_CONFIG_spawnWhenClearOrSnowWeather && (!currentWeather || weatherClass < 2 || weatherClass == 3)
			return true
		elseif aaa_CONFIG_spawnWhenRainWeather && weatherClass == 2
			return true
		endif
	endif

	return false
endFunction
