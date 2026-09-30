Scriptname Thesis_HeartbeatWarrior extends Thesis_Heartbeat




; ==== IN context and HP out Heartbeat State
int Function ResolveState ( int Context, int HP) 
		
	if 		(Context==NEUTRAL && HP == HEALTHY )
		Return HBNONE	
	elseif	(Context==NEUTRAL && HP == WOUNDED )
		Return HBNONE
	elseif	(Context==NEUTRAL && HP == CRITICAL )
		Return S_QUIET

	; SNEAKING 

	elseif	(Context==SNEAK && HP == HEALTHY )
		Return S_QUIET
	elseif	(Context==SNEAK && HP == WOUNDED )
		Return  S_QUIET
	elseif	(Context==SNEAK && HP == CRITICAL )
		Return Medium

	; SNEAK DETECTED 
	elseif	(Context==SNEAKDET && HP == HEALTHY )
		Return MEDIUM 
	elseif	(Context==SNEAKDET && HP == WOUNDED )
		Return MEDIUM 
	elseif	(Context==SNEAKDET && HP == CRITICAL )
		Return S_Loud

	; DETECTED NOT SNEAKING 
	elseif	(Context==DETECTED && HP == HEALTHY )
		Return MEDIUM 
	elseif	(Context==DETECTED && HP == WOUNDED )
		Return F_QUIET
	elseif	(Context==DETECTED && HP == CRITICAL )
		Return F_QUIET

	; COMBAT 
	elseif	(Context==COMBAT && HP == HEALTHY )
		Return  Medium
	elseif	(Context==COMBAT && HP == WOUNDED )
		Return F_Quiet
	elseif	(Context==COMBAT && HP == CRITICAL )
		Return F_Loud

	
	EndIF 
	
EndFunction


