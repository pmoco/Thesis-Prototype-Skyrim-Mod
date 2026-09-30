scriptname Survival_FastTravelWatcherScript extends ReferenceAlias

import Survival_GlobalFunctions

Event OnPlayerFastTravelEnd(float afTravelGameTimeHours)
	SurvivalLogMessage("Player fast traveled for " + afTravelGameTimeHours + " hours.")
	(self.GetOwningQuest() as Survival_NeedBase).detectedFastTravelEvent = true
endEvent