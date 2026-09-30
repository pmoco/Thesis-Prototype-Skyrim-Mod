Scriptname RPDefault_OnHitAlias extends ReferenceAlias Hidden

Bool Property bPlayerOnly = true auto
{ Set to true to only trigger if the player hits }

Bool Property bOnlyTriggerOnce = true auto
{ Set to false if the handling code should be run every time }

Weapon[] Property Source_SpecificWeapons auto
{ (Optional) Trigger only if one of these weapons was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Spell[] Property Source_SpecificSpells auto
{ (Optional) Trigger only if one of these spells was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Explosion[] Property Source_SpecificExplosions auto
{ (Optional) Trigger only if one of these explosions was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Ingredient[] Property Source_SpecificIngredients auto
{ (Optional) Trigger only if one of these ingredients was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Potion[] Property Source_SpecificPotions auto
{ (Optional) Trigger only if one of these potions was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Enchantment[] Property Source_SpecificEnchantment auto
{ (Optional) Trigger only if one of these enchantments was used. Note if multiple Source_ properties are set, any of them will be eligible. }

Projectile Property SpecificProjectile auto
{ (Optional) If set, only hits with this Projectile type will trigger this }

Bool Property bOnlyCountPowerAttacks = false auto
{ If true, only power attacks will trigger this }

Bool Property bOnlyCountSneakAttacks = false auto
{ If true, only sneak attacks will trigger this }

Bool Property bOnlyCountBashAttacks = false auto
{ If true, only bash attacks will trigger this }

Bool Property bIgnoreBlockedHits = false auto
{ If true, blocked hits won't trigger this }


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Debug.Trace("OnHit(akAggressor " + akAggressor + ", akSource " + akSource + ", akProjectile " + akProjectile + ", abPowerAttack " + abPowerAttack + ", abSneakAttack " + abSneakAttack + ", abBashAttack " + abBashAttack + ", abHitBlocked " + abHitBlocked + ")")
	
	GoToState("Completed")
				
	if(bPlayerOnly && akAggressor != Game.GetPlayer())
		GoToState("")
		return
	endif
	
	Bool bMatchingSourceFound = false
	Bool bMatchingSourceNeeded = (Source_SpecificEnchantment || Source_SpecificExplosions || Source_SpecificIngredients || Source_SpecificPotions || Source_SpecificSpells || Source_SpecificWeapons)
	
	if(akSource == None && bMatchingSourceNeeded)
		GoToState("")
		return
	endif
	
	if(bMatchingSourceNeeded)
		if(Source_SpecificWeapons && Source_SpecificWeapons.Length > 0 && akSource as Weapon)
			if(Source_SpecificWeapons.Find(akSource as Weapon) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if(Source_SpecificSpells && Source_SpecificSpells.Length > 0 && akSource as Spell)
			if(Source_SpecificSpells.Find(akSource as Spell) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if(Source_SpecificExplosions && Source_SpecificExplosions.Length > 0 && akSource as Explosion)
			if(Source_SpecificExplosions.Find(akSource as Explosion) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if(Source_SpecificIngredients && Source_SpecificIngredients.Length > 0 && akSource as Ingredient)
			if(Source_SpecificIngredients.Find(akSource as Ingredient) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if(Source_SpecificPotions && Source_SpecificPotions.Length > 0 && akSource as Potion)
			if(Source_SpecificPotions.Find(akSource as Potion) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if(Source_SpecificEnchantment && Source_SpecificEnchantment.Length > 0 && akSource as Enchantment)
			if(Source_SpecificEnchantment.Find(akSource as Enchantment) < 0)
				GoToState("")
				return
			else
				bMatchingSourceFound = true
			endif
		endif
		
		if( ! bMatchingSourceFound)
			GoToState("")
			return
		endif
	endif
	
	if(SpecificProjectile && akProjectile != SpecificProjectile)
		GoToState("")
		return
	endif
	
	if(bOnlyCountPowerAttacks && ! abPowerAttack)
		GoToState("")
		return
	endif
	
	if(bOnlyCountSneakAttacks && ! abSneakAttack)
		GoToState("")
		return
	endif
	
	if(bOnlyCountBashAttacks && ! abBashAttack)
		GoToState("")
		return
	endif
	
	if(bIgnoreBlockedHits && abHitBlocked)
		GoToState("")
		return
	endif
	
	; All checks passed
	Bool bTriggered = HandleHit(akAggressor, akSource, akProjectile, abPowerAttack, abSneakAttack, abBashAttack, abHitBlocked)
		
	if( ! bTriggered || ! bOnlyTriggerOnce)
		GoToState("")
	endif
EndEvent


State Completed
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; Do nothing
	EndEvent
EndState


Bool Function HandleHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Extend Me
	return true
EndFunction