Scriptname Thesis_Heartbeat extends ReferenceAlias  


;========================================
;======Heartbeats ENUM 

int Property HBNONE = 0 AUTO
int Property S_QUIET= 1 AUTO
int Property S_LOUD= 2 AUTO
int Property MEDIUM= 3 AUTO
int Property F_QUIET= 4 AUTO
int Property F_LOUD= 5 AUTO

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










int Property   currentState = 0  Auto
int Property currentHp = 0 Auto
int Property currentContext  =  0 Auto 

;=======================================
;============ SOUNDS 

Sound Property HeartbeatSlowQuiet    Auto
int SoundInstanceSQ =-1

Sound Property HeartbeatSlowLoud    Auto
int SoundInstanceSL =-1


Sound Property HeartbeatMedium    Auto
int SoundInstanceM =-1

Sound Property HeartbeatFastQuiet    Auto
int SoundInstanceFQ =-1

Sound Property HeartbeatFastLoud    Auto
int SoundInstanceFL =-1


Function OnStateChanged( int Context, int HP)

	int newstate = ResolveState( Context,  HP ) 

	if newstate ==  CurrentState 
		return 
	else 

		;Logger.Notify("HB State  = "+ HbtoString(newstate )  + "CTX = "+context  +"HP = " + HP  ) 
		

		ApplyHeartBeat(NewState, currentState) 
		
		currentState = newState 
	endif 

EndFunction



; ==== IN context and HP out Heartbeat State
int Function ResolveState ( int Context, int HP) 
	
	return 0

EndFunction





Function ApplyHeartBeat(int NewState, int oldState)

    	StopButCurrent(NewState)

    	if (NewState== HBNONE )
		StopAll()
		return
    	elseif (NewState==  S_QUIET && SoundInstanceSQ  <= 0 )
        	SoundInstanceSQ = HeartbeatSlowQuiet.Play(Game.GetPlayer())

    	elseif (NewState== S_LOUD && SoundInstanceSL  <= 0)
        	SoundInstanceSL = HeartbeatSlowLoud.Play(Game.GetPlayer())

    	elseif (NewState== MEDIUM && SoundInstanceM  <= 0)
        	SoundInstanceM = HeartbeatMedium.Play(Game.GetPlayer())

    	elseif (NewState== F_QUIET && SoundInstanceFQ  <= 0)
        	SoundInstanceFQ = HeartbeatFastQuiet.Play(Game.GetPlayer())

    	elseif (NewState== F_LOUD && SoundInstanceFL  <= 0)
        	SoundInstanceFL = HeartbeatFastLoud.Play(Game.GetPlayer())
    endif

EndFunction


Function StopAll() 
	if (SoundInstanceSQ > 0 )
		Sound.StopInstance(SoundInstanceSQ )
		SoundInstanceSQ =-1
	endif
	if (SoundInstanceSL > 0 )
		Sound.StopInstance(SoundInstanceSL )
		SoundInstanceSL =-1
	endif
	if (SoundInstanceM > 0 )
		Sound.StopInstance(SoundInstanceM )
		SoundInstanceM =-1
	endif
	if (SoundInstanceFL > 0 )
		Sound.StopInstance(SoundInstanceFL )
		SoundInstanceFL =-1
	endif
	if (SoundInstanceFQ > 0 )
		Sound.StopInstance(SoundInstanceFQ )
		SoundInstanceFQ =-1
	endif

endfunction


Function StopButCurrent( int NewState)

    	if (NewState !=  S_QUIET && SoundInstanceSQ  >0 )
			Sound.StopInstance(SoundInstanceSQ) 
			SoundInstanceSQ = -1
	endif 

	if (NewState !=  S_LOUD && SoundInstanceSL  >0 )
			Sound.StopInstance(SoundInstanceSL  ) 
			SoundInstanceSL  = -1
	endif 

	if (NewState !=  MEDIUM && SoundInstanceM  >0 )
			Sound.StopInstance(SoundInstanceM  ) 
			SoundInstanceM  = -1
	endif

	if (NewState !=  F_QUIET && SoundInstanceFQ  >0 )
			Sound.StopInstance(SoundInstanceFQ) 
			SoundInstanceFQ = -1
	endif 

	if (NewState !=  F_LOUD && SoundInstanceFL  >0 )
			Sound.StopInstance(SoundInstanceFL  ) 
			SoundInstanceFL  = -1
	endif  

EndFunction

;==================================================
;====SUPPORT AND INIT 
;==================================================

;====== Init State Controller 
Function RegisterStateController(ThesisStateController sc, float UpdateTime = 0.5 )
    	Controller = sc
    	UpdateInterval =  UpdateTime

	;RegisterForSingleUpdate(UpdateInterval )
EndFunction



String Function HBtoString ( int hbState) 
	
	 if (hbState== HBNONE )
		return "Neutral"
    	elseif (hbState==  S_QUIET)
        	return "SlowQuiet"
    	elseif (hbState== S_LOUD)
        	return "SlowLoud"
    	elseif (hbState== MEDIUM)
        	return "MEDIUM "
    	elseif (hbState== F_QUIET)
        	return "Fast quiet"
    	elseif (hbState== F_LOUD)
        	return "Fast Loud"
    endif
	
	return "UNKOWN"


Endfunction


