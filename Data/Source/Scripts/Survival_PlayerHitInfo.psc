scriptname Survival_PlayerHitInfo extends ReferenceAlias

Actor property PlayerRef auto

Spell property Survival_DiseaseGreenspore auto
Spell property Survival_DiseaseBrownRot auto
Spell property Survival_DiseaseGutworm auto

FormList property Survival_BrownRotCarryingRaces auto
FormList property Survival_GreensporeCarryingRaces auto
FormList property Survival_GutwormCarryingRaces auto

bool processing = false
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if akProjectile || !(akAggressor as Actor)
		return
	endif

	while processing
		Utility.Wait(0.1)
	endWhile
	
	processing = true
	OnHitImpl(akAggressor)
	processing = false
EndEvent

function OnHitImpl(ObjectReference akAggressor)
	Race theRace = (akAggressor as Actor).GetLeveledActorBase().GetRace()
	if Survival_BrownRotCarryingRaces.HasForm(theRace)
		PlayerRef.AddSpell(Survival_DiseaseBrownRot, false)
	elseif Survival_GreensporeCarryingRaces.HasForm(theRace)
		PlayerRef.AddSpell(Survival_DiseaseGreenspore, false)
	elseif Survival_GutwormCarryingRaces.HasForm(theRace)
		PlayerRef.AddSpell(Survival_DiseaseGutworm, false)
	endif
endFunction