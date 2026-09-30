Scriptname RPDefault_OnCombatState extends Actor Hidden

Bool Property bPlayerOnly = false auto
{ Set to true if only combat with the player or their companions/summons should trigger this }

Int Property iCombatState = 1 auto
{ 0 = Left or ended combat, 1 = Entered combat, 2 = Searching for their target (usually because of stealth) }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	GoToState("Completed")
	
	Bool bTriggered = false
	if(aeCombatState == iCombatState)
		; Correct combat state
		if( ! bPlayerOnly || akTarget == Game.GetPlayer() || akTarget.IsPlayerTeammate())
			; Correct person was the target
			bTriggered = HandleCombatStateChanged(akTarget, aeCombatState)
		endif
	endif
	
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
endEvent

State Completed
	Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
		; Do nothing
	EndEvent
EndState

Bool Function HandleCombatStateChanged(Actor akTarget, int aeCombatState)
	; Extend me
	return true
EndFunction