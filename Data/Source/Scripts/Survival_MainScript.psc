scriptname Survival_MainScript extends Quest

import Survival_GlobalFunctions

Survival_NeedHunger property Hunger auto
Survival_NeedExhaustion property Exhaustion auto
Survival_NeedCold property Cold auto
Survival_PlayerInfo property PlayerInfo auto
Survival_HeatCheck property HeatCheck auto
Survival_MainQuestPlayerAlias property Updates auto
Survival_DialogueDetectQuestScript property DialogueDetect auto

Quest property MQ101 auto

GlobalVariable property Survival_ModeEnabled auto
{ Whether or not Survival Mode is enabled. 1 = On, 0 = Off }

GlobalVariable property Survival_ModeEnabledShared auto
{ Whether or not Survival Mode is enabled (for use with other Creations). 1 = On, 0 = Off }

GlobalVariable property Survival_ModeCanBeEnabled auto
{ Whether or not Survival Mode is allowed to be enabled. 1 = Yes, 0 = No. Setting this value controls the availability of the
  checkbox in the Gameplay Settings menu. }

GlobalVariable property Survival_PlayerHasBeenPrompted auto
{ Has the player been prompted to start the mode? }

GlobalVariable property Survival_ModeToggle auto
{ On/Off switch for entire Survival Mode. Set externally via the UI or as part of game tutorial. 1 = Turn On, 0 = Turn Off }

FormList property HelpManualPC auto
FormList property HelpManualXBox auto
Message property Survival_HelpSurvivalModeLong auto
Message property Survival_HelpSurvivalModeLongXbox auto

Actor property PlayerRef auto
Message property Survival_StartPrompt auto
FormList property Survival_SurvivalAfflictions auto
FormList property Survival_SurvivalDiseases auto
Spell property Survival_FreezingWaterDamage auto
Perk property Survival_TempleBlessingCostPerk auto
Perk property Survival_ExhuastionReduceConsumables auto
Perk property Survival_NeedsDamageAttributes auto
LeveledItem property LItemFoodSalt auto
LeveledItem property LItemFoodSaltSmall auto
LeveledItem property LItemFoodSalt75 auto
ObjectReference[] property HeatSourceTriggerRefs auto
ObjectReference property Survival_HeatSourceReturnRef auto

;/----Notes:-------------------------------------------------------------------
 | Handle start-up and shut-down in an update loop instead of an event pushed 
 | from the UI, in order to avoid rapid start-up / shut-down processes and 
 | clobbering the script system due to user input.
 |
 | Player ReferenceAlias script also registers for update on game load
 | for fault tolerance.
 /---------------------------------------------------------------------------/;


Event OnInit()
	HelpManualPC.AddForm(Survival_HelpSurvivalModeLong)
	HelpManualXBox.AddForm(Survival_HelpSurvivalModeLongXbox)
	
	RestartUpdateTimer()
EndEvent

Event OnUpdate()
	PromptToStartSurvivalMode()

	bool canBeEnabled = ModeCanBeEnabled()

	if ModeShouldBeEnabled() && canBeEnabled && ModeIsDisabled()
		StartSurvivalMode()
	elseif ModeShouldBeDisabled() && ModeIsEnabled()
		StopSurvivalMode()
	endif

	RestartUpdateTimer()
EndEvent

function PromptToStartSurvivalMode()
	if Survival_PlayerHasBeenPrompted.GetValueInt() == 0 && ModeCanBeEnabled()
		int choice = Survival_StartPrompt.Show()
		if choice == 0
			Survival_ModeToggle.SetValueInt(1)
		endif
		Survival_PlayerHasBeenPrompted.SetValueInt(1)
	endif
endFunction

function StartSurvivalMode()
	Survival_PlayerHasBeenPrompted.SetValueInt(1)

	; Utilities
	PlayerInfo.StartUpdating()
	HeatCheck.StartUpdating()
	DialogueDetect.StartUpdating()

	; Perks and Items
	AddSurvivalPerks()
	PopulateSurvivalItems()

	; Needs
	StartSurvivalNeeds()

	Survival_ModeEnabled.SetValueInt(1)
	Survival_ModeEnabledShared.SetValueInt(1)

	debug.trace("Survival Mode is running.")
	Updates.RunUpdates()
