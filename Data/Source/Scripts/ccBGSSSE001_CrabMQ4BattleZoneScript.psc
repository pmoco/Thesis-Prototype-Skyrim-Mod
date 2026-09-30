Scriptname ccBGSSSE001_CrabMQ4BattleZoneScript extends ObjectReference  
{ Handles the area-wide effects of the battle zone, as well as leaving and re-entering the battle zone. }

Actor property PlayerRef auto
MusicType property BossMusic auto
Weather property BattleWeather auto

int currentMusicType = 0

int triggerCounter = 0
bool working = false

int property MUSIC_TYPE_NONE = 0 AutoReadOnly
int property MUSIC_TYPE_BOSS = 1 autoReadOnly

Event OnTriggerEnter(ObjectReference akActionRef)
	if akActionRef == PlayerRef
		while working
			Utility.Wait(0.25)
		EndWhile
		working = true

		triggerCounter += 1
		CheckZonePlayback()

		working = false
	endif
endEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	if akActionRef == PlayerRef
		while working
			Utility.Wait(0.25)
		EndWhile
		working = true

		triggerCounter -= 1
		CheckZonePlayback()
		
		working = false
	endif
endEvent

function CheckZonePlayback()
	if triggerCounter == 0
		SuspendWeatherAndMusic()
	elseif triggerCounter == 1
		PlayWeatherAndMusic()
	endif
endFunction

Event OnUnload()
	SuspendWeatherAndMusic()
endEvent

function RemoveZone()
	StopWeatherAndMusic()
	Disable()
	Delete()
endFunction

function SetAndPlayBossMusic()
	currentMusicType = MUSIC_TYPE_BOSS
	BossMusic.Add()
endFunction

function SetAndPlayNoMusic()
	currentMusicType = MUSIC_TYPE_NONE
	StopMusic()
endFunction

function StopMusic()
	BossMusic.Remove()
endFunction

function PlayWeatherAndMusic()
	BattleWeather.SetActive(true)

	if currentMusicType == MUSIC_TYPE_BOSS
		BossMusic.Add()
	endif
endFunction

function SuspendWeatherAndMusic()
	; Allows music to resume after returning to the zone.
	Weather.ReleaseOverride()
	StopMusic()
endFunction

function StopWeatherAndMusic()
	; Does not allow music to resume after returning to the zone.
	Weather.ReleaseOverride()
	SetAndPlayNoMusic()
endFunction
