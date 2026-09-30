Scriptname RPDefault_AddToContainerOnLoad extends ObjectReference  

ObjectReference Property ContainerRef Auto

Event OnLoad()
	GoToState("HasBeenTriggered")
	
	ContainerRef.AddItem(Self)
EndEvent

State HasBeenTriggered
	Event OnLoad()
	EndEvent
EndState