scriptname Survival_FreezingWaterCheck extends ActiveMagicEffect

import Survival_GlobalFunctions

Survival_ConditionsScript property conditions auto
Survival_NeedCold property cold auto
Survival_PlayerLocationInfo property playerinfo auto

Actor property PlayerRef auto
GlobalVariable property Survival_LastWaterFreezingMsgTime auto
MagicEffect property FireCloakFFSelf auto
MagicEffect property MGRJZargoFireCloakFFSelf auto
MagicEffect property PowerDarkElfFireCloakFFSelf auto
Message property Survival_WaterFreezingMessage auto
Spell property Survival_FreezingWaterDamage auto
Worldspace property DLC1HunterHQWorld auto

;/
 / Optional FX
 /;

Sound property FXFreezingWaterSoundFX auto
{ Optional. A sound effect to play when entering freezing water. }

Sound property FXFreezingWaterSoundFXFemale auto
{ Optional. A sound effect to play when entering freezing water for female characters. }

ImagespaceModifier property FXFreezingWaterISM auto
{ Optional. A visual effect to play when entering freezing water. }

float property FXFreezingWaterRumbleSmallMotorStrength = -1.0 auto
{ Optional. The strength of the small force feedback motor when entering freezing water. }

float property FXFreezingWaterRumbleBigMotorStrength = -1.0 auto
{ Optional. The strength of the big force feedback motor when entering freezing water. }

float property FXFreezingWaterRumbleDuration = -1.0 auto
{ Optional. The duration of the force feedback when entering freezing water. }

int areaTypeChillyInterior = -1
int areaTypeFreezing = 3
int genderFemale = 1


Event OnEffectStart(Actor akTarget, Actor akCaster)
	CheckWater()
	RegisterForSingleUpdate(3)
EndEvent

bool wantToFinish = false
Event OnUpdate()
	if !wantToFinish
		CheckWater()
		RegisterForSingleUpdate(3)
	endif
EndEvent

bool checkingWater = false
function CheckWater()
	checkingWater = true
	int currentAreaType = playerinfo.GetCurrentAreaType()
	Worldspace currentWorldspace = PlayerRef.GetWorldspace()
	if (currentAreaType == areaTypeFreezing || currentAreaType == areaTypeChillyInterior || currentWorldspace == DLC1HunterHQWorld) && !PlayerHasFlameCloak()
		; Affect the Player
		conditions.isSwimmingInFreezingWater = true
		PlayerRef.AddSpell(Survival_FreezingWaterDamage, false)

		; Increase Coldness to at least Cold
		cold.IncreaseCold(cold.NeedMaxValue.GetValue(), cold.needStage3Value)

		; Play Effects and Notifications
		ApplySFX(FXFreezingWaterSoundFX, FXFreezingWaterSoundFXFemale)
		ApplyISM(FXFreezingWaterISM)
		ApplyRumble(FXFreezingWaterRumbleSmallMotorStrength, FXFreezingWaterRumbleBigMotorStrength, FXFreezingWaterRumbleDuration)
		float currentTime = Utility.GetCurrentRealTime()
		if currentTime - Survival_LastWaterFreezingMsgTime.GetValue() >= 10.0
			Survival_WaterFreezingMessage.Show()
			Survival_LastWaterFreezingMsgTime.SetValue(currentTime)
		endif
	else
		PlayerRef.RemoveSpell(Survival_FreezingWaterDamage)
		conditions.isSwimmingInFreezingWater = false
	endif
	checkingWater = false
endFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	wantToFinish = true
	
	while checkingWater
		Utility.Wait(0.4)
	endWhile

	PlayerRef.RemoveSpell(Survival_FreezingWaterDamage)
	conditions.isSwimmingInFreezingWater = false
EndEvent

function ApplySFX(Sound sfx, Sound sfxFemale = None)
    if sfxFemale && PlayerRef.GetActorBase().GetSex() == genderFemale
    	int id = sfxFemale.Play(PlayerRef)
    elseif sfx
    	int id = sfx.Play(PlayerRef)
    endif
endFunction

function ApplyISM(ImagespaceModifier ism)
	if ism
		ism.Apply()
	endif
endFunction

function ApplyRumble(float rumbleSmall = -1.0, float rumbleBig = -1.0, float rumbleDuration = -1.0)
	if rumbleSmall != -1.0 && rumbleBig != -1.0 && rumbleDuration != -1.0
		Game.ShakeController(rumbleSmall, rumbleBig, rumbleDuration)
	endif
endFunction

bool function PlayerHasFlameCloak()
	if PlayerRef.HasMagicEffect(FireCloakFFSelf) || \
	   PlayerRef.HasMagicEffect(MGRJZargoFireCloakFFSelf) || \
	   PlayerRef.HasMagicEffect(PowerDarkElfFireCloakFFSelf)
		return true
	else
		return false
	endif
endFunction