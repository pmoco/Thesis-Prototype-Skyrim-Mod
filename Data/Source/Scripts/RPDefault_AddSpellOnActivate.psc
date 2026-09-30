Scriptname RPDefault_AddSpellOnActivate extends ObjectReference
{ Give person activating this a spell }

Bool Property bPlayerOnly = true auto
{ If false, any NPC activating can trigger this }

Spell Property SpellToAdd auto

Bool Property bDoOnce = false auto


Event OnActivate(ObjectReference akActivatedBy)
	; Immediate switch state to prevent spam
	GoToState("HasBeenTriggered")
	
	Actor asActor = akActivatedBy as Actor
	Bool bSpellAdded = false
	if(asActor && (! bPlayerOnly || akActivatedBy == Game.GetPlayer()))
		asActor.AddSpell(SpellToAdd)
		bSpellAdded = true
	endif
	
	if( ! bDoOnce || ! bSpellAdded)
		GoToState("")
	endif
EndEvent

State HasBeenTriggered
	Event OnActivate(objectReference triggerRef)
	EndEvent
EndState