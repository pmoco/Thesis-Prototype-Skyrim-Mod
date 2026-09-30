scriptname ccBGSSSE001_RadiantFishEventListener extends Quest
{ Attached to quests to listen to catch events from specific fishing supplies. }

ccBGSSSE001_FishingSystemScript property FishingSystem auto
{ The system that handles all fishing gameplay mechanics. }
GlobalVariable property ccBGSSSE001_CatchTypeSmallFish auto ; constant
GlobalVariable property ccBGSSSE001_CatchTypeLargeFish auto ; constant
GlobalVariable property ccBGSSSE001_CatchTypeObject auto ; constant
ReferenceAlias property FishingSpot auto

function CatchEvent(Form akCaughtForm, int aiType)
	; EXTEND
endFunction

function RegisterListener()
	FishingSystem.RegisterRadiantFishEventListener(self)
endFunction

function UnregisterListener()
	FishingSystem.UnregisterRadiantFishEventListener()
endFunction