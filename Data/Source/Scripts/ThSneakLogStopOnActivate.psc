Scriptname ThSneakLogStopOnActivate extends ObjectReference  



ThesisSneakLogger  property sneakL Auto


bool unused =true

event OnActivate(ObjectReference akActionRef)

	if (unused) 
		sneakL.EndLogging()
		unused = false
	endif
endevent