Scriptname Thesis_Breathing extends ReferenceAlias  

;========================================
;======Breathing  ENUM 

int Property CALM  = 0 AUTO
int Property RECOVERING = 1 AUTO
int Property FOCUS  = 2 AUTO
int Property STRAIN = 3 AUTO
int Property ANXIOUS = 4 AUTO
int Property ANTICIPATION = 5 AUTO
int Property UNCOMFORTABLE = 6 AUTO
int Property STRESSED = 7 AUTO
int Property CRIT  = 8 AUTO


;===========State table =============
; [ Sneaking ,    isFound	, CombatCount 	]  
; [  	false 	,	false	, 	  0			] = CB_NEUTRAL 
; [  	true 	,	false	, 	  0			] = CB_SNEAK 
; [  	true 	,	false	, 	  0			] = CB_SNEAKDET 
; [  	false	,	true 	, 	  0			] = CB_DETECTED 
; [  	-    	 	,	true 	, 	 1+			] = CB_COMBAT  

int Property  NEUTRAL = 0  AUTO	;Casual Walking No detection 
int Property   SNEAK = 1 	AUTO	;Sneak UNDETECTED 
int Property  SNEAKDET =2  AUTO; SNEAK DETECTED  
int Property   DETECTED = 3 AUTO	;Detected but not found by Enemy  
int Property   COMBAT  = 4  AUTO		;IN Combat with Enemy  

; Health
int Property  HEALTHY  = 0 AUTO
int Property   WOUNDED  = 1 AUTO
int Property   CRITICAL = 2 AUTO


;========================================
; ========= Dependencies 

ThesisStateController Controller
ThesisLoggerScript Property Logger Auto

float UpdateInterval = 0.5



;========================================
;============ Vars 

int Property  CurrentInstance = -1  Auto
int Property   currentState = -1 Auto
int Property currentHp = 0 Auto
int Property currentContext  =  0 Auto 

float Property MinStateTime = 1.0 Auto

float StateChangeTimer = -1.0 

int PendingState = -1






;=======================================
;============ SOUNDS 

Sound Property BreathCalm    Auto
int CalmInst = -1 
Sound Property BreathRecover    Auto
int RecoverInst = -1 
Sound Property BreathFocus   Auto
int FocsusInst = -1 
Sound Property BreathStrain  Auto
int StrainInst = -1 
Sound Property BreathAnxious    Auto
int AnxiInst = -1 
Sound Property BreathAnticipation    Auto
int AnticInst = -1 
Sound Property BreathUncomfortable    Auto
int UncomInst = -1 
Sound Property BreathStressed    Auto
int StressInst = -1 
Sound Property BreathCritical    Auto
int CritInst = -1 



Function OnStateChanged( int Context, int HP)

	int newstate = ResolveState( Context,  HP ) 

	if newstate ==  CurrentState 
		StopAllBut(CurrentState )
		return 
	EndIf  

	if !IsUrgentState(NewState)
		
		if ( StateChangeTimer <  0 )
			PendingState = NewState
			StateChangeTimer = Utility.GetCurrentRealTime()
			RegisterForSingleUpdate(MinStateTime)
			return
		Endif 


		 float now = Utility.GetCurrentRealTime()

   		if (now - StateChangeTimer ) < MinStateTime
        		
			PendingState = NewState
           		RegisterForSingleUpdate(MinStateTime - (now - StateChangeTimer ))
        		return

    		endif
	endif


	;Logger.Notify("Breathing -> " + StateToString(NewState) + "CTX = " + Context + " ___  " + HP  )
	
	
	
	
	ApplyBreathing(newstate ) 


EndFunction


Event OnUpdate() 
	If (PendingState >= 0 )
		OnStateChanged(Controller.getContext(),  Controller.getHealth() ) 
	Endif

EndEvent 






; ==== IN context and HP out Heartbeat State
int Function ResolveState ( int Context, int HP) 
	
	return 0

EndFunction

Function ApplyBreathing(int NewState)
	

	CurrentState = NewState
    	PendingState = -1

    	StateChangeTimer = -1.0

    	

    	StopAll()

    	if (NewState== CALM  && BreathCalm)
		
		CalmInst = BreathCalm.Play(Game.GetPlayer())

    	elseif (NewState==  RECOVERING  && BreathRecover)
        	RecoverInst = BreathRecover.Play(Game.GetPlayer())

    	elseif (NewState== FOCUS  && BreathFocus )
        	FocsusInst = BreathFocus.Play(Game.GetPlayer())

    	elseif (NewState== STRAIN && BreathStrain)
        	StrainInst = BreathStrain.Play(Game.GetPlayer())

    	elseif (NewState== ANXIOUS && BreathAnxious)
        	AnxiInst = BreathAnxious.Play(Game.GetPlayer())

    	elseif (NewState== ANTICIPATION && BreathAnticipation)
        	AnticInst = BreathAnticipation.Play(Game.GetPlayer())

    	elseif (NewState== UNCOMFORTABLE && BreathUncomfortable)
        	UncomInst = BreathUncomfortable.Play(Game.GetPlayer())

    	elseif (NewState== STRESSED && BreathStressed)
        	StressInst = BreathStressed.Play(Game.GetPlayer())

    	elseif (NewState== CRIT  && BreathCritical)
        	CritInst = BreathCritical.Play(Game.GetPlayer())

    endif

