scriptname Survival_NeedHunger extends Survival_NeedBase

import Survival_GlobalFunctions

Message property Survival_HelpHungerHigh auto
GlobalVariable property Survival_HelpShown_Hunger auto

ReferenceAlias property PlayerAlias auto
FormList property Survival_HungerResistRacesMinor auto
GlobalVariable property Survival_RacialBonusMinor auto

GlobalVariable property Survival_AfflictionHungerChance auto

Spell property Survival_AfflictionWeakened auto
Spell property Survival_DiseaseGutworm auto
Spell property Survival_DiseaseGutworm2 auto
Spell property Survival_DiseaseGutworm3 auto

Message property Survival_AfflictionWeakenedMsg auto

GlobalVariable property Survival_HungerRestoreVerySmallAmount auto
GlobalVariable property Survival_HungerRestoreSmallAmount auto
GlobalVariable property Survival_HungerRestoreMediumAmount auto
GlobalVariable property Survival_HungerRestoreLargeAmount auto

Spell property Survival_DiseaseFoodPoisoning auto

; Eating
float[] property EatingQueue auto
bool property eating = false auto hidden
int currentEatingIndex = 0

function StartNeed()
    oldStage = 99
    parent.StartNeed()
    self.RegisterForSleep()

    PlayerAlias.ForceRefIfEmpty(PlayerRef)
endFunction

function SetNeedStageValues()
                          ; Well Fed
    needStage1Value = 80  ; Satisfied
    needStage2Value = 160 ; Peckish
    needStage3Value = 340 ; Hungry
    needStage4Value = 520 ; Famished
    needStage5Value = 770 ; Starving
endFunction

function StopNeed()
    WaitForUnlock()
    parent.StopNeed()
    PlayerAlias.Clear()
endFunction

function NeedUpdateGameTime()
    SurvivalLogMessage("{{HUNGER}} Update Start")
    bool wasSleeping = detectedSleepEvent

    if conditions.isInPlaneOfOblivion
        SurvivalLogMessage("{{HUNGER}} In Oblivion, skipping NeedUpdateGameTime.")
        lastTimeInGameHours = Utility.GetCurrentGameTime() * 24 ; currentTimeInGameHours
        return
    endif

    ; Calculate resistances
    Race playerRace = PlayerRef.GetActorBase().GetRace()
    float racialBonus
    if Survival_HungerResistRacesMinor.HasForm(playerRace)
        racialBonus = Survival_RacialBonusMinor.GetValue()
    endif

    float totalBonus = racialBonus ; Plus other bonuses / penalties

	float newHungerValue = IncrementNeedByTick(totalBonus)
	ApplyHungerStage(newHungerValue, lastValue)

    if !wasSleeping && newHungerValue >= needStage5Value && !PlayerRef.HasSpell(Survival_AfflictionWeakened)
        ; Weakened
        SurvivalLogMessage("{{HUNGER}} Player eligible for Weakened. Rolling...")
        float result = Utility.RandomFloat()
        SurvivalLogMessage("{{HUNGER}}     Result: " + result)
        if result <= Survival_AfflictionHungerChance.GetValue()
            SurvivalLogMessage("{{HUNGER}}     Player is now Weakened!")
            Survival_AfflictionWeakenedMsg.Show()
            PlayerRef.AddSpell(Survival_AfflictionWeakened, false)
        endif
    endif

	lastValue = newHungerValue
endFunction

function IncreaseHunger(float amount)
    if conditions.isInPlaneOfOblivion
        SurvivalLogMessage("{{HUNGER}} In Oblivion, skipping IncreaseHunger.")
        return
    endif

	SurvivalLogMessage("{{HUNGER}} IncreaseHunger Start")
    float currentNeedValue = NeedValue.GetValue()
	float newHungerValue = IncrementNeed(currentNeedValue, amount)
	ApplyHungerStage(newHungerValue, lastValue)

	lastValue = newHungerValue
endFunction

function DecreaseHungerBuffered(float amount)
    if conditions.isInPlaneOfOblivion
        return
    endif

    AddToEatingBuffer(amount)
    if !eating
        eating = true
        ProcessEatingBuffer()
        eating = false
    endif
endFunction

function AddToEatingBuffer(float amount)
    bool checkedEveryIndex = false

    int nextIndex = currentEatingIndex
    while !checkedEveryIndex
        ; Found empty index
        if EatingQueue[nextIndex] == 0.0
            EatingQueue[nextIndex] = amount
            return
        else
            SurvivalLogMessage("{{EATING}}   Index " + nextIndex + " is populated, checking next index.")
            nextIndex = GetNextIndex(nextIndex, EatingQueue)
        endif

        if nextIndex == currentEatingIndex
            checkedEveryIndex = true
        endif
    endWhile

    ; Couldn't find empty index, overwrite existing index
    SurvivalLogMessage("{{EATING}}   Could not find empty entry from current starting point, overwriting " + nextIndex)
    EatingQueue[nextIndex] = amount
endFunction

function ProcessEatingBuffer()
    bool foodToEat = true

    while foodToEat
        float eatingValue = EatingQueue[currentEatingIndex]
        EatingQueue[currentEatingIndex] = 0.0
        if eatingValue != 0.0
            DecreaseHungerImpl(eatingValue)
            SurvivalLogMessage("{{EATING}}   Ate food at index " + currentEatingIndex)
            currentEatingIndex = GetNextIndex(currentEatingIndex, EatingQueue)
        else
            foodToEat = false
        endif
    endWhile
