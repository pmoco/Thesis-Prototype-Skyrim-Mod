Scriptname ThesisHealthStateControl extends ReferenceAlias  


ThesisLoggerScript Property Logger Auto

;===== MODULE SETTINGS 
float Property RogueCritTresh = 0.6 Auto
float Property RogueWoundThresh  = 0.9 Auto
float Property WarriorCritTresh = 0.3 Auto
float Property WarriorWoundThresh  = 0.6 Auto

float CriticalThreshold 
float WoundedThreshold  
float UpdateInterval =0.5

int WARRIOR  = 0 
int ROGUE  = 1


int currentState  



ThesisStateController Controller


Function RegisterStateController(ThesisStateController sc, float UpdateTime = 0.5 ,  int arch)
    	Controller = sc
    	UpdateInterval =  UpdateTime
	currentState = Controller.HP_HEALTHY

	if arch== WARRIOR 
		CriticalThreshold = WarriorCritTresh 
		WoundedThreshold = WarriorWoundThresh  

	else 
		CriticalThreshold = RogueCritTresh 
		WoundedThreshold = RogueWoundThresh  
	endif 

	RegisterForSingleUpdate(UpdateInterval )

	

EndFunction

; Health
;int PROPERTY HEALTHY  = 0 AUTO
;int PROPERTY LTH_WOUNDED  = 1 AUTO
;int PROPERTY HEALTH_CRITICAL = 2 AUTO

Event OnUpdate()

	Actor playerActor =  GetActorReference()

	float ratio = playerActor.GetAVPercentage("Health")
	
	int newState =-1

  	 if (ratio <= CriticalThreshold)
		newState = Controller.HP_CRITICAL 
    	elseif (ratio <= WoundedThreshold)
		newState = Controller.HP_WOUNDED
    	else
		newState = Controller.HP_HEALTHY
    	endif

	if (newState != currentState ) 
		currentState  =  newState 
		Controller.SetHealthState(newState) ;
	EndIf 

    	RegisterForSingleUpdate(UpdateInterval )
EndEvent


int Function getCurrentState() 

	return currentState
EndFunction 

