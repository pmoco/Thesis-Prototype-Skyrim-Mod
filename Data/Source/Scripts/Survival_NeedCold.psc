scriptname Survival_NeedCold extends Survival_NeedBase

import Survival_GlobalFunctions
import Weather

Message property Survival_HelpColdHigh auto
GlobalVariable property Survival_HelpShown_Cold auto

FormList property Survival_AshWeather auto
FormList property Survival_BlizzardWeather auto
FormList property Survival_ColdWeakRacesMajor auto
FormList property Survival_InteriorAreas auto
GlobalVariable property GameHour auto
GlobalVariable property Survival_AfflictionColdChance auto
GlobalVariable property Survival_LastWarmingUpMsgTime auto
GlobalVariable property Survival_RacialBonusMajor auto
GlobalVariable property TimeScale auto
Survival_HeatCheck property heatcheck auto
ReferenceAlias property PlayerAlias auto
ReferenceAlias property PlayerInfoAlias auto
Quest property Survival_PlayerInfoQuest auto

Spell property Survival_AfflictionFrostbitten auto

Message property Survival_ColdWarmingUpMessage auto
Message property Survival_ColdConditionStage5 auto
Message property Survival_ColdConditionStage4 auto
Message property Survival_ColdConditionStage3 auto
Message property Survival_ColdConditionStage2 auto
Message property Survival_ColdConditionStage1 auto
Message property Survival_ColdConditionStage0 auto
Message property Survival_AfflictionFrostbittenMsg auto

; Cold calculation
GlobalVariable property Survival_ColdLevelMult auto
GlobalVariable property Survival_ColdResistMaxValue auto
GlobalVariable property Survival_ColdTargetGameHoursToNumb auto
GlobalVariable property Survival_ColdLevelInFreezingWater auto

; Baseline Cold Levels, determined by region
int property coldLevelWarmArea 				= 0 	auto hidden
int property coldLevelCoolArea 				= 3 	auto hidden
int property coldLevelFreezingArea 			= 6		auto hidden

; Cold Level night-time modifiers by region
int property coldLevelWarmAreaNightMod 		= 1 	auto hidden
int property coldLevelCoolAreaNightMod		= 2		auto hidden
int property coldLevelFreezingAreaNightMod 	= 4		auto hidden

; Cold Level weather modifiers
int property coldLevelRainMod 				= 3		auto hidden
int property coldLevelSnowMod 				= 6		auto hidden
int property coldLevelBlizzardMod 			= 10	auto hidden

; The minimum Cold Level required to advance to each stage.
; (i.e. Cannot become "Freezing" in Whiterun during the day)
int property coldStage1ColdLevelMin 		= 1 	auto hidden
int property coldStage2ColdLevelMin 		= 4 	auto hidden
int property coldStage3ColdLevelMin 		= 7 	auto hidden
int property coldStage4ColdLevelMin 		= 10 	auto hidden
int property coldStage5ColdLevelMin 		= 13 	auto hidden

bool property isBeastRace = false auto hidden
int property currentColdLevel = 0 auto hidden
int property lastColdLevel = 20 auto hidden

int coldToRestoreInWarmArea = 40
int weatherClassRain = 2
int weatherClassSnow = 3

int areaTypeChillyInterior = -1
int areaTypeInterior = 0
int areaTypeWarm = 1
int areaTypeCool = 2
int areaTypeFreezing = 3

GlobalVariable property Survival_TemperatureLevel auto
int temperatureLevelNeutral = 0
int temperatureLevelNearHeat = 1
int temperatureLevelWarmArea = 2
int temperatureLevelColdArea = 3
int temperatureLevelFreezingArea = 4

float warmthMaxBonusPercent = 0.85

bool wasInOblivion = false
int lastTemperatureLevel = 0

float property cachedTimescale auto hidden
float property cachedColdLevelMult auto hidden
float property cachedColdTargetGameHoursToNumb auto hidden
float property cachedNeedUpdateGameTimeInterval auto hidden
float property cachedColdResistMaxValue auto hidden

function StartNeed()
    oldStage = 99
    parent.StartNeed()
    self.RegisterForSleep()

    PlayerAlias.ForceRefIfEmpty(PlayerRef)
endFunction

