scriptname ccBGSSSE001_RadiantQuest3Listener extends ccBGSSSE001_RadiantFishEventListener

ccBGSSSE001_RadiantJunkQuest property RadiantJunk auto

function CatchEvent(Form akCaughtForm, int aiType)
	; Report that a radiant item was caught on any item catch.
	if aiType == ccBGSSSE001_CatchTypeObject.GetValueInt()
		RadiantJunk.RadiantItemAdded(1)
	endif
endFunction