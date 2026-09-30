Scriptname ccBGSSSE001_CrabMQ4CatReloadTrig extends ObjectReference  

Auto State Ready
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		(GetLinkedRef() as ccBGSSSE001_CatapultCtrlScript).Reload(akActionRef)
		GoToState("Ready")
	endEvent
endState

State Busy
	Event OnActivate(ObjectReference akActionRef)
		; do nothing
	endEvent
endState