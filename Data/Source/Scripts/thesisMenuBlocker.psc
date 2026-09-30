Scriptname thesisMenuBlocker extends Actor  



Event OnInit()
	BlockActivation(True)
EndEvent 

Event OnActivate(ObjectReference akActionRef)

    	if (akActionRef == Game.GetPlayer() )
        	Debug.Notification("You cannot loot this body.")
        	return
    	endif
	
	Debug.Notification("You cannotxczxc loot this body.")
    	; allow normal behavior otherwise
    	Activate(akActionRef)
	


EndEvent

Event OnDying(Actor akKiller)

	BlockActivation(True)
EndEvent