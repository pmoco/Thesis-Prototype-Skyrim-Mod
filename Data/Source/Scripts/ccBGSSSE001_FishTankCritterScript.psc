scriptname ccBGSSSE001_FishTankCritterScript extends ObjectReference

import Utility

; --- Translation Settings
float property fishEnergy = 3.0 autoReadOnly
float property fleeTranslationSpeed = 70.0 autoReadOnly
float Property translationSpeedMean = 35.0 autoReadOnly
float Property translationSpeedVariance = 5.0 autoReadOnly
float property splineCurve = 110.0 autoReadOnly
float property maxRotationSpeed = 360.0 autoReadOnly
float property continueChance = 0.8 autoReadOnly

; --- Pathing Info
ObjectReference[] pathMarkers
int currentPathIndex = 0

bool abRemoved = false

function StartPathing(ObjectReference akStartMarker)
	pathMarkers = new ObjectReference[3]

	; Gather the markers to path to (forms a circular chain of linked refs).
	pathMarkers[0] = akStartMarker
	pathMarkers[1] = akStartMarker.GetLinkedRef()
	pathMarkers[2] = pathMarkers[1].GetLinkedRef()

	TryToMoveToNextMarker()
endFunction

Event OnUpdate()
	if !abRemoved
		TryToMoveToNextMarker()
	endif
endEvent

function OnLoad()
	if pathMarkers
		RegisterForSingleUpdate(RandomFloat(3.0, fishEnergy))
	endif
endFunction

function TryToMoveToNextMarker(bool abFast = false)
	if !Is3DLoaded()
		return
	endif

	currentPathIndex += 1
	currentPathIndex %= pathMarkers.Length

	float speed
	if abFast
		; If reacting to a hit, stop the previous request.
		StopTranslation()
		speed = fleeTranslationSpeed
	else
		float speedMean = GetTranslationSpeedMean()
		speed = RandomFloat(speedMean - translationSpeedVariance, speedMean + translationSpeedVariance)
	endif

	SplineTranslateToRef(pathMarkers[currentPathIndex], GetSplineCurve(), speed, maxRotationSpeed)
endFunction

function StopPathing()
	abRemoved = true
	StopTranslation()
endFunction

Event OnTranslationAlmostComplete()
	; Most of the time, just continue to the next point without stopping.
	if RandomFloat(0.0, 1.0) <= continueChance
		TryToMoveToNextMarker()
	else
		RegisterForSingleUpdate(RandomFloat(1.0, fishEnergy))
	endif
endEvent

float function GetSplineCurve()
	return splineCurve
endFunction

float function GetTranslationSpeedMean()
	return translationSpeedMean
endFunction