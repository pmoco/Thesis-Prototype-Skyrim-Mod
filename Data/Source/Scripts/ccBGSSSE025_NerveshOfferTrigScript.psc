Scriptname ccBGSSSE025_NerveshOfferTrigScript extends ObjectReference  

Actor property PlayerRef auto
MiscObject property amberOre auto
MiscObject property madnessOre auto
Quest property nerveshatterQuest auto

auto State waiting
	Event OnActivate(ObjectReference akActionRef)
		GoToState("busy")
		if akActionRef == PlayerRef
			if PlayerRef.GetItemCount(amberOre) >= 1 && PlayerRef.GetItemCount(madnessOre) >= 1
				nerveshatterQuest.SetStage(40)
			endif
		endif
		GoToState("waiting")
	endEvent
endState

State busy
	; Do nothing
endState
