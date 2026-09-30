Scriptname ccBGS_ARSpikeTrapScript extends HazardBase
{Script for the Ayleid spike trap (inherits from HazardBase)}

Float Property fHazardInterval = 5.0 Auto

Auto State CanHit
	Event OnTrapHit(ObjectReference akTarget, float afXVel, float afYVel, float afZVel, float afXPos, float afYPos, float afZPos, int aeMaterial, bool abInitialHit, int aeMotionType)
		GoToState("CannotHit")
		If(isAngleAcceptable(afXVel, afYVel, afZVel))
			doLocalHit(akTarget, afXVel, afYVel, afZVel, afXPos, afYPos, afZPos, aeMaterial, abInitialHit, aeMotionType)
		EndIf
		RegisterForSingleUpdate(fHazardInterval)
	EndEvent
EndState

Event OnUpdate()
	GoToState("CanHit")
EndEvent