Scriptname ThesisStateController extends Quest  

; === Input Modules ===
ThesisCombatStateControl Property CombatModule Auto
ThesisHealthStateControl Property HealthModule Auto


; === Output ===

Thesis_HeartbeatRogue Property HeartbeatRogue Auto
Thesis_HeartbeatWarrior Property HeartbeatWarrior Auto

Thesis_BreathingRogue Property BreathingRogue Auto
Thesis_BreathingWarrior Property BreathingWarrior Auto


ThesisAudioController Property AudioController Auto
ThesisLoggerScript Property  Logger Auto
string PROPERTY  Prefix  = "{STATE_CONTROLLER}" Auto
bool Property  WriteToScreen = True Auto


;Context / Combat and Sneak

int PROPERTY CB_NEUTRAL = 0 AUTO 	;Casual Walking No detection 
int PROPERTY CB_SNEAK = 1 Auto  		;Sneak UNDETECTED 
int PROPERTY CB_SNEAKDET =2 AUTO      ; SNEAK DETECTED  
int PROPERTY CB_DETECTED = 3 AUTO 	;Detected but not found by Enemy  
int PROPERTY CB_COMBAT  = 4 AUTO		;IN Combat with Enemy  

; Health
int PROPERTY HP_HEALTHY  = 0 AUTO
int PROPERTY HP_WOUNDED  = 1 AUTO
int PROPERTY HP_CRITICAL = 2 AUTO

; Archetype
int PROPERTY ARCH_WARRIOR = 0 AUTO
int PROPERTY ARCH_ROGUE   = 1 AUTO

Float Property UpdateInterval = 0.5 Auto



; === Current resolved state ===

int CurrentContext
int CurrentHealth 
int Archetype = -1




;========================================================
; === MAIN DEVELOPMENT =================================
;========================================================
Event OnInit()
	
	CurrentContext = CB_NEUTRAL
   	CurrentHealth  = HP_HEALTHY

    	RegisterModules()
EndEvent


;==== LINKS Thesis State Controler to the Modules =================
Function RegisterModules()
	CombatModule.RegisterStateController(self, UpdateInterval )

EndFunction



Function RegisterRogueModules() 
 	HealthModule.RegisterStateController(self, UpdateInterval , ARCH_ROGUE)

	HeartbeatRogue.RegisterStateController(self, UpdateInterval )
	BreathingRogue.RegisterStateController(self, UpdateInterval )

	UpdateRogueModules()
EndFunction 



Function RegisterWarriorModules() 
	HealthModule.RegisterStateController(self, UpdateInterval , ARCH_WARRIOR)
	HeartbeatWarrior.RegisterStateController(self, UpdateInterval )
	BreathingWarrior.RegisterStateController(self, UpdateInterval )
	
	UpdateWarriorModules() 

EndFunction 

;==========State Resolution  ===============


int previousState = -1

Function ResolveState()
    ; Central place where layering happens

	If Archetype == ARCH_WARRIOR
		UpdateWarriorModules() 
	elseif  Archetype == ARCH_ROGUE
		UpdateRogueModules() 
	else 
		return
	endIf 

EndFunction



Function UpdateWarriorModules() 
	HeartbeatWarrior.OnStateChanged( CurrentContext , CurrentHealth   ) 
	BreathingWarrior.OnStateChanged(  CurrentContext , CurrentHealth   ) 
EndFunction 

Function UpdateRogueModules() 
	HeartbeatRogue.OnStateChanged(  CurrentContext , CurrentHealth   ) 
	BreathingRogue.OnStateChanged(  CurrentContext , CurrentHealth   ) 

EndFunction 



;=======================================
;=========GETTERS ======================
;=======================================

int Function GetHealth() 
	return	CurrentHealth 
EndFunction

int Function GetContext() 
	return CurrentContext 
EndFunction


int Function GetArchetype() 
	return Archetype 
EndFunction

bool function isPlayerInDanger() 
	if (CurrentContext == CB_NEUTRAL || CurrentContext ==CB_SNEAK)
		return False
	else 
		Return True 
	EndIF  
endFunction

;========================================
;=========SETTERS=======================
;========================================
Function SetHealthState(int newHealth)

    	if (CurrentHealth != newHealth)
       	 CurrentHealth = newHealth
       	 ResolveState()
    	endif
EndFunction

Function SetArchetype(int newArch)
	Archetype = newArch
    	AudioController.SetAudiobyArchetype(Archetype ) 
	
	if Archetype ==  ARCH_ROGUE
		RegisterRogueModules()
	else 
		RegisterWarriorModules()
	Endif

EndFunction

Function setContextState(int newContext ) 
	if (currentContext !=  newContext )
		currentContext = newContext 
		ResolveState()

	endif

EndFunction


;=============================
;======SUPPORT 


string Function HealthToString() 
	
	if (CurrentHealth == HP_HEALTHY ) 
		return "HEALTHY"
	elseif (CurrentHealth == HP_WOUNDED )
		return "WOUNDED "
	elseif (CurrentHealth == HP_CRITICAL  )
		return " LIFE CRITICAL "
	EndIF

	return "UNKNOWN"
EndFunction 


String Function  ArchetypeToString ()

	if Archetype ==  ARCH_WARRIOR
		Return "Warrior"
	elseif Archetype == ARCH_ROGUE 
		Return "Rogue"

	EndIf 
	return "UNKNOWN"

EndFunction


string Function DebugState()

    return " | HP=" + HealthToString() +    " | CTX=" + CombatModule.printState() 

EndFunction



