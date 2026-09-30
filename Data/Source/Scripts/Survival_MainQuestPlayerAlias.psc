scriptname Survival_MainQuestPlayerAlias extends ReferenceAlias

import Survival_GlobalFunctions

GlobalVariable property Survival_VersionCurrent auto
{ Constant. Current semantic version number. Format: MMmmpp, i.e. 10217 = 1.2.17 }
GlobalVariable property Survival_VersionLastKnown auto
{ The last known version number. Used to know which updates to run on game load. }
GlobalVariable property Survival_ModeEnabled auto
GlobalVariable property Survival_ModeEnabledShared auto

; Needs
Survival_NeedCold property Cold auto
Survival_NeedHunger property Hunger auto
Survival_NeedExhaustion property Exhaustion auto

; Help Articles
FormList property HelpManualPC auto
FormList property HelpManualXBox auto
Message property Survival_HelpSurvivalModeLong auto
Message property Survival_HelpSurvivalModeLongXbox auto

; 0.9.0 Properties
Perk property Survival_NeedsDamageAttributes auto

; 0.9.1 Properties
Survival_DialogueDetectQuestScript property DialogueDetect auto


Event OnPlayerLoadGame()
	; Sanity check
	(self.GetOwningQuest() as Survival_MainScript).RestartUpdateTimer()

	; Cache values
	Cold.PrecacheValues()

	; Help Articles
	AddHelpArticles()

	; Run Updates
	if Survival_ModeEnabled.GetValueInt() == 1
		RunUpdates()
	endif
EndEvent

function AddHelpArticles()
	if !HelpManualPC.HasForm(Survival_HelpSurvivalModeLong)
		HelpManualPC.AddForm(Survival_HelpSurvivalModeLong)
	endif
	if !HelpManualXBox.HasForm(Survival_HelpSurvivalModeLongXbox)
		HelpManualXBox.AddForm(Survival_HelpSurvivalModeLongXbox)
	endif
endFunction

function RunUpdates()
	debug.trace("SURVIVAL: Checking for updates.")
	CheckForVersionUpdates(Survival_VersionLastKnown.GetValueInt())
	Survival_VersionLastKnown.SetValueInt(Survival_VersionCurrent.GetValueInt())
endFunction

function CheckForVersionUpdates(int aiLastKnownVersion)
	UpdateTo000900(aiLastKnownVersion)
	UpdateTo000901(aiLastKnownVersion)
	UpdateTo100004(aiLastKnownVersion)
endFunction

;/
 /  Version Updates
 /;

; 0.9.0
function UpdateTo000900(int aiLastKnownVersion)
	if aiLastKnownVersion < 900
		debug.trace("SURVIVAL:    Updating to 0.9.0.")
		Actor actorRef = self.GetActorRef()

		; Set the new Exhaustion range.
		debug.trace("SURVIVAL:        Setting new Exhaustion values.")
		Exhaustion.SetNeedStageValues()

		; Add the attribute penalty perks.
		if !self.GetActorRef().HasPerk(Survival_NeedsDamageAttributes)
			self.GetActorRef().AddPerk(Survival_NeedsDamageAttributes)
		endif
	endif
endFunction

; 0.9.1
function UpdateTo000901(int aiLastKnownVersion)
	if aiLastKnownVersion < 901
		debug.trace("SURVIVAL:    Updating to 0.9.1.")
		Hunger.RegisterForSleep()
		Cold.RegisterForSleep()
		DialogueDetect.StartUpdating()
	endif
endFunction

; 1.0.4
function UpdateTo100004(int aiLastKnownVersion)
	if aiLastKnownVersion < 10004
		debug.trace("SURVIVAL:    Updating to 1.0.4.")
		debug.trace("SURVIVAL:        Setting shared Survival Enabled global.")
		Survival_ModeEnabledShared.SetValueInt(Survival_ModeEnabled.GetValueInt())

		debug.trace("SURVIVAL:        Setting new Sound Effects values.")
		Hunger.needSoundFXs[2] = None
		Exhaustion.needSoundFXs[2] = None
		Exhaustion.needSoundFXsFemale[2] = None
	endif
endFunction