Scriptname RPDefault_AddToContainerAliasOnLoad extends ReferenceAlias  

ReferenceAlias Property ContainerAlias Auto

Event OnLoad()
	GoToState("HasBeenTriggered")
	
	ContainerAlias.GetRef().AddItem(GetRef())
EndEvent

State HasBeenTriggered
	Event OnLoad()
	EndEvent
EndState