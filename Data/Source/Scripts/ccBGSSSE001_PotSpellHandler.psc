Scriptname ccBGSSSE001_PotSpellHandler extends ObjectReference  

Race property ccBGSSSE001_MudcrabRaceFlamingPot auto
Spell property ccBGSSSE001_CrabFlamingPotItemSpell auto
Actor property PlayerRef auto
Quest property CrabMQ4 auto
int property noPotObjective auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor myActorNew = akNewContainer as Actor
	if myActorNew && myActorNew.GetRace() == ccBGSSSE001_MudcrabRaceFlamingPot
		myActorNew.AddSpell(ccBGSSSE001_CrabFlamingPotItemSpell)
	elseif CrabMQ4.IsRunning() && myActorNew == PlayerRef && CrabMQ4.IsObjectiveDisplayed(noPotObjective)
		CrabMQ4.SetObjectiveCompleted(noPotObjective)
	endif

	Actor myActorOld = akOldContainer as Actor
	if myActorOld && myActorOld.GetRace() == ccBGSSSE001_MudcrabRaceFlamingPot
		myActorOld.RemoveSpell(ccBGSSSE001_CrabFlamingPotItemSpell)
	endif
endEvent
