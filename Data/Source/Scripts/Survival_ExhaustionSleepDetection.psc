scriptname Survival_ExhaustionSleepDetection extends ReferenceAlias

Actor property PlayerRef auto
GlobalVariable property Survival_ModeEnabled auto
GlobalVariable property Survival_ExhaustionRestorePerHour auto
FormList property Survival_InteriorAreas auto

float lastSleepStartTime
float lastDesiredSleepEndTime

Event OnInit()
	RegisterForSleep()
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	if Survival_ModeEnabled.GetValueInt() == 1
		(self.GetOwningQuest() as Survival_NeedExhaustion).playerSleeping = true
		lastSleepStartTime = afSleepStartTime
	endif
EndEvent

Event OnSleepStop(bool abInterrupted)
	if Survival_ModeEnabled.GetValueInt() == 1
		float actualHoursSlept = (Utility.GetCurrentGameTime() - lastSleepStartTime) * 24
		float amountToRestore = actualHoursSlept * Survival_ExhaustionRestorePerHour.GetValue()
	
		; Was this quality sleep? (Sleeping indoors)
		bool qualitySleep = PlayerRef.IsInInterior() || Survival_InteriorAreas.HasForm(PlayerRef.GetWorldSpace())

		(self.GetOwningQuest() as Survival_NeedExhaustion).DecreaseExhaustion(amountToRestore, qualitySleep)
	endif
EndEvent
