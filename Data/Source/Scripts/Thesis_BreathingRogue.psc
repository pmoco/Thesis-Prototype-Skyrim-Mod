Scriptname Thesis_BreathingRogue extends Thesis_Breathing  


; ==== IN context and HP out Breathing State
int Function ResolveState ( int Context, int HP) 
		
	if 		(Context==NEUTRAL && HP == HEALTHY )
		Return CALM  	
	elseif	(Context==NEUTRAL && HP == WOUNDED )
		Return CALM  
	elseif	(Context==NEUTRAL && HP == CRITICAL )
		Return RECOVERING 

	; SNEAKING 

	elseif	(Context==SNEAK && HP == HEALTHY )
		Return FOCUS
	elseif	(Context==SNEAK && HP == WOUNDED )
		Return FOCUS
	elseif	(Context==SNEAK && HP == CRITICAL )
		Return STRAIN

	; SNEAK UNDETECTED 
	elseif	(Context==SNEAKDET && HP == HEALTHY )
		Return ANXIOUS
	elseif	(Context==SNEAKDET && HP == WOUNDED )
		Return ANXIOUS
	elseif	(Context==SNEAKDET && HP == CRITICAL )
		Return ANTICIPATION 

	; DETECTED NOT SNEAKING 
	elseif	(Context==DETECTED && HP == HEALTHY )
		Return UNCOMFORTABLE
	elseif	(Context==DETECTED && HP == WOUNDED )
		Return UNCOMFORTABLE
	elseif	(Context==DETECTED && HP == CRITICAL )
		Return CRIT  

	; COMBAT 
	elseif	(Context==COMBAT && HP == HEALTHY )
		Return STRESSED
	elseif	(Context==COMBAT && HP == WOUNDED )
		Return STRESSED
	elseif	(Context==COMBAT && HP == CRITICAL )
		Return CRIT  

	
	EndIF 
	
EndFunction


bool Function IsUrgentState( int NewState)

    return (NewState== CRIT || NewState==STRESSED || NewState== ANXIOUS || NewState== UNCOMFORTABLE )

EndFunction
