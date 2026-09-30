Scriptname ccBGSSSE001_CatapultCtrlScript extends ObjectReference  
{ Handles controlling the catapult from the winch arms on either side of the catapult, which are activatable trigger volumes. }

Actor property PlayerRef auto
Spell property CatapultVolley auto
ObjectReference[] property reloadTriggers auto
ObjectReference[] property fireTriggers auto
Message property noPotErrorMessage auto
MiscObject property FlamingPot auto
ccBGSSSE001_CatapultMonitor property CatapultMonitor auto
int property noPotObjective auto

int property STATE_FIRED = 0 autoReadOnly
int property STATE_RELOADING = 1 autoReadOnly
int property STATE_LOADED = 2 autoReadOnly
int property STATE_FIRING = 3 autoReadOnly
int property STATE_DISABLED = 4 autoReadOnly

int property ALLOW_INTERACT_STAGE = 300 AutoReadOnly

; Animations
string property ANIM_FIRE = "fire" autoReadOnly						; Cause the catapult arm to fly up and launch the payload
string property ANIM_RELOAD = "reload" autoReadOnly					; Cause the catapult arm to lower and spawn a new payload
string property ANIM_START_FIRED = "startFired" autoReadOnly		; Start catapult in the fired position

; Animation Events
string property ANIM_EVENT_LAUNCH = "launch" autoReadOnly			; Sent at the moment the payload leaves the arm
string property ANIM_EVENT_FIRED = "fired" autoReadOnly				; Sent when the launch animation is complete and it's safe to allow activate events to load it again
string property ANIM_EVENT_RELOADED = "reloaded" autoReadOnly		; Sent when the reload animation is finished and it's safe to allow activate events to launch it again

int currentCatapultState = 0 ; STATE_FIRED


Event OnLoad()
	WaitForCatapultLoaded()
	RegisterForAnimationEvents()

	if currentCatapultState == STATE_FIRED
		GetLinkedRef().PlayAnimation(ANIM_START_FIRED)
		DisableFireTriggers()
		EnableReloadTriggers()
	elseif currentCatapultState == STATE_LOADED
		GetLinkedRef().PlayAnimation(ANIM_RELOAD)
		DisableReloadTriggers()
		EnableFireTriggers()
	endif
endEvent

function WaitForCatapultLoaded()
	ObjectReference myCatapult = GetLinkedRef()
	while !myCatapult.Is3DLoaded()
		Utility.Wait(0.5)
	endWhile
endFunction

Event OnUnload()
	UnregisterForAnimationEvents()
endEvent

function RegisterForAnimationEvents()
	ObjectReference myCatapult = GetLinkedRef()
	RegisterForAnimationEvent(myCatapult, ANIM_EVENT_LAUNCH)
	RegisterForAnimationEvent(myCatapult, ANIM_EVENT_RELOADED)
endFunction

function UnregisterForAnimationEvents()
	ObjectReference myCatapult = GetLinkedRef()
	UnregisterForAnimationEvent(myCatapult, ANIM_EVENT_LAUNCH)
	UnregisterForAnimationEvent(myCatapult, ANIM_EVENT_RELOADED)
endFunction

; Called by the winch activator.
function Reload(ObjectReference akActivator)
	GoToState("Busy")

	if akActivator != PlayerRef
		GoToState("")
		return
	endif

	if CatapultMonitor.GetStage() != ALLOW_INTERACT_STAGE
		GoToState("")
		return
	endif

	if currentCatapultState == STATE_FIRED
		if PlayerRef.GetItemCount(FlamingPot) > 0
			PlayerRef.RemoveItem(FlamingPot, 1)
			SetReloadingState()
		else
			noPotErrorMessage.Show()
			if !CatapultMonitor.IsObjectiveDisplayed(noPotObjective) || CatapultMonitor.IsObjectiveCompleted(noPotObjective)
				CatapultMonitor.SetObjectiveCompleted(noPotObjective, false)
				CatapultMonitor.SetObjectiveDisplayed(noPotObjective, abForce = true)
			endif
		endif
	endif

	GoToState("")
endFunction

; Called by the winch activator.
function Fire(ObjectReference akActivator)
	GoToState("Busy")

	if akActivator != PlayerRef
		GoToState("")
		return
	endif

	if CatapultMonitor.GetStage() != ALLOW_INTERACT_STAGE
		GoToState("")
		return
	endif

	if currentCatapultState == STATE_LOADED
		SetFiringState()
		CatapultMonitor.RegisterCatapultHit()
	endif

	GoToState("")
endFunction

function SetReloadingState()
	currentCatapultState = STATE_RELOADING
	DisableReloadTriggers()

	GetLinkedRef().PlayAnimationAndWait(ANIM_RELOAD, ANIM_EVENT_RELOADED)
	SetLoadedState()
endFunction

function SetLoadedState()
	currentCatapultState = STATE_LOADED
	EnableFireTriggers()
endFunction

function SetFiringState()
	currentCatapultState = STATE_FIRING
	DisableFireTriggers()

	ObjectReference myCatapult = GetLinkedRef()
	myCatapult.PlayAnimationAndWait(ANIM_FIRE, ANIM_EVENT_LAUNCH)
	CatapultVolley.Cast(myCatapult, myCatapult.GetLinkedRef())

	SetFiredState()
endFunction

function SetFiredState()
	currentCatapultState = STATE_FIRED
	EnableReloadTriggers()
endFunction

function EnableFireTriggers()
	int i = 0
	while i < fireTriggers.Length
		fireTriggers[i].EnableNoWait()
		i += 1
	endWhile
endFunction

function DisableFireTriggers()
	int i = 0
	while i < fireTriggers.Length
		fireTriggers[i].DisableNoWait()
		i += 1
	endWhile
endFunction

function EnableReloadTriggers()
	int i = 0
	while i < reloadTriggers.Length
		reloadTriggers[i].EnableNoWait()
		i += 1
	endWhile
endFunction

function DisableReloadTriggers()
	int i = 0
	while i < reloadTriggers.Length
		reloadTriggers[i].DisableNoWait()
		i += 1
	endWhile
endFunction

function SetStateDisabled()
	currentCatapultState = STATE_DISABLED

	DisableFireTriggers()
	DisableReloadTriggers()
endFunction


State Busy
	; Called by the winch activator.
	function Reload(ObjectReference akActivator)
		; Do nothing
	endFunction

	; Called by the winch activator.
	function Fire(ObjectReference akActivator)
		; Do nothing
	endFunction
endState