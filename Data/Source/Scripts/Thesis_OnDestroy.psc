Scriptname Thesis_OnDestroy extends ObjectReference  



ThesisLoggerScript Property Logger  Auto 
ThesisStateController Property Controller Auto
ThesisCombatStateControl  Property PlayerCombatModule Auto  




Float  property triggerDuration = 2.0 Auto
bool isRogue  =  false 
Actor playerActor  
float timer  = -1.0

Event OnCellLoad () 
	isRogue = (Controller.GetArchetype()==  Controller.ARCH_ROGUE)
	

	if isRogue 
		playerActor =  Game.GetPlayer()
	endif 
EndEvent 


Event OnUpdate() 
	 float now = Utility.GetCurrentRealTime()

   		if ( now - timer  ) < triggerDuration 

           		RegisterForSingleUpdate(triggerDuration - (now - timer ))
        		return
		else 
			PlayerCombatModule.RemoveEnemyInCombat()
			timer = -1.0
    		endif


EndEvent



Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

	
	if  isRogue 
		Logger.Notify(" I'm HIT ! " + isRogue  ) 
		if (	timer < 0 ) 
			PlayerCombatModule.AddEnemyInCombat()
		endif 
		timer  = Utility.GetCurrentRealTime()
		
		RegisterForSingleUpdate(triggerDuration)
		

	Endif 
	
EndEvent 
