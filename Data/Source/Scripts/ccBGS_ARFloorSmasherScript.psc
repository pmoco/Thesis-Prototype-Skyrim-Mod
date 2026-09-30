Scriptname ccBGS_ARFloorSmasherScript extends ObjectReference
{Shared trap script for floor smasher.}

Actor Property PlayerREF Auto
Bool Property bPlayerOnly = True Auto
Float Property fDelayReturn = 1.5 Auto
Float Property fDelayReset = 5.0 Auto

Sound Property ccBGS_TRP_TRPARFloorSmasherUp01SD Auto
Sound Property ccBGS_TRP_TRPARFloorSmasherDown01SD Auto

Auto State Waiting

	Event OnTriggerEnter(ObjectReference akActionRef)
		If(!bPlayerOnly || akActionRef == PlayerREF)
			GoToState("Busy")
			ccBGS_TRP_TRPARFloorSmasherUp01SD.Play(akActionRef)
			PlayAnimationAndWait("Stage2", "TransitionComplete")
			Utility.Wait(fDelayReturn)
			ccBGS_TRP_TRPARFloorSmasherDown01SD.Play(akActionRef)
			PlayAnimationAndWait("Stage1", "TransitionComplete")
			Utility.Wait(fDelayReset)
			GoToState("Waiting")
		EndIf
	EndEvent

EndState

State Busy
EndState