;/ Decompiled by Champollion V1.0.1
Source   : DestroyFurnitureScript.psc
Modified : 2019-08-28 10:55:18
Compiled : 2019-08-28 10:55:19
User     : John Jarvis
Computer : JOHNJARVIS-PC
/;
scriptName DestroyFurnitureScript extends ObjectReference

;-- Properties --------------------------------------
globalvariable property ResetObjectDamageTimer auto
activator property BrokenObject auto
miscobject property GemGarnet auto
globalvariable property ObjectDamageWarnGuards auto
globalvariable property DSObjectMaxHealth auto

;-- Variables ---------------------------------------

bool hitByPlayer = false
bool hasBeenInit = false
float healthInit = 100.0
float damageInit = 0.0

;-- Functions ---------------------------------------

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	;Debug.Trace("OnHit - " + self + " from: " + akAggressor + " source: " + akSource)

	if hasBeenInit == false
		healthInit = DSObjectMaxHealth.GetValue()
		damageInit = 100.000 - healthInit
		self.DamageObject(damageInit)
		hasBeenInit = true
	endIf

	;if     akProjectile.GetFormID() == 81396 ;if the projectile is from weak unrelenting force 0x13DF4~Skyrim.esm

	;elseif akProjectile.GetFormID() == 81919 ;if the projectile is from middle unrelenting force 0x13FFF~Skyrim.esm

	;elseif akProjectile.GetFormID() == 81920 ;if the projectile is from strong unrelenting force 0x14000~Skyrim.esm

	;endif

	if akAggressor == Game.getPlayer()
		;Debug.Trace("Hit By Player")
		hitByPlayer = true
	else
		;Debug.Trace("Not Hit By Player")
		hitByPlayer = false
	endif
endEvent

bool enabled = false

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	;Debug.Trace("OnMagicEffectApply - " + self + " Caster: " + akCaster + " MagicEffect: " + akEffect)

	if enabled == true

		if hasBeenInit == false
			healthInit = DSObjectMaxHealth.GetValue()
			damageInit = 100.000 - healthInit
			self.DamageObject(damageInit)
			hasBeenInit = true
		endIf

		Float damage = 0.00
		if akEffect.IsEffectFlagSet(1) == true && akEffect.IsEffectFlagSet(4) == true
			Float magnitude = akEffect.GetEquipAbility().GetEffectMagnitudes()[0]
			damage = damage + magnitude
		endif
		if akCaster == Game.getPlayer()
			hitByPlayer = true
			self.DamageObject(damage)
		else
			hitByPlayer = false
			self.DamageObject(damage)
		endif

	endif
endEvent
; Skipped compiler generated GotoState

Event OnDestructionStageChanged(Int aiOldStage, Int aiCurrentStage)

	if ObjectDamageWarnGuards.GetValue() == 1.0 as Float
		if hitByPlayer == true as bool
			;Debug.Trace("Crime Committed")
			ObjectReference StealTrigger = self.PlaceAtMe(GemGarnet as form, 1, false, false)
			if self.GetActorOwner()
				StealTrigger.SetActorOwner(self.GetActorOwner())
			elseif self.GetFactionOwner()
				StealTrigger.SetFactionOwner(self.GetFactionOwner())
			endif
			StealTrigger.SendStealAlarm(game.GetPlayer())
			StealTrigger.Delete()
			;self.SendStealAlarm(game.GetPlayer())
		endif
	endIf
	self.ClearDestruction()
	self.SetDestroyed(false)
	self.Disable(false)
	ObjectReference NewObject = self.PlaceAtMe(BrokenObject as form, 1, false, false)
	NewObject.DamageObject(100.000)
	utility.Wait(0.0100000)
	;RegisterForSingleUpdate(0.1)
	if NewObject.GetCurrentDestructionStage() < 0
		NewObject.DamageObject(100.000)
	endIf
	utility.WaitGameTime(ResetObjectDamageTimer.GetValue())
	;RegisterForSingleUpdateGameTime(ResetObjectDamageTimer.GetValue())
	NewObject.Delete()
	self.Enable(false)
endEvent

; Skipped compiler generated GetState
