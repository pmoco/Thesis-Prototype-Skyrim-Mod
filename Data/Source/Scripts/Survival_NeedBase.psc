scriptname Survival_NeedBase extends Quest
{ Base need script. Extended by hunger, exhaustion, and cold. }

import Survival_GlobalFunctions

Actor property PlayerRef auto
Survival_ConditionsScript property conditions auto

; Need Spells and Messages
Spell[] property needSpells auto
{ Need spell effect to apply when transitioning to a stage (0 - 5). }
Message[] property needMessagesWhenIncreasing auto
{ Need message notification to display when transitioning to a stage (0 - 5) when need value is increasing. }
Message[] property needMessagesWhenDecreasing auto
{ Need message notification to display when transitioning to a stage (0 - 5) when need value is decreasing. }

GlobalVariable property NeedUpdateGameTimeInterval auto
{ (Optional) How frequently to update (game time, hours). }
GlobalVariable property NeedValue auto
{ The value of the need. }
GlobalVariable property PenaltyPercentGlobal auto
{ The percentage to reduce the player's attribute by (0 - 100). }
GlobalVariable property NeedRate auto
{ How much to increase this need by per tick. }
GlobalVariable property NeedMaxValue auto
{ The maximum value of this need. }
GlobalVariable property Survival_NeedSleepReducedMetabolismMult auto
{ A multiplier (float < 1.0) to reduce amount of need increase when sleeping. }
GlobalVariable property Survival_ExhaustionOverEncumberedMult auto
{ A multiplier to increase Exhaustion by when overencumbered. }
Spell property AttributePenaltySpell auto
{ The spell that applies the attribute penalty for this need. }
MagicEffect property AttributePenaltyEffect auto
{ The magic effect that applies the attribute penalty for this need. }

; Dialogue with NPCs
ReferenceAlias property PlayerDialogueTarget auto

bool property hasBonus = false auto hidden

float property needStage1Value auto hidden
float property needStage2Value auto hidden
float property needStage3Value auto hidden
float property needStage4Value auto hidden
float property needStage5Value auto hidden

; Player Info Data
GlobalVariable property Survival_PlayerLastKnownDaysJailed auto
GlobalVariable property Survival_WasLastNearbyTravelRef auto

;/
 / Optional FX
 /;

Sound[] property needSoundFXs auto
{ Optional. A sound effect to play when transitioning to a stage (0 - 5) (male, and female if no female sounds specified). }

Sound[] property needSoundFXsFemale auto
{ Optional. A sound effect to play when transitioning to a stage (0 - 5) (female). }

float[] property needRumbleSmallMotorStrengths auto
{ Optional. The strength of the small force feedback motor when transitioning to a stage (0 - 5). }

float[] property needRumbleBigMotorStrengths auto
{ Optional. The strength of the big force feedback motor when transitioning to a stage (0 - 5). }

float[] property needRumbleDurations auto
{ Optional. The duration of the force feedback when transitioning to a stage (0 - 5). }

bool[] property needPlaySoundFXsOnImprove auto
{ Whether or not to play the sound effect for a stage (0 - 5) when need transitions to this stage when the player's condition is getting better. }

bool[] property needPlayRumblesOnImprove auto
{ Whether or not to play the force feedback for a stage (0 - 5) when need transitions to this stage when the player's condition is getting better. }

float property NeedMinValue = 0.0 autoReadOnly hidden

float property lastValue = 100.0 auto hidden

bool property locked = false auto hidden
bool property detectedSleepEvent = false auto hidden
bool property detectedFastTravelEvent = false auto hidden
bool property wasIncreasing = true auto hidden
float property lastTimeInGameHours auto hidden
int property oldStage = -1 auto hidden
bool property firstUpdate = true auto hidden

int genderFemale = 1

;/
 / System Management
 /;

function StartNeed()
	if !self.IsRunning()
		self.Start()
	endif

	SetNeedStageValues()

	if NeedUpdateGameTimeInterval
		OnUpdateGameTime()
		RegisterForSingleUpdateGameTime(NeedUpdateGameTimeInterval.GetValue())
		UpdateAttributePenalty(NeedValue.GetValue())
	endif
endFunction

function StopNeed()
	if self.IsRunning()
		self.Stop()
	endif

	RemoveAllNeedSpells()

	ClearAttributePenalty()
	firstUpdate = true

	UnregisterForUpdateGameTime()
endFunction

function SetInOblivion(bool inOblivion = true)
	WaitForUnlock()
	locked = true
	if inOblivion
		; Remove needs
		RemoveAllNeedSpells()
		ClearAttributePenalty()
		PenaltyPercentGlobal.SetValue(0)
		oldStage = -1
	else
		; Return needs
		NeedUpdateGameTime()
	endif
	locked = false
endFunction

Event OnUpdateGameTime()
	if self.IsRunning()
		WaitForUnlock()
		locked = true
		NeedUpdateGameTime()
		RegisterForSingleUpdateGameTime(NeedUpdateGameTimeInterval.GetValue())
		firstUpdate = false
		locked = false
	endif
EndEvent

function WaitForUnlock()
	while locked
		Utility.Wait(0.5)
	endWhile
endFunction

Event OnUpdate()
	SurvivalLogMessage("Applying queued attribute penalty spell.")
	AttributePenaltySpell.Cast(PlayerRef, PlayerRef)
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	detectedSleepEvent = true
EndEvent

;/
 / Behavior
 /;

float function IncrementNeed(float currentNeedValue, float amountToIncrementBy, float maxValue = -1.0)
	float clampedValue

	if maxValue != -1.0
		if currentNeedValue > maxValue
			return currentNeedValue
		elseif (currentNeedValue + amountToIncrementBy) > maxValue
			clampedValue = ClampFloatTo(currentNeedValue + amountToIncrementBy, NeedMinValue, maxValue)
		else
			clampedValue = ClampFloatTo(currentNeedValue + amountToIncrementBy, NeedMinValue, NeedMaxValue.GetValue())
		endif
	else
		clampedValue = ClampFloatTo(currentNeedValue + amountToIncrementBy, NeedMinValue, NeedMaxValue.GetValue())
	endif
	NeedValue.SetValue(clampedValue)

	UpdateAttributePenalty(clampedValue)

	if clampedValue >= needStage1Value
		hasBonus = false
	endif

	wasIncreasing = true
	return clampedValue
endFunction

float function DecrementNeed(float currentNeedValue, float amountToDecrementBy, float customMinValue = -1.0, float customMaxValue = -1.0)
	; Custom min and max values are used by the Exhaustion system to prevent the player from becoming more rested
	; than allowed when sleeping outside in a bed roll.

	float minValue
	float maxValue
	if customMinValue == -1.0
		minValue = NeedMinValue
	else
		minValue = customMinValue
	endif

	if customMaxValue == -1.0
		maxValue = NeedMaxValue.GetValue()
	else
		maxValue = customMaxValue
	endif

	float clampedValue = ClampFloatTo(currentNeedValue - amountToDecrementBy, minValue, maxValue)
	NeedValue.SetValue(clampedValue)
	
	if clampedValue == NeedMinValue
		hasBonus = true
	endif

	UpdateAttributePenalty(clampedValue)

	wasIncreasing = false
	return clampedValue
endFunction

float function GetAmountToIncrementBy(int ticks, float rateReductionMultiplier)
	; Allow Fast Travel and Jail events to occur first
	Utility.Wait(0.1)

	if ticks > 1
		if Game.QueryStat("Days Jailed") > Survival_PlayerLastKnownDaysJailed.GetValueInt()
            SurvivalLogMessage("Player just got out of jail.")
            return 0.0
        endif
    endif

    float amountToIncrementBy
	if !detectedSleepEvent
		amountToIncrementBy = (GetNeedRatePerTick() * ticks) * (1.0 - rateReductionMultiplier)
	else
		detectedSleepEvent = false
		amountToIncrementBy = ((GetNeedRatePerTick() * ticks) * Survival_NeedSleepReducedMetabolismMult.GetValue()) * (1.0 - rateReductionMultiplier)
	endif

	if ticks <= 1
		return amountToIncrementBy
	endif

	SurvivalLogMessage("Player waited or slept, limiting increase amount.")

	float currentNeedValue = NeedValue.GetValue()
	float newNeedValue = currentNeedValue + amountToIncrementBy
	
	if detectedFastTravelEvent
		SurvivalLogMessage("Player traveled using a boat or carriage.")
		detectedFastTravelEvent = false
		if (currentNeedValue < needStage3Value) && (newNeedValue >= needStage3Value)
			return ClampFloatTo((needStage3Value + 25.0) - currentNeedValue, 0.0, needStage3Value + 25.0)
		else
			return currentNeedValue
		endif
	elseif (currentNeedValue < needStage4Value) && (newNeedValue >= needStage4Value)
		return ClampFloatTo((needStage4Value + 25.0) - currentNeedValue, 0.0, needStage4Value + 25.0)
	elseif (currentNeedValue < needStage5Value) && (newNeedValue >= needStage5Value)
		return ClampFloatTo((needStage5Value + 25.0) - currentNeedValue, 0.0, needStage5Value + 25.0)
	else
		return amountToIncrementBy
	endif
endFunction

float function GetNeedRatePerTick()
	return NeedRate.GetValue()
endFunction

float function GetTotalAV(string asAttributeAV, string asPenaltyAV)
	float maxAV = PlayerRef.GetActorValueMax(asAttributeAV)
	float currentPenaltyMagnitude
	if conditions.isBeastRace && asPenaltyAV == ColdHealthPenaltyAV()
		currentPenaltyMagnitude = 0.0
	else
		currentPenaltyMagnitude = PlayerRef.GetAV(asPenaltyAV)
	endif

	SurvivalLogMessage("Penalty magnitude is " + currentPenaltyMagnitude)
	return maxAV + currentPenaltyMagnitude
endFunction

function ClearAttributePenalty(string asPenaltyAV = "")
	PlayerRef.SetAV(asPenaltyAV, 0.0)
	QueuePenaltySpellReApply()
endFunction

function HandleAttributeDiseaseApply(Spell akDisease, ActiveMagicEffect akEffectToDispel, Actor akTarget)
	; Clear and reapply the attribute penalty to calculate the correct disease magnitude
	WaitForUnlock()
	locked = true
	ClearAttributePenalty()

	; The perk that modifies the attribute penalty spell magnitude
	; does not apply instantly.
	Utility.Wait(1)

	akEffectToDispel.Dispel()

	; Ensure that this spell's magnitude no longer affects the player.
	Utility.Wait(0.5)

	akTarget.AddSpell(akDisease, false)
	UpdateAttributePenalty(NeedValue.GetValue())
	locked = false
endFunction

function UpdateAttributePenalty(float afNeedValue, string asAttributeAV = "", string asPenaltyAV = "")
	; Set the Penalty Magnitude AV and Penalty Percent Global
	float totalAV = GetTotalAV(asAttributeAV, asPenaltyAV)
	ApplyAttributePenalty(totalAV, afNeedValue, asAttributeAV, asPenaltyAV)
endFunction

function ApplyAttributePenalty(float afTotalAV, float afNeedValue, string asAttributeAV, string asPenaltyAV)
	float penaltyPercent 
	if conditions.isBeastRace && asPenaltyAV == ColdHealthPenaltyAV()
		penaltyPercent = 0.0
	else
		penaltyPercent = ClampFloatTo((afNeedValue - (needStage2Value - 1.0)) / (NeedMaxValue.GetValue() - (needStage2Value - 1.0)), 0.0, 1.0)
	endif

	float oldPenaltyMagnitude = PlayerRef.GetAV(asPenaltyAV)
	float newPenaltyMagnitude = (afTotalAV * penaltyPercent)
	SurvivalLogMessage("oldPenaltyMagnitude(" + oldPenaltyMagnitude + "), afTotalAV(" + afTotalAV + ") * penaltyPercent(" + penaltyPercent +") = newPenaltyMagnitude(" + newPenaltyMagnitude + ")")
	if newPenaltyMagnitude >= afTotalAV
		; Prevent the attribute from falling to below 0, which can cause improper calculations
		newPenaltyMagnitude = afTotalAV
	endif

	; Set the penalty magnitude, maintaining the current value if need is increasing
	float magnitudeDelta = newPenaltyMagnitude - oldPenaltyMagnitude
	if magnitudeDelta > 0.0
		PlayerRef.RestoreAV(asAttributeAV, magnitudeDelta)
	endif
	SurvivalLogMessage("Setting " + asPenaltyAV + " to " + newPenaltyMagnitude)
	PlayerRef.SetAV(asPenaltyAV, newPenaltyMagnitude)

	; The UI expects an integer between 0 - 100
	; If greater than 0 and less than 1, round up to force display of the meter.
	float penaltyPercentUI = ClampFloatTo(penaltyPercent * 100.0, 0.0, 100.0)
	if penaltyPercentUI > 0.0 && penaltyPercentUI < 1.0
		penaltyPercentUI = 1.0
	endif
	PenaltyPercentGlobal.SetValue(penaltyPercentUI)

	SurvivalLogMessage("Applying " + (penaltyPercent * 100.0) + "% penalty")
	QueuePenaltySpellReApply()
endFunction

function QueuePenaltySpellReApply()
	RegisterForSingleUpdate(0.1)
endFunction

float function GetMaxStageValue(int maxStageId)
	if maxStageId == 5
		return NeedMaxValue.GetValue()
	elseif maxStageId == 4
		return needStage5Value - 1
	elseif maxStageId == 3
		return needStage4Value - 1
	elseif maxStageId == 2
		return needStage3Value - 1
	elseif maxStageId == 1
		return needStage2Value - 1
	else
		return needStage1Value - 1
	endif
endFunction

int function GetTicks(float currentTimeInGameHours, float lastTimeInGameHours)
	int ticks = ((currentTimeInGameHours - lastTimeInGameHours) as int) * ((1 / NeedUpdateGameTimeInterval.GetValue()) as Int)
	if ticks < 1
		ticks = 1
	endif
	SurvivalLogMessage("Progressing by " + ticks + " ticks")
	return ticks
endFunction

;/
 / Effects
 /;

function ApplyNeedStagePlayerEffects(bool increasing, Spell stageSpell, Message stageMessage, message stageMessageOnDecrease = None)
	RemoveAllNeedSpells()

	Utility.WaitMenuMode(0.3)

	SurvivalLogMessage("Applying the stage spell " + stageSpell)
	PlayerRef.AddSpell(stageSpell, false)

	if !firstUpdate
		if increasing && stageMessage
			stageMessage.Show()
		elseif !increasing && stageMessageOnDecrease
			stageMessageOnDecrease.Show()
		endif
	endif
endFunction

function ApplyNeedSFX(bool increasing, Sound sfx, Sound sfxFemale = None, bool applyOnDecrease = false)
    if increasing || applyOnDecrease
    	if sfxFemale && PlayerRef.GetActorBase().GetSex() == genderFemale
    		int id = sfxFemale.Play(PlayerRef)
    	elseif sfx
    		int id = sfx.Play(PlayerRef)
    	endif
    endif
endFunction

function ApplyNeedRumble(bool increasing, float rumbleSmall = -1.0, float rumbleBig = -1.0, float rumbleDuration = -1.0, bool applyOnDecrease = false)
	if rumbleSmall != -1.0 && rumbleBig != -1.0 && rumbleDuration != -1.0
		if increasing || applyOnDecrease
			Game.ShakeController(rumbleSmall, rumbleBig, rumbleDuration)
		endif
	endif
endFunction

bool function IsTalkingToNPC()	
	if PlayerDialogueTarget.GetActorRef() != None
		return true
	endif

	return false
endFunction

;/
 / Required Extends
 /;

function NeedUpdateGameTime()
	BaseScriptExtensionError("NeedUpdateGameTime")
endFunction

function RemoveAllNeedSpells()
	BaseScriptExtensionError("RemoveNeedSpells")
endFunction

function SetNeedStageValues()
	BaseScriptExtensionError("SetNeedStageValues")
endFunction

function BaseScriptExtensionError(string functionName)
	debug.trace("{{SURVIVAL}} Error: Child script did not implement function " + functionName + "!")
endFunction
