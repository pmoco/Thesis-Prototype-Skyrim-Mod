scriptName defaultButtonSCRIPT extends objectReference
{quick script for a button object.}

bool property useOnce = FALSE auto
{Can be used only once? Default: FALSE}

int SoundInstance = -1
bool property AlertGuards = false Auto


int Property Intensity = 20  Auto


auto STATE active
	EVENT onActivate(objectReference actronaut)
		;playAnimationandWait("down")
		playAnimation("down")
		gotoState("inactive")
		

		if AlertGuards 
			self.CreateDetectionEvent( Game.GetPlayer(), Intensity ) 
		endIF 

		if ( useOnce )
			activate(self as ObjectReference)
			playAnimation("up")
		 	BlockActivation(True)
		else 
			activate(self as ObjectReference)
			playAnimation("up")
			gotoState("active")
		endIf 
			
	endEVENT


	event OnTriggerEnter (objectReference triggerRef)
		activate(self as ObjectReference)

	endevent 


endSTATE

STATE inactive
	; do nothing in this state
	
endSTATE

int Property TriggerType  Auto  

