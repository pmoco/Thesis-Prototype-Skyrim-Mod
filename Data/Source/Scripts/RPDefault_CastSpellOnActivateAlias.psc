Scriptname RPDefault_CastSpellOnActivateAlias extends ReferenceAlias
{ Cast a spell when this is activated }

Bool Property bPlayerOnly = true auto
{ If false, any NPC activating can trigger this }

Spell Property SpellToCast auto

Bool Property bUseActivatorAsSource = false auto
{ If true, the person activating this will be the source of the spell }

Bool Property bBlameActivatorForCast = false auto
{ If true, and bUseActivatorAsSource is true, the activating actor will be blamed for any crime the spell causes }

ReferenceAlias Property SpellTargetAlias auto
{ (Optional) The target of the spell. If not set, the activating actor will be the target. }

Bool Property bDoOnce = false auto
{ If true, this will be disabled after first use }

Event OnActivate(ObjectReference akActivatedBy)
	; Immediate state switch to prevent spam
	GoToState("HasBeenTriggered")
	
	Bool bCastSuccessful = false
	Actor asActor = akActivatedBy as Actor
	if(asActor && (! bPlayerOnly || akActivatedBy == Game.GetPlayer()))
		; Correct person activated
		ObjectReference kSourceRef = GetRef()
		if(bUseActivatorAsSource)
			kSourceRef = akActivatedBy
		endif
		
		ObjectReference kTargetRef = akActivatedBy
		if(SpellTargetAlias != None)
			kTargetRef = SpellTargetAlias.GetRef()
		endif
		
		if(bUseActivatorAsSource && bBlameActivatorForCast)
			; Use RemoteCast
			SpellToCast.RemoteCast(kSourceRef, asActor, kTargetRef)
		else
			SpellToCast.Cast(kSourceRef, kTargetRef)
		endif
		
		bCastSuccessful = true
	endif
	
	if( ! bCastSuccessful || ! bDoOnce)
		GoToState("")
	endif
EndEvent

State HasBeenTriggered
	Event OnActivate(objectReference triggerRef)
	EndEvent
EndState