Scriptname ccBGS_ARPortcullisScript extends ObjectReference
{Shared script for Ayleid gates and secret doors. LinkedRefs with LinkCustom01 will be disabled/enabled with animations, e.g. collision volumes or navcuts.}

Keyword Property LinkCustom01 Auto
{Link keyword for enable/disable}

Bool Property bDownByDefault = False Auto
{Set whether it's Down by default or not}

Bool Property bDoOnce = False Auto
{Only open/close once}

Bool Property bCanActorsOpen = False Auto
{Allow actors to open/close directly}

Message Property MessageToShow Auto
{Optional message to show if player is not allowed to activate}

Sound Property SoundOpen Auto
Sound Property SoundClose Auto

ObjectReference LinkedObject

Event OnLoad()
	SetDefaultState()
EndEvent

Event OnReset()
	SetDefaultState()
EndEvent

Function SetDefaultState()
	If(bDownByDefault)
		GoToState("Down")
		PlayAnimation("Stage2") ;Down
		DisableLinkedRef()
	Else
		GoToState("Up")
		PlayAnimation("Stage1") ;Up
		EnableLinkedRef()
	EndIf
EndFunction

Auto State Up
	Event OnActivate(ObjectReference akActionRef)
		If(bCanActorsOpen || !akActionRef.GetBaseObject() as ActorBase)
			GoToState("Busy")
			SoundOpen.Play(self)
			PlayAnimationAndWait("Stage2", "TransitionComplete")
			DisableLinkedRef()
			If(bDoOnce)
				GoToState("Finished")
			Else
				GoToState("Down")
			EndIf
		Else
			MessageToShow.Show()
		EndIf
	EndEvent
EndState

State Down
	Event OnActivate(ObjectReference akActionRef)
		If(bCanActorsOpen || !akActionRef.GetBaseObject() as ActorBase)
			GoToState("Busy")
			EnableLinkedRef()
			SoundClose.Play(self)
			PlayAnimationAndWait("Stage1", "TransitionComplete")
			If(bDoOnce)
				GoToState("Finished")
			Else
				GoToState("Up")
			EndIf
		Else
			MessageToShow.Show()
		EndIf
	EndEvent
EndState

State Busy
EndState

State Finished
EndState

Function EnableLinkedRef()
	LinkedObject = GetLinkedRef(LinkCustom01)
	If(LinkedObject)
		LinkedObject.EnableNoWait()
	EndIf
EndFunction

Function DisableLinkedRef()
	LinkedObject = GetLinkedRef(LinkCustom01)
	If(LinkedObject)
		LinkedObject.DisableNoWait()
	EndIf
EndFunction