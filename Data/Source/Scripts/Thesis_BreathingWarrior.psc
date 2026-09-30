Scriptname Thesis_BreathingWarrior extends Thesis_Breathing  




; ==== IN context and HP out Breathing State
int Function ResolveState ( int Context, int HP) 
		
	if 		(Context==NEUTRAL && HP == HEALTHY )
		Return CALM  	
	elseif	(Context==NEUTRAL && HP == WOUNDED )
		Return RECOVERING 
	elseif	(Context==NEUTRAL && HP == CRITICAL )
		Return RECOVERING 

	; SNEAKING 

	elseif	(Context==SNEAK && HP == HEALTHY )
		Return UNCOMFORTABLE
	elseif	(Context==SNEAK && HP == WOUNDED )
		Return UNCOMFORTABLE
	elseif	(Context==SNEAK && HP == CRITICAL )
		Return STRESSED

	; SNEAK DETECTED 
	elseif	(Context==SNEAKDET && HP == HEALTHY )
		Return ANXIOUS
	elseif	(Context==SNEAKDET && HP == WOUNDED )
		Return ANTICIPATION 
	elseif	(Context==SNEAKDET && HP == CRITICAL )
		Return STRESSED
	
		; COMBAT 
	elseif	(Context==COMBAT && HP == HEALTHY )
		Return FOCUS
	elseif	(Context==COMBAT && HP == WOUNDED )
		Return FOCUS
	elseif	(Context==COMBAT && HP == CRITICAL )
		Return CRIT  

	; DETECTED NOT SNEAKING 
	elseif	(Context==DETECTED && HP == HEALTHY )
		Return ANTICIPATION 
	elseif	(Context==DETECTED && HP == WOUNDED )
		Return ANTICIPATION 
	elseif	(Context==DETECTED && HP == CRITICAL )
		Return CRIT  



	
	EndIF 
	
EndFunction


bool Function IsUrgentState( int NewState)

    return (NewState== CRIT || NewState==STRESSED || NewState== ANXIOUS || NewState== FOCUS || NewState == ANTICIPATION)

EndFunction


Sound Property AlternateBreath Auto 


Function AlternateCalm () 

	BreathCalm = AlternateBreath

EndFunction 

