Scriptname PetFramework_PetScript extends Actor  
{Proxy functions that are called via main/parent quest dialogue, which in turn call up to the Child PetQuest functions.}
;rvogel 9/28/17

PetFramework_PetQuest Property PetQuest Auto

;These are all just proxy / "passthru" functions to access the actual quest functions.  The parent shared dialogue quest has no references to the PetQuest, so the pet itself acts as the "public" object proxy when dialogue commands are initiated.

;An alternate way to do this could be to call Actor.PetQuest.Function() directly in the dialogue instead of using these proxy functions, but I wanted to keep everything sort of decoupled/'sealed' from each other.

Function FollowPlayer(Bool snapIntoInteraction = False)
	DEBUG.TRACE("pet quest: " + PetQuest)
	debug.trace("Follow Player called from dialogue")
	PetQuest.FollowPlayer(snapIntoInteraction)
EndFunction

Function WaitForPlayer(Bool doWait = True)
	DEBUG.TRACE("pet quest: " + PetQuest)
	debug.trace("Wait for Player called from dialogue")
	PetQuest.WaitForPlayer(doWait)
EndFunction

Function SetNewHome(ReferenceAlias newLocation, Bool dismiss = True, Bool doWarp = False)
	DEBUG.TRACE("pet quest: " + PetQuest)
	debug.trace("Set New Home called from Dialogue")
	PetQuest.SetNewHome(newLocation, dismiss, doWarp)
EndFunction

Function SetHomeToCurrentLocation()
	PetQuest.SetHomeToCurrentLocation()
EndFunction