function SetNeedStageValues()
	                      		; Warm
    needStage1Value = 50.0  	; Comfortable
    needStage2Value = 120.0 	; Chilly
    needStage3Value = 300.0 	; Cold
    needStage4Value = 500.0 	; Freezing
    needStage5Value = 800.0 	; Numb
endFunction

function StopNeed()
    WaitForUnlock()
	parent.StopNeed()
	PlayerAlias.Clear()
endFunction

function PrecacheValues()
    cachedTimescale = TimeScale.GetValue()
    cachedColdLevelMult = Survival_ColdLevelMult.GetValue()
    cachedColdTargetGameHoursToNumb = Survival_ColdTargetGameHoursToNumb.GetValue()
    cachedNeedUpdateGameTimeInterval = NeedUpdateGameTimeInterval.GetValue()
    cachedColdResistMaxValue = Survival_ColdResistMaxValue.GetValue()
endFunction

function NeedUpdateGameTime()
	SurvivalLogMessage("{{COLD}} Update Start")
	bool wasSleeping = detectedSleepEvent
    if cachedTimescale == 0.0
        PrecacheValues()
    endif

	if conditions.isInPlaneOfOblivion
		SurvivalLogMessage("{{COLD}} In Oblivion, skipping NeedUpdateGameTime.")
		lastTimeInGameHours = Utility.GetCurrentGameTime() * 24 ; currentTimeInGameHours
		wasInOblivion = true
		return
	endif

	currentColdLevel = UpdateColdLevel()
	bool nearHeat = heatcheck.IsPlayerNearHeatAndStanding()
	DisplayColdLevelTransitionMessage(currentColdLevel)

	if nearHeat
		SurvivalLogMessage("{{COLD}} Player is near heat, skipping update.")
		lastTimeInGameHours = Utility.GetCurrentGameTime() * 24 ; currentTimeInGameHours
		wasInOblivion = false
		lastColdLevel = currentColdLevel
		return
	endif
	
	int newMaxStage = GetColdStageMaximum(currentColdLevel)
	float newMaxValue = GetMaxStageValue(newMaxStage)

	; Calculate resistances
	float warmthRating = PlayerRef.GetWarmthRating()

	float totalBonus = ClampFloatTo(warmthRating, 0.0, cachedColdResistMaxValue)
	float bonusReductionPercent = (warmthMaxBonusPercent * totalBonus) / cachedColdResistMaxValue

	SurvivalLogMessage("{{COLD}} Player's current Warmth Rating: " + totalBonus + " (reduction of " + bonusReductionPercent + "%)")

	float newColdValue = IncrementNeedByTick(newMaxValue, bonusReductionPercent)
	ApplyColdStage(newColdValue, lastValue)

	if !wasSleeping && newColdValue >= needStage5Value && !PlayerRef.HasSpell(Survival_AfflictionFrostbitten)
		; Frostbitten
		SurvivalLogMessage("{{COLD}} Player eligible for Frostbitten. Rolling...")
		float result = Utility.RandomFloat()
		SurvivalLogMessage("{{COLD}}     Result: " + result)
		if result <= Survival_AfflictionColdChance.GetValue()
			SurvivalLogMessage("{{COLD}}     Player is now Frostbitten!")
			Survival_AfflictionFrostbittenMsg.Show()
			PlayerRef.AddSpell(Survival_AfflictionFrostbitten, false)
		endif
	endif

    UpdateTemperatureUI(currentColdLevel, lastValue, newColdValue)

    CheckIfMaxCold(newColdValue)

	wasInOblivion = false
	lastValue = newColdValue
	lastColdLevel = currentColdLevel
endFunction

function IncreaseCold(float amount, float customMaxValue = -1.0)
	if conditions.isInPlaneOfOblivion
		SurvivalLogMessage("{{COLD}} In Oblivion, skipping IncreaseCold.")
        return
    endif

	SurvivalLogMessage("{{COLD}} IncreaseCold Start")
	float currentNeedValue = NeedValue.GetValue()
	
	int newMaxStage = GetColdStageMaximum(currentColdLevel)
	float newMaxValue
	float newColdValue
	
	if customMaxValue != -1.0
		newColdValue = IncrementNeed(currentNeedValue, amount, customMaxValue)
	else
		newMaxValue = GetMaxStageValue(newMaxStage)
		newColdValue = IncrementNeed(currentNeedValue, amount, newMaxValue)
	endif
	ApplyColdStage(newColdValue, lastValue)

    CheckIfMaxCold(newColdValue)

	lastValue = newColdValue
