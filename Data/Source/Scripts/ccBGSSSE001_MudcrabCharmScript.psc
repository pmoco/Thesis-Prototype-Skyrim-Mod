Scriptname ccBGSSSE001_MudcrabCharmScript extends ActiveMagicEffect  

ccBGSSSE001_MudcrabAllyScript property MudcrabAllyQuest auto

ReferenceAlias myAlias
Actor myTarget
Actor myCaster
bool effectExpired = false

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TryToAddAlly(akTarget, akCaster)
EndEvent

function TryToAddAlly(Actor akTarget, Actor akCaster)
	myAlias = MudcrabAllyQuest.TryToAddMudcrabAlly(akTarget, akCaster)

	if !myAlias
		; If we couldn't become the player's ally, try again later while
		; this effect continues to be active.

		myTarget = akTarget
		myCaster = akCaster
		RegisterForSingleUpdate(3)
	else
		; If we returned an alias but the effect has already expired,
		; remove the ally.

		if effectExpired
			MudcrabAllyQuest.RemoveMudcrabAlly(akTarget, myAlias)
		endif
	endif
endFunction

Event OnUpdate()
	TryToAddAlly(myTarget, myCaster)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	effectExpired = true

	; Clear ally status
	if akTarget.IsPlayerTeammate()
		MudcrabAllyQuest.RemoveMudcrabAlly(akTarget, myAlias)
	endif
EndEvent