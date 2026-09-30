Scriptname ccBGSSSE001_CrabMQ4CatFireTrig extends ObjectReference  

Auto State Ready
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		(GetLinkedRef() as ccBGSSSE001_CatapultCtrlScript).Fire(akActionRef)
		GoToState("Ready")
	endEvent
endState

State Busy
	Event OnActivate(ObjectReference akActionRef)
		; do nothing
	endEvent
endState