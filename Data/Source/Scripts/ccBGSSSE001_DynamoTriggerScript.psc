Scriptname ccBGSSSE001_DynamoTriggerScript extends ObjectReference  
{ Modified copy of DLC2defaultSlottedItemActivatorScript for the Misc Dwarven Fishing quest. }

import debug
import utility

bool property isOn = false	auto
{set to true to start open}

bool property itemIsNotRemovable = false auto
{if this item cannot be removed once slotted set this to true
	default = false}

bool property isAnimating = false auto Hidden
{is the activator currently animating from one state to another?}

string property onAnim = "on" auto
{animation to play when opening}

string property offAnim = "off" auto
{animation to play when closing}

string property startOnAnim = "startOn" auto
{open event name - waits for this event before considering itself "open"}

string property doneEvent = "done" auto
{close event name - waits for this event before considering itself "closed"}

message property itemNeededMessage auto
{if set, this message is shown when the player activates this and does not have the required item}

miscObject property requiredItem auto
{This is the object to be slotted into the activator}

bool alreadyTriggered = false

EVENT OnLoad()
	blockActivation()
	SetNoFavorAllowed()
	if isOn
		playAnimation(startOnAnim)
		GoToState("On")
		if itemIsNotRemovable
			setDestroyed(True)
		endif
	endif
endEVENT

Event OnReset()
	reset()
	setDestroyed(false)
EndEvent

auto STATE off	; waiting to be activated
	EVENT onActivate (objectReference akActivator)
		GoToState("busy")
		string stateToGoTo = "off"

		if akActivator == game.getPlayer() && !alreadyTriggered	
			if akActivator.getItemCount(requiredItem) >= 1
				akActivator.removeItem(requiredItem, 1, true)
				playAnimationandwait(onAnim, doneEvent)
				self.Activate(self, true)
				isOn = True
				if itemIsNotRemovable
					setDestroyed(True)
				endif

				alreadyTriggered = true
				stateToGoTo = "on"
			Else
				itemNeededMessage.show()
			endif
		endif

		GoToState(stateToGoTo)
	endEVENT
endState

STATE busy
	event onActivate(objectReference akActivator)
		; Do nothing
	endEVENT
endSTATE

STATE on
	EVENT onActivate (objectReference akActivator)
		GoToState("busy")
		if itemIsNotRemovable
			; Do nothing
			GoToState("on")
		else
			akActivator.addItem(requiredItem, 1, true)
			playAnimationandwait(offAnim, doneEvent)
			isOn = False
			
			GoToState("off")
			setDestroyed(True)
		endif
	endEVENT
endSTATE

function AllowItemRemoval()
	itemIsNotRemovable = false
	setDestroyed(false)
endFunction
