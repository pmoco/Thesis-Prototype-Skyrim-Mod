Scriptname ccBGSSSE001_CrabMQ4Reinforcements extends Quest  

GlobalVariable property UseReinforcementsPackages auto
ObjectReference property ReinforcementsSpawnMarker auto
ActorBase property SonsGuard auto
ActorBase property ImperialGuard auto

bool spawnImperials = false
bool shouldSpawnReinforcements = true

function SetShouldSpawnReinforcements(bool abSpawnReinforcements = true)
	shouldSpawnReinforcements = abSpawnReinforcements
endFunction

function SetCivilWarSide(bool abIsImperial = false)
	spawnImperials = abIsImperial
endFunction

function GuardDied(ReferenceAlias akAlias)
	Actor myActor
	if shouldSpawnReinforcements
		if UseReinforcementsPackages.GetValueInt() == 0
			UseReinforcementsPackages.SetValueInt(1)
		endif
		if spawnImperials
			myActor = ReinforcementsSpawnMarker.PlaceActorAtMe(ImperialGuard)
		else
			myActor = ReinforcementsSpawnMarker.PlaceActorAtMe(SonsGuard)
		endif

		akAlias.ForceRefTo(myActor)
		myActor.EvaluatePackage()
	endif
endFunction