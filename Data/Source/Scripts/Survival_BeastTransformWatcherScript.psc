scriptname Survival_BeastTransformWatcherScript extends ReferenceAlias

Survival_ConditionsScript property conditions auto
Survival_NeedCold property cold auto
FormList property Survival_BeastRaces auto

Event OnRaceSwitchComplete()
	; Wait to allow the player's Health to change before recalculating
	; attribute penalties.
	Utility.Wait(1.0)

	Race playerRace = self.GetActorRef().GetRace()

	if Survival_BeastRaces.HasForm(playerRace)
		conditions.isBeastRace = true
	else
		conditions.isBeastRace = false
	endif

	cold.UpdateAttributePenalty(cold.NeedValue.GetValue())
EndEvent
