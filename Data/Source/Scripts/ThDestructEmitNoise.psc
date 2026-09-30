Scriptname ThDestructEmitNoise extends ObjectReference  

int   property intensityOnDestruction = 70 Auto
int   property intensityOnHit = 30 Auto

Actor Property NoiseEmitter Auto

 float zOffset = -150.0



Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)

	if NoiseEmitter
		NoiseEmitter.Enable()
    		NoiseEmitter.MoveTo( Self, 0.0,  0.0,  zOffset )
		Utility.wait(0.5)
    		CreateDetectionEvent(NoiseEmitter, intensityOnDestruction )
		NoiseEmitter.Disable()
	endif
EndEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack,  bool abBashAttack, bool abHitBlocked)
	if NoiseEmitter
    		NoiseEmitter.MoveTo( Self, 0.0,  0.0,  zOffset )
   		CreateDetectionEvent(NoiseEmitter, intensityOnHit)
	endif

EndEvent


