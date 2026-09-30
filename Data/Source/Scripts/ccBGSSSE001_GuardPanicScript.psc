Scriptname ccBGSSSE001_GuardPanicScript extends ReferenceAlias  

MagicEffect property InvisibilityEffect auto
Topic property Flee auto
Topic property WhatHappened auto

float UPDATE_INTERVAL = 4.0	

function StartPanicking()
	Panic()
endFunction

Event OnUpdate()
	Panic()
endEvent

function Panic()
	Actor mySelf = self.GetActorRef()
	mySelf.Say(Flee)

	if mySelf.HasMagicEffect(InvisibilityEffect)
		RegisterForSingleUpdate(UPDATE_INTERVAL)
	else
		mySelf.Say(WhatHappened)
	endif
endFunction