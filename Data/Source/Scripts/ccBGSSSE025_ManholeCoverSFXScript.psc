Scriptname ccBGSSSE025_ManholeCoverSFXScript extends ObjectReference  

Sound property SFX auto

Event OnActivate(ObjectReference akActivator)
	Actor PlayerRef = Game.GetPlayer()
	if akActivator == PlayerRef
		; Wait for the player to enter the new space
		Utility.Wait(0.5)
		int soundInstance = SFX.Play(PlayerRef)
	endif
endEvent