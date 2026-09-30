Scriptname ccBGSSSE025_WIKillScript extends WorldInteractionsScript Conditional  
{Extends WorldInteractionsScript which extends Quest}

ReferenceAlias Property Thug1 Auto
ReferenceAlias Property Thug2 Auto
ReferenceAlias Property Thug3 Auto

int property DeleteWhenAbleStage auto

int thugDeleteCount = 0

Function CheckThugDeath()
	if Thug1.GetActorRef().IsDead() && Thug2.GetActorRef().IsDead() && Thug3.GetActorRef().IsDead()
		SetStage(DeleteWhenAbleStage)
	EndIf
EndFunction

function ThugDeleted()
	thugDeleteCount += 1
	if thugDeleteCount >= 3
		Stop()
	endif
endFunction