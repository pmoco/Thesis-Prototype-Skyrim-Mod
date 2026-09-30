scriptname ccBGSSSE001_DialogueDetectScript extends Quest
;/
 / ccBGSSSE001_DialogueDetectQuest holds a conditionalized Reference Alias (PlayerDialogueTarget).
 / If it is filled, the player is currently in dialogue with an NPC.
 /;

ReferenceAlias property PlayerDialogueTarget auto
GlobalVariable property dialogueDetectEnabled auto
ccBGSSSE001_FishingSystemScript property FishingSystem auto

float updateInterval = 2.0


function StartUpdating()
	dialogueDetectEnabled.SetValueInt(1)
	RegisterForSingleUpdate(updateInterval)
endFunction

function StopUpdating()
	dialogueDetectEnabled.SetValueInt(0)
	UnregisterForUpdate()
endFunction

Event OnUpdate()
	if dialogueDetectEnabled.GetValueInt() == 1
		self.Stop()
		self.Start()

		ccBGSSSE001_FishingActScript currentFishingSupplies = FishingSystem.GetCurrentFishingSupplies()

		if PlayerDialogueTarget.GetRef() && currentFishingSupplies
			FishingSystem.OnPlayerInDialogue()
		endif

		RegisterForSingleUpdate(updateInterval)
	endif
EndEvent