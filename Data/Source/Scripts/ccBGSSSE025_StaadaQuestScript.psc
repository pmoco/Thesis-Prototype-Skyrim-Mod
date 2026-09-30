Scriptname ccBGSSSE025_StaadaQuestScript extends Quest  

Actor property StaadaRef auto
effectShader property fadeOutFX auto
Activator property SummonFX auto

Event OnUpdate()
	UnsummonStaadaImpl()
endEvent

function UnsummonStaada()
	RegisterForSingleUpdate(1)
endFunction

function UnsummonStaadaImpl()
	SetStage(300)
	StaadaRef.setGhost(true)
	StaadaRef.PlaceAtMe(SummonFX)
	Utility.Wait(1)
	fadeOutFX.play(StaadaRef)
	Utility.Wait(2)
	StaadaRef.Disable()
EndFunction