endFunction

function DecreaseHungerImpl(float amount)
    SurvivalLogMessage("{{HUNGER}} DecreaseHunger Start")
    amount *= GetGutwormEffectMult()
    float currentNeedValue = NeedValue.GetValue()
    float newHungerValue = DecrementNeed(currentNeedValue, amount)
    ApplyHungerStage(newHungerValue, lastValue)

    lastValue = newHungerValue
endFunction

int function GetNextIndex(int idx, float[] array)
    return (idx + 1) % array.length
endFunction

function DecreaseHungerVerySmall()
    DecreaseHungerBuffered(Survival_HungerRestoreVerySmallAmount.GetValue())
endFunction

function DecreaseHungerSmall()
    DecreaseHungerBuffered(Survival_HungerRestoreSmallAmount.GetValue())
endFunction

function DecreaseHungerMedium()
    DecreaseHungerBuffered(Survival_HungerRestoreMediumAmount.GetValue())
endFunction

function DecreaseHungerLarge()
    DecreaseHungerBuffered(Survival_HungerRestoreLargeAmount.GetValue())
endFunction

function ApplyHungerStage(float newHungerValue, float oldHungerValue)
    bool increasing = newHungerValue > oldHungerValue
    SurvivalLogMessage("{{HUNGER}}     Applying Hunger stage. New value: " + newHungerValue + ", Old value: " + oldHungerValue + ", increasing: " + increasing)

    int newStage
    if hasBonus
        newStage = 0
    elseif Between(newHungerValue, needStage2Value, NeedMinValue)
        newStage = 1
    elseif Between(newHungerValue, needStage3Value, needStage2Value)
        newStage = 2
    elseif Between(newHungerValue, needStage4Value, needStage3Value)
        newStage = 3
    elseif Between(newHungerValue, needStage5Value, needStage4Value)
        newStage = 4
    elseif Between(newHungerValue, NeedMaxValue.GetValue(), needStage5Value, inclusiveUpperBound = true)
        newStage = 5
    endif

    if newStage != oldStage
        SurvivalLogMessage("{{HUNGER}}     Applying Stage " + newStage)
        ApplyNeedStagePlayerEffects(increasing, needSpells[newStage], needMessagesWhenIncreasing[newStage], needMessagesWhenDecreasing[newStage])
        ApplyNeedSFX(increasing, needSoundFXs[newStage], needSoundFXsFemale[newStage], needPlaySoundFXsOnImprove[newStage])
        ApplyNeedRumble(increasing, needRumbleSmallMotorStrengths[newStage], needRumbleBigMotorStrengths[newStage], needRumbleDurations[newStage], needPlayRumblesOnImprove[newStage])
    endif

    oldStage = newStage

    if newStage >= 2 && Survival_HelpShown_Hunger.GetValueInt() == 0 && !PlayerRef.IsInCombat()
        Survival_HelpHungerHigh.Show()
        Survival_HelpShown_Hunger.SetValueInt(1)
    endif
endFunction

float function IncrementNeedByTick(float rateReductionMultiplier = 0.0)
    Utility.Wait(1)
    SurvivalLogMessage("{{HUNGER}}     IncrementNeedByTick with rateReductionMultiplier = " + rateReductionMultiplier)

    float currentNeedValue = NeedValue.GetValue()
    float newNeedValue
    float currentTimeInGameHours = Utility.GetCurrentGameTime() * 24
    float currentTimeInRealSeconds = Utility.GetCurrentRealTime()

    if firstUpdate
        SurvivalLogMessage("{{HUNGER}}     Ignoring the first update and storing update time.")
        lastTimeInGameHours = currentTimeInGameHours
        return currentNeedValue + 1
    endif

    int ticks = GetTicks(currentTimeInGameHours, lastTimeInGameHours)
    float amountToIncrementBy = GetAmountToIncrementBy(ticks, rateReductionMultiplier)
    newNeedValue = IncrementNeed(currentNeedValue, amountToIncrementBy)
    SurvivalLogMessage("{{HUNGER}}     Incrementing need by " + amountToIncrementBy)

    lastTimeInGameHours = currentTimeInGameHours
    SurvivalLogMessage("{{HUNGER}}     New value is " + newNeedValue)
    return newNeedValue
endFunction

float function GetGutwormEffectMult()
    if PlayerRef.HasSpell(Survival_DiseaseGutworm)
        return 0.75
    elseif PlayerRef.HasSpell(Survival_DiseaseGutworm2)
        return 0.5
    elseif PlayerRef.HasSpell(Survival_DiseaseGutworm3)
        return 0.25
    else
        return 1.0
    endif
endFunction

;/
 / Required Extends
 /;

function RemoveAllNeedSpells()
    int i = 0
    while i < needSpells.length
        PlayerRef.RemoveSpell(needSpells[i])
        i += 1
    endWhile
endFunction

function UpdateAttributePenalty(float afNeedValue, string asAttributeAV = "", string asPenaltyAV = "")
    parent.UpdateAttributePenalty(afNeedValue, "Stamina", HungerStaminaPenaltyAV())
endFunction

function ClearAttributePenalty(string asPenaltyAV = "")
    parent.ClearAttributePenalty(HungerStaminaPenaltyAV())
endFunction