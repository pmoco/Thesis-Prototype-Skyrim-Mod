Scriptname RPDefault_OnDeathAlias extends ReferenceAlias


Bool Property bKilledByPlayerOnly = false auto
{ Set to true to only trigger if the player was responsible for killing }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnDeath(Actor akKiller)
	GoToState("Completed")
	
	Bool bTriggered = false
	if( ! bKilledByPlayerOnly || akKiller == Game.GetPlayer())
		bTriggered = HandleDeath(akKiller)
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent

State Completed
	Event OnDeath(Actor akKiller)
		; Do nothing
	EndEvent
EndState

Bool Function HandleDeath(Actor akKiller)
	; Extend me
	return true
EndFunction