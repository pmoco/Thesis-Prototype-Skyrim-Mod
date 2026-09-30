Scriptname ccBGS_ARSwitchScript extends ObjectReference  
{Shared script for Ayleid activator button}

Bool Property bPlayerOnly = false Auto
Bool Property bIsInDownState = false Auto
Sound Property ActivateSound Auto

Event OnLoad()
	SetDefaultState()
EndEvent

Event OnReset()
	SetDefaultState()
EndEvent

Function SetDefaultState()
	If(bIsInDownState)
		GoToState("PositionDown")
		PlayAnimation("ForceStage2")
	Else
		GoToState("PositionUp")
		PlayAnimation("Reset")
	EndIf
EndFunction

Auto State PositionUp
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		bIsInDownState = True
		ActivateSound.Play(self)
		PlayAnimationAndWait("Stage2", "TransitionComplete")
		GoToState("PositionDown")
	EndEvent
EndState

State PositionDown
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		bIsInDownState = False
		ActivateSound.Play(self)
		PlayAnimationAndWait("Stage1", "TransitionComplete")
		GoToState("PositionUp")
	EndEvent
EndState

State Busy
EndState