endFunction

function DecreaseCold(float amount, float customMinValue = -1.0, bool suppressWarmUpMessage = false)
	if conditions.isInPlaneOfOblivion
		SurvivalLogMessage("{{COLD}} In Oblivion, skipping DecreaseCold.")
        return
    endif

	SurvivalLogMessage("{{COLD}} DecreaseCold Start")
	float currentNeedValue = NeedValue.GetValue()

	bool previouslyIncreasing = wasIncreasing
	if previouslyIncreasing && currentNeedValue > 50.0 && !suppressWarmUpMessage
		float currentTime = Utility.GetCurrentRealTime()
		if currentTime - Survival_LastWarmingUpMsgTime.GetValue() >= 10.0
			Survival_ColdWarmingUpMessage.Show()
			Survival_LastWarmingUpMsgTime.SetValue(currentTime)
		endif
	endif

	float newColdValue = DecrementNeed(currentNeedValue, amount, customMinValue)
	ApplyColdStage(newColdValue, lastValue)

	lastValue = newColdValue
endFunction

float function GetAmountToIncrementBy(int ticks, float rateReductionMultiplier)
	float result = parent.GetAmountToIncrementBy(ticks, rateReductionMultiplier)

    Race playerRace = PlayerRef.GetActorBase().GetRace()
    if Survival_ColdWeakRacesMajor.HasForm(playerRace)
        result *= (1 + Survival_RacialBonusMajor.GetValue())
    endif

    return result
endFunction

function ApplyColdStage(float newColdValue, float oldColdValue)
    bool increasing = newColdValue > oldColdValue
    if wasInOblivion
    	; Force the increasing message variant after exiting Oblivion.
    	increasing = true
    endif

    SurvivalLogMessage("{{COLD}}     Applying Cold stage. New value: " + newColdValue + ", Old value: " + oldColdValue + ", increasing: " + increasing)

    int newStage
    if hasBonus
        newStage = 0
    elseif Between(newColdValue, needStage2Value, NeedMinValue)
        newStage = 1
    elseif Between(newColdValue, needStage3Value, needStage2Value)
        newStage = 2
    elseif Between(newColdValue, needStage4Value, needStage3Value)
        newStage = 3
    elseif Between(newColdValue, needStage5Value, needStage4Value)
        newStage = 4
    elseif Between(newColdValue, NeedMaxValue.GetValue(), needStage5Value, inclusiveUpperBound = true)
        newStage = 5
    endif

    if newStage != oldStage
    	SurvivalLogMessage("{{COLD}}     Applying Stage " + newStage)
        ApplyNeedStagePlayerEffects(increasing, needSpells[newStage], needMessagesWhenIncreasing[newStage], needMessagesWhenDecreasing[newStage])
        ApplyNeedSFX(increasing, needSoundFXs[newStage], needSoundFXsFemale[newStage], needPlaySoundFXsOnImprove[newStage])
        ApplyNeedRumble(increasing, needRumbleSmallMotorStrengths[newStage], needRumbleBigMotorStrengths[newStage], needRumbleDurations[newStage], needPlayRumblesOnImprove[newStage])
    endif

    oldStage = newStage

    if newStage >= 2 && Survival_HelpShown_Cold.GetValueInt() == 0 && !PlayerRef.IsInCombat()
    	Survival_HelpColdHigh.Show()
    	Survival_HelpShown_Cold.SetValueInt(1)
    endif
endFunction

