Scriptname ccBGSSSE001_ApplySpellOnHit extends ReferenceAlias  
{ Script to work around applying a spell on hit to the player by an actor that can't cast spells. }

Actor property UniqueActor auto
{ The Actor reference I should listen for hits from. }

Actor property PlayerRef auto

Spell property spellToCast auto
{ The spell the actor should cast at the player on hit. }

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
	if akAggressor == UniqueActor
		spellToCast.Cast(UniqueActor, PlayerRef)
	endif
endEvent