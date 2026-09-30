Scriptname ccBGS_ARButtonScript extends ObjectReference
{Shared script for Ayleid button}

Bool Property bPlayerOnly = false Auto
Sound Property ActivateSound Auto

Auto State Waiting
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
			If(bPlayerOnly && akActionRef == Game.GetPlayer() || !bPlayerOnly)
				ActivateSound.Play(self)
				PlayAnimationAndWait("Stage2ReturnStage1", "TransitionComplete")
			EndIf
		GoToState("Waiting")
	EndEvent
EndState

State Busy
EndState