float function IncrementNeedByTick(float ceilingValue, float rateReductionMultiplier = 0.0)
    Utility.Wait(1)
    SurvivalLogMessage("{{COLD}}     IncrementNeedByTick with rateReductionMultiplier = " + rateReductionMultiplier)

    float currentNeedValue = NeedValue.GetValue()
    float newNeedValue
    float currentTimeInGameHours = Utility.GetCurrentGameTime() * 24
    float currentTimeInRealSeconds = Utility.GetCurrentRealTime()

    if firstUpdate
        SurvivalLogMessage("{{COLD}}     Ignoring the first update and storing update time.")
        lastTimeInGameHours = currentTimeInGameHours
        return currentNeedValue + 1
    endif

    if IsTalkingToNPC()
        SurvivalLogMessage("{{COLD}}     In a conversation; pausing need advancement and storing update time.")
        lastTimeInGameHours = currentTimeInGameHours
        return currentNeedValue
    endif

    int ticks = GetTicks(currentTimeInGameHours, lastTimeInGameHours)
    float amountToIncrementBy = GetAmountToIncrementBy(ticks, rateReductionMultiplier)

    ; If the player's Cold is above the cold ceiling for the current cold level,
    ; we must begin pulling them back to the ceiling value so they can warm up in this area.
    ; Otherwise, increase as normal.

    if currentNeedValue > ceilingValue
        if PlayerRef.IsInCombat()
            SurvivalLogMessage("{{COLD}}     In combat, don't warm up ambiently.")
            newNeedValue = currentNeedValue
        else
            ; Decrease down to the ceiling
            float decrementedValue = currentNeedValue - (coldToRestoreInWarmArea * ticks)
            if decrementedValue < ceilingValue
                newNeedValue = DecrementNeed(currentNeedValue, currentNeedValue - ceilingValue)
            else
                newNeedValue = DecrementNeed(currentNeedValue, coldToRestoreInWarmArea * ticks)
            endif
        endif

    elseif currentNeedValue + amountToIncrementBy > ceilingValue
        ; Increase only up to the maximum
        newNeedValue = IncrementNeed(currentNeedValue, ceilingValue - currentNeedValue)
        SurvivalLogMessage("{{COLD}}     Incrementing need by " + (ceilingValue - currentNeedValue) + " (reached cap)")

    else
        ; Increase normally
        newNeedValue = IncrementNeed(currentNeedValue, amountToIncrementBy)
        SurvivalLogMessage("{{COLD}}     Incrementing need by " + amountToIncrementBy)
    endif

    lastTimeInGameHours = currentTimeInGameHours
    SurvivalLogMessage("{{COLD}}     New value is " + newNeedValue)
    return newNeedValue
endFunction

int function GetTemperatureLevelForUI()
    SurvivalLogMessage("{{COLD}} Re-Evaluate UI Temperature")
   
    if conditions.isInPlaneOfOblivion
        return temperatureLevelNeutral
    endif
    
    int newMaxStage = GetColdStageMaximum(currentColdLevel)
    float ceilingValue = GetMaxStageValue(newMaxStage)
    float currentNeedValue = NeedValue.GetValue()

    if currentNeedValue > ceilingValue
        if PlayerRef.IsInCombat()
            ; Cannot warm up ambiently in combat
            return temperatureLevelNeutral
        else
            ; Warming up ambiently
            return temperatureLevelWarmArea
        endif
    elseif currentNeedValue == ceilingValue
        ; Reached cap
        return temperatureLevelNeutral
    else ; currentNeedValue < ceilingValue
        if currentColdLevel == 0
            return temperatureLevelNeutral
        elseif currentColdLevel >= coldStage5ColdLevelMin
            return temperatureLevelFreezingArea
        else
            return temperatureLevelColdArea
        endif
    endif
endFunction

float function GetNeedRatePerTick()
	;/ Cold calculation:
		Cold points per real time second = (ColdLevelMult * currentColdLevel) / Target Real Time Seconds to Numb Value

		Amount to add this tick = cold points per real time second * number of seconds since last update

		ColdLevelMult = default 50.0
		currentColdLevel = Derived from current area, weather, and time (range: 0 to 20, 20 being worst)
		Target real time seconds to numb = Default 300.0 at timescale 20. Derived from game time.
	/;
	SurvivalLogMessage("{{COLD}} CalculateColdIncreasePerTick calculating...")
	float c = cachedColdLevelMult * currentColdLevel
	SurvivalLogMessage("{{COLD}}     coldLevelMult * currentColdLevel = " + c)

	float targetRealTimeSecondsToNumb = (cachedColdTargetGameHoursToNumb * 3600) / cachedTimescale
	SurvivalLogMessage("{{COLD}}     targetRealTimeSecondsToNumb = " + targetRealTimeSecondsToNumb)
	
	float coldPerSecond = c / targetRealTimeSecondsToNumb
	SurvivalLogMessage("{{COLD}}     coldPerSecond = " + coldPerSecond)

	float updateGameTimeDeltaInRealSeconds = (cachedNeedUpdateGameTimeInterval * 3600.0) / cachedTimescale
	SurvivalLogMessage("{{COLD}}     updateGameTimeDeltaInRealSeconds = " + updateGameTimeDeltaInRealSeconds)

	float result = coldPerSecond * updateGameTimeDeltaInRealSeconds
	SurvivalLogMessage("{{COLD}}     result = " + result)

	return result
