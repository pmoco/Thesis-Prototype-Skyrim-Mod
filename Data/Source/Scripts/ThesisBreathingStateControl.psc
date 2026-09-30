Scriptname ThesisBreathingStateControl extends ReferenceAlias  



;=========================================
;====== PLAYER Breathing States
;=========================================

int PROPERTY NEUTRAL 		= 0 AUTO 		;Casual Walking No detection 
int PROPERTY RECOVERING 	= 1 AUTO 		;NO more Threat Recovering HP 
int PROPERTY SNEAK			= 2 AUTO		;Sneaking UNde
int PROPERTY DETECTED 		= 3 AUTO 		;Detected but not found by Enemy  
int PROPERTY COMBAT  		= 4  AUTO		;IN Combat with Enemy  
int PROPERTY CRITICAL 		= 5 AUTO 		; IN combat Low HP 


int CurrentBreathingState = 0

;========================================
;====== ARCHETYPES 

int WARRIOR  = 0
int ROGUE = 1  
int Archetype = -1

;========================================
; ========= Dependencies 

ThesisStateController Controller
ThesisLoggerScript Property Logger Auto

float UpdateInterval = 0.5

;========================================
;============ Vars 

int CurrentInstance = -1 


;====== Init State Controller 
Function RegisterStateController(ThesisStateController sc, float UpdateTime = 0.5 )
    	Controller = sc
    	UpdateInterval =  UpdateTime

	RegisterForSingleUpdate(UpdateInterval )
EndFunction


Function SetArchetype (int arch) 
	Archetype = arch
endFunction


;===================================
;======MAIN LOOP  
; ==================================


Function OnStateChanged(int oldState, int newState)

    if (newState == CurrentBreathingState )
        return
    endif

    CurrentBreathingState = newState

    if (Archetype == WARRIOR)
        ApplyWarriorBreathing(newState)
    else
        ApplyRogueBreathing(newState)
    endif

EndFunction

;========================================
;========= SOUNDS WARRIOR 
Sound Property WarriorHeavy    Auto
Sound Property WarriorRestrained    Auto
Sound Property WarriorReady   Auto
Sound Property WarriorCombat Auto
Sound Property WarrioExhausted    Auto


Function ApplyWarriorBreathing(int NewState)

    StopCurrent()

    if (NewState== NEUTRAL)
        ;currentInstance = RogueWeak.Play(Game.GetPlayer())

    elseif (NewState== RECOVERING)
        currentInstance = WarriorHeavy.Play(Game.GetPlayer())

    elseif (NewState== SNEAK)
        currentInstance = WarriorRestrained.Play(Game.GetPlayer())

    elseif (NewState== DETECTED)
        currentInstance = WarriorReady.Play(Game.GetPlayer())

    elseif (NewState== COMBAT)
        currentInstance = WarriorCombat.Play(Game.GetPlayer())

    elseif (NewState== CRITICAL)
        currentInstance = WarrioExhausted.Play(Game.GetPlayer())
    endif

EndFunction
;========================================
;========= SOUNDS ROGUE 



Sound Property RogueWeak    Auto
Sound Property RogueSneak    Auto
Sound Property RogueTense    Auto
Sound Property RogueCombat    Auto
Sound Property RoguePanic    Auto


Function ApplyRogueBreathing(int NewState)

    	StopCurrent()

    	if (NewState== NEUTRAL)
		;currentInstance = HeartbeatLow.Play(Game.GetPlayer())

    	elseif (NewState== RECOVERING)
        	currentInstance = RogueWeak.Play(Game.GetPlayer())

    	elseif (NewState== SNEAK)
        	currentInstance = RogueWeak.Play(Game.GetPlayer())

    	elseif (NewState== DETECTED)
        	currentInstance = RogueTense.Play(Game.GetPlayer())

    	elseif (NewState== COMBAT)
        	currentInstance = RogueCombat.Play(Game.GetPlayer())

    	elseif (NewState== CRITICAL)
        	currentInstance = RoguePanic.Play(Game.GetPlayer())

    endif

EndFunction


Function StopCurrent()

	if (currentInstance != 0 )
		Sound.StopInstance(currentInstance ) 
		currentInstance = 0 

	EndIF 

EndFunction