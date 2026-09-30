Scriptname ccBGSSSE025_WIKillThugScript extends ReferenceAlias  

ccBGSSSE025_WIKillScript property KillScript auto

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if akTarget == Game.GetPlayer() && aeCombatState == 1
		GetOwningQuest().SetStage(1)
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	KillScript.CheckThugDeath()
EndEvent

Event OnUnload()
	if GetOwningQuest().GetStage() == 2
		self.GetActorRef().Delete()
		KillScript.ThugDeleted()
	endif
endEvent