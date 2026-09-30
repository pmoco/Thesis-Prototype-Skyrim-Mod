Scriptname RPDefault_TeleportOnActivate extends ObjectReference
{ Teleport the person activating this to some point }

Bool Property bPlayerOnly = true auto
{ If false, any NPC activating can trigger this }

ObjectReference Property TeleportToTarget auto

Event OnActivate(ObjectReference akActivatedBy)
	GoToState("HandlingActivation")
	
	if(! bPlayerOnly || akActivatedBy == Game.GetPlayer())
		akActivatedBy.MoveTo(TeleportToTarget)
	endif
	
	GoToState("")
EndEvent

State HandlingActivation
	Event OnActivate(ObjectReference akActivatedBy)
	EndEvent
EndState