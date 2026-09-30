Scriptname ccBGS_ARPressurePlateScript extends TrapTriggerBase
{Shared script for Ayleid Pressure Plates. Inherits from TrapTriggerBase, and is based on PressurePlate script.}

;PLEASE NOTE: This inherits from TrapTriggerBase to make it a fully-functional pressure plate. The states, functions, structure are overrides dicated by that script.

State Active

	Event OnBeginState()
		GoToState("DoNothing")

		If(StoredTriggerType == 1)
			Type = 3
			Utility.Wait(0.1)
			Activate(self as ObjectReference)
			Utility.Wait(0.1)
		Else
			Activate(Self as ObjectReference)
		EndIf

		TriggerSound.Play(self)
		If(PlayAnimationAndWait("Stage2","TransitionComplete"))
			If(ObjectsInTrigger == 0)
				GoToState("Inactive")
				PlayAnimation("Stage1")
			EndIf
		EndIf

	EndEvent

	Event OnTriggerEnter(ObjectReference akActionRef)
		ObjectsInTrigger = self.GetTriggerObjectCount()
	EndEvent

	Event OnTriggerLeave(ObjectReference akActionRef)
		ObjectsInTrigger = self.GetTriggerObjectCount()
		If(ObjectsInTrigger == 0)
			GoToState("Inactive")
			PlayAnimation("Stage1")
		EndIf
	EndEvent

EndState

State DoNothing

	Event OnTriggerEnter(ObjectReference akActionRef)
		ObjectsInTrigger = self.GetTriggerObjectCount()
	EndEvent

	Event OnTrigger(ObjectReference triggerRef)
	EndEvent

	Event OnTriggerLeave(ObjectReference akActionRef)
		ObjectsInTrigger = self.GetTriggerObjectCount()
		If(ObjectsInTrigger == 0)
			GoToState("Inactive")
			PlayAnimation("Stage1")
		EndIf
	EndEvent

EndState