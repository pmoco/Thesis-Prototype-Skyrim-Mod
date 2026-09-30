scriptname Survival_HungerEatingDetection extends ReferenceAlias

import Survival_GlobalFunctions

Actor property PlayerRef auto
FormList property Survival_FoodPoisoningImmuneRaces auto
FormList property Survival_FoodRawMeat auto
Keyword property Survival_DiseaseFoodPoisoningKeyword auto
MagicEffect property DA11AbFortifyHealth auto
MagicEffect property WerewolfFeedRestoreHealth auto
Message property Survival_FoodPoisoningMsg auto
Spell property Survival_DiseaseFoodPoisoning auto

Race property playerRace auto hidden

Event OnInit()
	GetPlayerRace()
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject as Potion
		CheckFoodPoisoning(akBaseObject)
	endif
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	if akEffect == WerewolfFeedRestoreHealth 
		SurvivalLogMessage("{{HUNGER}} Decreasing Hunger due to werewolf feeding.")
		EatingAlternative()
	elseif akEffect == DA11AbFortifyHealth
		SurvivalLogMessage("{{HUNGER}} Decreasing Hunger due to cannibalism.")
		EatingAlternative()
	endif
EndEvent

function EatingAlternative()
	; Player fed as a Werewolf, or used the Ring of Namira.
	(self.GetOwningQuest() as Survival_NeedHunger).DecreaseHungerMedium()
endFunction

function CheckFoodPoisoning(Form akBaseObject)
	; Check for Raw Meat
	if Survival_FoodRawMeat.HasForm(akBaseObject)
		if !playerRace
			GetPlayerRace()
		endif
		float diseaseResistMult = PlayerRef.GetActorValue("DiseaseResist") / 100.0
		if Survival_FoodPoisoningImmuneRaces.HasForm(playerRace) || diseaseResistMult >= 1.0 || PlayerRef.HasEffectKeyword(Survival_DiseaseFoodPoisoningKeyword)
			SurvivalLogMessage("{{HUNGER}} Player cannot contract Food Poisoning.")
			return
		else
			float baseChance = 50.0
			float chance = baseChance * (1.0 - diseaseResistMult)
			float result = Utility.RandomFloat(0.0, 100.0)
			if result <= chance
				Survival_FoodPoisoningMsg.Show()
				PlayerRef.AddSpell(Survival_DiseaseFoodPoisoning, false)
			endif
		endif
	endif
endFunction

function GetPlayerRace()
	playerRace = PlayerRef.GetRace()
endFunction
