Scriptname ThesisCombatStateControl extends ReferenceAlias  

;==References
ThesisLoggerScript Property Logger Auto
ThesisStateController Controller

String Property prefix = "[CombaStatetModule]" 	AUTO


;===Details 
float UpdateInterval =0.5

int currentState   
bool  isSneaking =false 
bool  isFound =false
int CombatCount= 0



;===========State table =============
; [ Sneaking ,    isFound	, CombatCount 	]  
; [  	false 	,	false	, 	  0			] = CB_NEUTRAL 
; [  	true 	,	false	, 	  0			] = CB_SNEAK 
; [  	true 	,	false	, 	  0			] = CB_SNEAKDET 
; [  	false	,	true 	, 	  0			] = CB_DETECTED 
; [  	-    	 	,	true 	, 	 1+			] = CB_COMBAT  

int PROPERTY CB_NEUTRAL = 0 AUTO 	;Casual Walking No detection 
int PROPERTY CB_SNEAK = 1 Auto  		;Sneak UNDETECTED 
int PROPERTY CB_SNEAKDET =2 AUTO      ; SNEAK DETECTED  
int PROPERTY CB_DETECTED = 3 AUTO 	;Detected but not found by Enemy  
int PROPERTY CB_COMBAT  = 4 AUTO		;IN Combat with Enemy  

int Function CheckState() 

	IF 		(isPlayerInCombat())
		return CB_COMBAT
	elseif  	( !isSneaking &&  isFound  &&  !isPlayerInCombat() )
		return CB_DETECTED
	elseif  	(isSneaking &&  isFound  &&  !isPlayerInCombat() )
		return CB_SNEAKDET
	elseif 	( isSneaking   && !isFound && !isPlayerInCombat() )
		return CB_SNEAK
	elseif  	 (   !isSneaking  && !isFound && !isPlayerInCombat() ) 
		return CB_NEUTRAL 
	EndIF 

	return CB_NEUTRAL 
EndFunction 



Function RegisterStateController(ThesisStateController sc, float UpdateTime = 0.5 )
    	Controller = sc
    	UpdateInterval =  UpdateTime
	currentState = CB_NEUTRAL 

	RegisterForSingleUpdate(UpdateInterval )
EndFunction

Event OnUpdate()

	Actor playerActor =  GetActorReference()

	bool change = false 

	if (playerActor.isSneaking() !=  isSneaking)
		isSneaking = !isSneaking
		change = true 
	endIF

	if (playerActor.IsInCombat() !=  isFound)
		isFound= !isFound
		change = true 
	endIF

	if (change)
		ResolveStateChange() 
	endIF 


    	RegisterForSingleUpdate(UpdateInterval )
EndEvent


Function ResolveStateChange() 

	int newState = CheckState() 

	if (newState != currentState ) 
		currentState  =  newState 
		Controller.setContextState(currentState) 
	EndIf 
EndFunction







;===============================
;======== GETTERS==============


int Function getCurrentState() 

	return currentState
EndFunction 

bool Function isPlayerSneaking() 
	return  isSneaking 
EndFunction

bool Function isPlayerDetected() 
	return isFound 
EndFunction 


bool function isPlayerInCombat () 
	
	return CombatCount > 0 
EndFunction



;========================================
;==========In DIRECT Combat ==============
;=======================================

Function AddEnemyInCombat()

	
	if (CombatCount == 0) 
		;Logger.Log("Enemy Entered Combat") 
		CombatCount = CombatCount + 1
		ResolveStateChange()
	else 
		CombatCount = CombatCount + 1
		;Logger.Log("New Enemy  Entered Combat" + CombatCount ) 
	EndIf 
	
	
	;Logger.Log("New Enemy  Entered Combat" + CombatCount ) 

EndFunction 

Function RemoveEnemyInCombat()
	if (CombatCount > 0)
		CombatCount = CombatCount - 1

		if (CombatCount ==0 )
			ResolveStateChange()
		EndIF
	endIF
	;Logger.Log("Enemy Left Combat" + CombatCount  ) 
	
EndFunction


bool Function InDanger() 

	if (CurrentState == CB_NEUTRAL || CurrentState == CB_SNEAK )
		return FALSE 

	else 
		return TRUE 

	Endif 
	


EndFunction



;==============================
;========SUPPORT =============
;==============================


string Function PrintState() 
	
	if (CurrentState == CB_NEUTRAL )
		return "CB_NEUTRAL"
	elseif (CurrentState == CB_SNEAK )
		return "CB_SNEAK "
	elseif (CurrentState == CB_SNEAKDET )
		return "CB_SNEAK_DETECTED "
	elseif (CurrentState == CB_DETECTED )
		return "CB_DETECTED "
	elseif(CurrentState == CB_COMBAT )
		return "CB_COMBAT "
	Endif
	
	return "CB_NKNOWN"
EndFunction