EndFunction


Function StopCurrent()

	if (currentInstance != 0 )
		Sound.StopInstance(currentInstance ) 
		currentInstance = 0 

	EndIF 

EndFunction

Function StopAll() 
	if (CalmInst >0 )
		Sound.StopInstance(CalmInst )
		CalmInst =-1
	endif
	if (RecoverInst >0 )
		Sound.StopInstance(RecoverInst )
		RecoverInst =-1
	endif
	if (FocsusInst >0 )
		Sound.StopInstance(FocsusInst )
		FocsusInst =-1
	endif
	if (StrainInst >0 )
		Sound.StopInstance(StrainInst )
		StrainInst =-1
	endif
	if (AnxiInst >0 )
		Sound.StopInstance(AnxiInst )
		AnxiInst =-1
	endif
	if (AnticInst >0 )
		Sound.StopInstance(AnticInst )
		AnticInst =-1
	endif
	if (UncomInst >0 )
		Sound.StopInstance(UncomInst )
		UncomInst =-1
	endif
	if (StressInst >0 )
		Sound.StopInstance(StressInst )
		StressInst =-1
	endif
	if (CritInst >0 )
		Sound.StopInstance(CritInst )
		CritInst =-1
	endif

endfunction

Function CheckState (int CurrentState ) 

	
	if (CurrentState == CALM  ) 
		if CalmInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
			
	elseif ( CurrentState == RECOVERING  )
		if RecoverInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == FOCUS  )
		if FocsusInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == STRAIN  )
		if StrainInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == ANXIOUS )
		if AnxiInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == ANTICIPATION  )
		if AnticInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == UNCOMFORTABLE )
		if UncomInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == STRESSED  )
		if StressInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	elseif ( CurrentState == CRIT  )
			if CritInst <=  0
			ApplyBreathing (CurrentState) 

		endif 
	else 
		StopAllBut(CurrentState ) 
	EndIf

endfunction

Function StopAllBut( int NewState) 
	if (NewState!=  CALM  && CalmInst >0   )
		Sound.StopInstance(CalmInst )
		CalmInst =-1
	endif
	if (NewState!=  RECOVERING  && RecoverInst >0 )
		Sound.StopInstance(RecoverInst )
		RecoverInst =-1
	endif
	if (NewState!=  FOCUS  && FocsusInst >0 )
		Sound.StopInstance(FocsusInst )
		FocsusInst =-1
	endif
	if (NewState!=  STRAIN  && StrainInst >0)
		Sound.StopInstance(StrainInst )
		StrainInst =-1
	endif
	if (NewState!=  ANXIOUS && AnxiInst >0 )
		Sound.StopInstance(AnxiInst )
		AnxiInst =-1
	endif
	if (NewState!=  ANTICIPATION  && AnticInst >0 )
		Sound.StopInstance(AnticInst )
		AnxiInst =-1
	endif
	if (NewState!=  UNCOMFORTABLE && UncomInst >0 )
		Sound.StopInstance(UncomInst )
		UncomInst =-1
	endif
	if ( NewState!=  STRESSED  && StressInst >0 )
		Sound.StopInstance(StressInst )
		StressInst =-1
	endif
	if (NewState!=  CRIT  && CritInst >0  )
		Sound.StopInstance(CritInst )
		CritInst =-1
	endif

endfunction




;==================================================
;====SUPPORT AND INIT 
;==================================================

;====== Init State Controller 
Function RegisterStateController(ThesisStateController sc, float UpdateTime = 0.5 )
    	Controller = sc
    	UpdateInterval =  UpdateTime

	;RegisterForSingleUpdate(UpdateInterval )
EndFunction

bool Function IsUrgentState( int NewState)

    return (NewState== CRIT || NewState== STRESSED)

EndFunction

String Function StatetoString ( int cState) 
	
	 if (cState== CALM  )
		return "Calming"
    	elseif (cState==  RECOVERING )
        	return "Recovering"
    	elseif (cState== FOCUS  )
        	return "Focused "
    	elseif (cState== STRAIN )
        	return "Focus Strain "
    	elseif (cState== ANXIOUS )
        	return " Anxious "
    	elseif (cState== ANTICIPATION )
        	return "Anticipating "
    	elseif (cState== UNCOMFORTABLE)
        	return " uncomfortable "
    	elseif (cState== STRESSED )
        	return " Very Stressed "
    	elseif (cState== CRIT  )
        	return "Critical State "
    	endif
	
	return "UNKOWN"


Endfunction