endFunction

int function GetColdStageMaximum(int aiColdLevel)
	if aiColdLevel >= coldStage5ColdLevelMin
		return 5
	elseif aiColdLevel >= coldStage4ColdLevelMin
		return 4
	elseif aiColdLevel >= coldStage3ColdLevelMin
		return 3
	elseif aiColdLevel >= coldStage2ColdLevelMin
		return 2
	elseif aiColdLevel >= coldStage1ColdLevelMin
		return 1
	else
		return 0
	endif
endFunction

function CheckIfMaxCold(float afColdValue)
    ; Kill the player if necessary
    if afColdValue >= NeedMaxValue.GetValue()
        SurvivalLogMessage("{{COLD}} Player at max cold, killing.")
        PlayerRef.Kill()
    endif
endFunction

function SetUITemperatureLevel(int aiLevel)
    if !conditions.isInPlaneOfOblivion
        Survival_TemperatureLevel.SetValueInt(aiLevel)
    else
        Survival_TemperatureLevel.SetValueInt(temperatureLevelNeutral)
    endif
endFunction

function UpdateTemperatureUI(int aiColdLevel, float afOldColdValue, float afNewColdValue)
	; Set global to update the UI
    int temperatureLevel
    if afOldColdValue == afNewColdValue
        temperatureLevel = temperatureLevelNeutral
    elseif afOldColdValue > afNewColdValue		
        ; Warming up
        temperatureLevel = temperatureLevelWarmArea
    elseif afOldColdValue < afNewColdValue
        ; Getting colder
        if aiColdLevel >= coldStage5ColdLevelMin
            temperatureLevel = temperatureLevelFreezingArea
        else
            temperatureLevel = temperatureLevelColdArea
        endif
    endif
    SetUITemperatureLevel(temperatureLevel)
endFunction

function ForceTemperatureUINearHeat()
    SetUITemperatureLevel(temperatureLevelNearHeat)
endFunction

function ForceTemperatureUINeutral()
    SetUITemperatureLevel(temperatureLevelNeutral)
endFunction

function ForceTemperatureUILastKnown()
    SetUITemperatureLevel(lastTemperatureLevel)
endFunction

function ForceTemperatureLevelUI(int level)
    SetUITemperatureLevel(level)
endFunction

