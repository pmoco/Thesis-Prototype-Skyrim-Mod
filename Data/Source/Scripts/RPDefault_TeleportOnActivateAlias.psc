Scriptname RPDefault_TeleportOnActivateAlias extends ReferenceAlias
{ Teleport the person activating this to some point }

Bool Property bPlayerOnly = true auto
{ If false, any NPC activating can trigger this }

ReferenceAlias Property TeleportToTargetAlias auto

Event OnActivate(ObjectReference akActivatedBy)
	GoToState("HandlingActivation")
	
	if(! bPlayerOnly || akActivatedBy == Game.GetPlayer())
		akActivatedBy.MoveTo(TeleportToTargetAlias.GetRef())
	endif
	
	GoToState("")
EndEvent

State HandlingActivation
	Event OnActivate(ObjectReference akActivatedBy)
	EndEvent
EndState