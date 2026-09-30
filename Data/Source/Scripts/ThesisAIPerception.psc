Scriptname ThesisAIPerception extends Actor  

;=======================================
; Global Controllers 

ThesisLoggerScript Property Logger  Auto 
ThesisStateController Property Controller Auto
ThesisCombatStateControl  Property PlayerCombatModule Auto  


ThWhistling Property Whistle Auto

;========================
;======VARS 
;=========================


int combatstate =-1
int LogToPlayer = 0 

Actor playerActor  

float UpdateInterval  =0.5



;=========DEPRECATED 
bool bAlert = False 
bool bAlarmed = False 
bool bcombat = False 
bool FoundPlayer = false 
bool bLOS = false




Event OnLoad() 		; INITIALIZATION 

	RegisterForSingleUpdate(UpdateInterval  )
	if (Whistle)
		Whistle.StartSound()
	endif 
	
	playerActor =  Game.GetPlayer()
EndEvent 



; ========== FIND PLAYER LOOP =============
Event OnUpdate() 

	int ct =  self.GetCombatState() 
	if (  ct!= combatstate)
		combatstate = ct 		
		if ( ct == 0) 
			if (LogToPlayer ==1 ) 
				PlayerCombatModule.RemoveEnemyInCombat()
				
			endif
			if (Whistle)
				Whistle.StartSound()
			endif 
			LogToPlayer = 0
			;Logger.Notify(" Ìdle " + LogToPlayer ) 
		elseif ( ct == 1)
			if (LogToPlayer ==0  ) 
				PlayerCombatModule.AddEnemyInCombat()

				
				
			endIf
			if (Whistle)
				Whistle.StopSound()
			endif 
			LogToPlayer = 1	
			
			;Logger.Notify(" Combat - "  + LogToPlayer) 

			
		elseif( ct ==2) 
			;Logger.Notify(" Searching -  "  + LogToPlayer) 
			if (LogToPlayer ==1 ) 
				PlayerCombatModule.RemoveEnemyInCombat()
			endif
			if (Whistle)
				Whistle.StopSound()
			endif 
			LogToPlayer = 0
		else
			;Logger.Notify(" Unknown State  " + ct)
 		Endif
	Endif

	RegisterForSingleUpdate(UpdateInterval  )

EndEvent 

; ===== 
;==== when dead check if has removed from the player's EnemyStack 
Event OnDeath(Actor akKiller)
	;Logger.Notify("We have left combat with the player! I'm Dead" + LogToPlayer)
	If( LogToPlayer > 0 ) 
		PlayerCombatModule.RemoveEnemyInCombat()

	endIf 
	if (Whistle)
		Whistle.StopSound()
	endif 
endEvent 





bool Function DeprecatedCheckState() 
	bool bChanged = false
	if   (FoundPlayer !=  playerActor.isDetectedBy(self))
		FoundPlayer = !FoundPlayer 
		bChanged =true
	Endif
	if ( bLOS != self.HasLOS ( playerActor ) ) 
		bLOS =!bLOS 
		bChanged =true
	EndIf
	
	if ( bCombat  != self.isInCombat() ) 
		bCombat  =!bCombat  
		bChanged =true
	EndIf

	if (bChanged) 
		;Logger.Notify("New State>  Detected "+  FoundPlayer + " _ LOS   "   + bLOS + " _ Combat " + bcombat)
	EndIF 
	
	return bchanged 
EndFunction


;Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
; 	 if (akTarget == Game.GetPlayer())
;    		if (aeCombatState == 0)
;     			Logger.Notify("We have left combat with the player!")
;   		elseif (aeCombatState == 1)
;      			;Logger.Notify("We have entered combat with the player!")
;    		elseif (aeCombatState == 2)
;      			;Logger.Notify("We are searching for the player...")
;		else 
;			;Logger.Notify("Not recognized State "+ aeCombatState)
;    		endIf
;	else 
;		;Logger.Notify("Unknown Target " + akTarget)
;  	endIf	
;endEvent