endFunction

function StopSurvivalMode()
	; Utilities
	PlayerInfo.StopUpdating()
	HeatCheck.StopUpdating()
	; DialogueDetect.StopUpdating()   // Updates stop when mode disabled

	; Needs
	StopSurvivalNeeds()

	; Perks and Items
	RemoveSurvivalPerks()
	DepopulateSurvivalItems()
	
	; Diseases
	RemoveSurvivalDiseases()
	RemoveSurvivalAfflictions()

	; Spells
	RemoveSurvivalSpells()

	; Heat Source Trigger Volumes
	StoreHeatSourceTriggerVolumes()

	Survival_ModeEnabled.SetValueInt(0)
	Survival_ModeEnabledShared.SetValueInt(0)

	debug.trace("Survival Mode is stopped.")
endFunction

function StartSurvivalNeeds()
	Hunger.StartNeed()
	Exhaustion.StartNeed()
	Cold.StartNeed()
endFunction

function StopSurvivalNeeds()
	Hunger.StopNeed()
	Exhaustion.StopNeed()
	Cold.StopNeed()
endFunction

function RemoveSurvivalDiseases()
	int i = 0
	while i < Survival_SurvivalDiseases.GetSize()
		PlayerRef.RemoveSpell(Survival_SurvivalDiseases.GetAt(i) as Spell)
		i += 1
	endWhile
endFunction

function RemoveSurvivalAfflictions()
	int i = 0
	while i < Survival_SurvivalAfflictions.GetSize()
		PlayerRef.RemoveSpell(Survival_SurvivalAfflictions.GetAt(i) as Spell)
		i += 1
	endWhile
endFunction

function RemoveSurvivalSpells()
	PlayerRef.RemoveSpell(Survival_FreezingWaterDamage)
	PlayerRef.DispelSpell(Hunger.AttributePenaltySpell)
	PlayerRef.DispelSpell(Exhaustion.AttributePenaltySpell)
	PlayerRef.DispelSpell(Cold.AttributePenaltySpell)
endFunction

function AddSurvivalPerks()
	PlayerRef.AddPerk(Survival_TempleBlessingCostPerk)
	PlayerRef.AddPerk(Survival_ExhuastionReduceConsumables)
	PlayerRef.AddPerk(Survival_NeedsDamageAttributes)
endFunction

function RemoveSurvivalPerks()
	PlayerRef.RemovePerk(Survival_TempleBlessingCostPerk)
	PlayerRef.RemovePerk(Survival_ExhuastionReduceConsumables)
	PlayerRef.RemovePerk(Survival_NeedsDamageAttributes)
endFunction

function PopulateSurvivalItems()
	LItemFoodSalt.AddForm(LItemFoodSalt75, 1, 1)
	LItemFoodSaltSmall.AddForm(LItemFoodSalt75, 1, 1)
endFunction

function DepopulateSurvivalItems()
	LItemFoodSalt.Revert()
	LItemFoodSaltSmall.Revert()
endFunction

function StoreHeatSourceTriggerVolumes()
	int i = 0
	while i < HeatSourceTriggerRefs.length
		HeatSourceTriggerRefs[i].MoveTo(Survival_HeatSourceReturnRef)
		i += 1
	endWhile
endFunction

;/
 / Utility
 /;

function RestartUpdateTimer()
	RegisterForSingleUpdate(5)
endFunction

bool function ModeShouldBeEnabled()
	return Survival_ModeToggle.GetValueInt() == 1
endFunction

bool function ModeCanBeEnabled()
	bool canBeEnabled = (MQ101.IsCompleted() || (Game.IsFightingControlsEnabled() && !PlayerRef.IsInInterior()))
	if canBeEnabled
		Survival_ModeCanBeEnabled.SetValueInt(1)
	else
		Survival_ModeCanBeEnabled.SetValueInt(0)
	endif
	return canBeEnabled
endFunction

bool function ModeShouldBeDisabled()
	return !ModeShouldBeEnabled()
endFunction

bool function ModeIsEnabled()
	return Survival_ModeEnabled.GetValueInt() == 1
endFunction

bool function ModeIsDisabled()
	return !ModeIsEnabled()
endFunction