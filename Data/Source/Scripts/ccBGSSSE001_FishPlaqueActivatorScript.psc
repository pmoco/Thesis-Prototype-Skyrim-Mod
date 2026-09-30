scriptname ccBGSSSE001_FishPlaqueActivatorScript extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	(GetLinkedRef() as ccBGSSSE001_FishPlaqueScript).PlaqueActivated()
endEvent