int function UpdateColdLevel()
	SurvivalLogMessage("{{COLD}} GetCurrentColdLevel calculating")
	int coldLevel = 0

	; Freezing Water
	if conditions.isSwimmingInFreezingWater
		return Survival_ColdLevelInFreezingWater.GetValueInt()
	endif

	; Location
	int CurrentAreaType = (PlayerInfoAlias as Survival_PlayerLocationInfo).GetCurrentAreaType()
	if CurrentAreaType == areaTypeChillyInterior
		SurvivalLogMessage("{{COLD}}    In Interior (Cold)...")
		coldLevel += coldLevelFreezingArea
	elseif CurrentAreaType == areaTypeInterior
		SurvivalLogMessage("{{COLD}}    In Interior (Warm)...")
		coldLevel += coldLevelWarmArea
	elseif CurrentAreaType == areaTypeWarm
		SurvivalLogMessage("{{COLD}}    In Warm Area...")
		coldLevel += coldLevelWarmArea
	elseif CurrentAreaType == areaTypeCool
		SurvivalLogMessage("{{COLD}}    In Cool Area...")
		coldLevel += coldLevelCoolArea
	elseif CurrentAreaType == areaTypeFreezing
		SurvivalLogMessage("{{COLD}}    In Freezing Area...")
		coldLevel += coldLevelFreezingArea
	endif

	; Time
	float currentHour = GameHour.GetValue()
	if CurrentAreaType > 0 && (currentHour < 7.0 || currentHour > 19.0)
		SurvivalLogMessage("{{COLD}}    At night...")
		if CurrentAreaType == areaTypeWarm
			coldLevel += coldLevelWarmAreaNightMod
		elseif CurrentAreaType == areaTypeCool
			coldLevel += coldLevelCoolAreaNightMod
		elseif CurrentAreaType == areaTypeFreezing
			coldLevel += coldLevelFreezingAreaNightMod
		endif
	else
		SurvivalLogMessage("{{COLD}}    At day or inside...")
	endif

	; Weather
	Weather theWeather

	if CurrentAreaType > 0
		; Wait for weather to mostly transition in before counting it.
		; Otherwise, use the previous weather.
		if GetCurrentWeatherTransition() >= 0.50
			theWeather = GetCurrentWeather()
		else
			theWeather = GetOutgoingWeather()
		endif
	
		int theWeatherClass = theWeather.GetClassification()
	
		if theWeatherClass == weatherClassSnow
			if Survival_AshWeather.HasForm(theWeather)
				; No mod
			elseif Survival_BlizzardWeather.HasForm(theWeather)
				SurvivalLogMessage("{{COLD}}    In blizzard...")
				coldLevel += coldLevelBlizzardMod
			else
				SurvivalLogMessage("{{COLD}}    In snow...")
				coldLevel += coldLevelSnowMod
			endif
		elseif theWeatherClass == weatherClassRain
			SurvivalLogMessage("{{COLD}}    In rain...")
			coldLevel += coldLevelRainMod
		else
			SurvivalLogMessage("{{COLD}}    In clear weather...")
		endif
	else
		SurvivalLogMessage("{{COLD}}    Ignoring weather (inside)...")
	endif

	SurvivalLogMessage("{{COLD}}    GetCurrentColdLevel = " + coldLevel)

	return coldLevel
endFunction

function DisplayColdLevelTransitionMessage(int aiColdLevel)
    bool inOblivion = (Survival_PlayerInfoQuest as Survival_PlayerInfo).CheckIsInPlaneOfOblivion()
    if !inOblivion
	   if lastColdLevel < coldStage5ColdLevelMin && aiColdLevel >= coldStage5ColdLevelMin
		  Survival_ColdConditionStage5.Show()
	   elseif lastColdLevel < coldStage4ColdLevelMin && aiColdLevel >= coldStage4ColdLevelMin
		  Survival_ColdConditionStage4.Show()
	   elseif lastColdLevel < coldStage3ColdLevelMin && aiColdLevel >= coldStage3ColdLevelMin
		  Survival_ColdConditionStage3.Show()
	   elseif lastColdLevel < coldStage2ColdLevelMin && aiColdLevel >= coldStage2ColdLevelMin
		  Survival_ColdConditionStage2.Show()
	   elseif lastColdLevel < coldStage1ColdLevelMin && aiColdLevel >= coldStage1ColdLevelMin
		  Survival_ColdConditionStage1.Show()
	   elseif lastColdLevel > coldLevelWarmArea && aiColdLevel == coldLevelWarmArea
		  Survival_ColdConditionStage0.Show()
	   endif
    endif
endFunction

function RemoveAllNeedSpells()
    int i = 0
    while i < needSpells.length
        PlayerRef.RemoveSpell(needSpells[i])
        i += 1
    endWhile
endFunction

float function GetMaxStageValue(int maxStageId)
    if conditions.isBeastRace == 1
        return ClampFloatTo(parent.GetMaxStageValue(maxStageId), 0.0, needStage5Value - 1)
    else
        return parent.GetMaxStageValue(maxStageId)
    endif
endFunction

function UpdateAttributePenalty(float afNeedValue, string asAttributeAV = "", string asPenaltyAV = "")
	parent.UpdateAttributePenalty(afNeedValue, "Health", ColdHealthPenaltyAV())
endFunction

function ClearAttributePenalty(string asPenaltyAV = "")
    parent.ClearAttributePenalty(ColdHealthPenaltyAV())
endFunction