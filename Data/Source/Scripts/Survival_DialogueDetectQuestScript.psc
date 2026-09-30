scriptname Survival_DialogueDetectQuestScript extends Quest

;/
 / Survival_PlayerTalkingQuest holds a conditionalized Reference Alias (PlayerDialogueTarget).
 / If it is filled, the player is currently in dialogue with an NPC.
 /;

GlobalVariable property Survival_ModeEnabled auto
float updateInterval = 12.0

function StartUpdating()
	RegisterForSingleUpdate(updateInterval)
endFunction

Event OnUpdate()
	if Survival_ModeEnabled.GetValueInt() == 1
		self.Stop()
		self.Start()
		RegisterForSingleUpdate(updateInterval)
	endif
EndEvent
