Scriptname PetFramework_SummonPetScript extends activemagiceffect  

ReferenceAlias Property PetRefAlias  Auto
Activator property SummonFX Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
{Move the pet to the player.}

	PetRefAlias.GetReference().MoveTo(Game.GetPlayer())	
	PetRefAlias.GetReference().PlaceAtMe(SummonFX)
	
EndEvent
