Scriptname WRDrawBridge01SCRIPT extends ObjectReference  
{Handles the animation of the Whiterun Drawbridge.}

import game
import debug
import utility
import quest

Keyword Property LinkCustom01 Auto
Keyword Property LinkCustom02 Auto

ObjectReference Property Drawbridge Auto Hidden
ObjectReference Property Collision Auto Hidden
ObjectReference Property PartnerLever Auto Hidden

Quest Property CWSiege Auto

EVENT OnLoad()
	Wait(3)
	Drawbridge = GetLinkedRef()
	Collision = GetLinkedRef(LinkCustom01)
	PartnerLever = GetLinkedRef(LinkCustom02)
endEVENt

Function LowerDrawbridge()
	Debug.Trace(self + "LowerDrawbridge()")
	Drawbridge.PlayGamebryoAnimation("Backward", TRUE)
	Collision.Disable()
EndFunction

Function RaiseDrawbridge()
	Debug.Trace(self + "RaiseDrawbridge()")
	Drawbridge.PlayGamebryoAnimation("Forward", TRUE)
	Collision.Enable()
EndFunction

STATE ReadyForClose
	
	EVENT onActivate(ObjectReference TriggerRef)
		if (CWSiege as CWSiegeScript).IsAttack()
			RaiseDrawbridge()
			GoToState("Done")
		else
			if TriggerRef == GetPlayer()
				; Player cannot activate this on defense
			else
				RaiseDrawbridge()
				GoToState("Done")
			endif
		endif
	endEVENT
	
endSTATE

AUTO STATE ReadyForOpen

	EVENT onActivate(ObjectReference TriggerRef)
		if (CWSiege as CWSiegeScript).IsAttack()
			LowerDrawbridge()
			GoToState("Done")
		else
			if TriggerRef == GetPlayer()
				; Player cannot activate this on defense
			else
				LowerDrawbridge()
				(PartnerLever as WRDrawBridge01SCRIPT).GoToState("Done")
				GoToState("Done")
			endif
		endif
	endEVENT
	
endSTATE

STATE Done
	EVENT OnBeginState()
		self.Disable()
		PartnerLever.Disable()
	endEvent
endSTATE
