Scriptname ccBGSSSE001_RadiantJunkQuest extends ccBGSSSE001_RadiantItemQuest conditional
{ For radiant quests where the player needs to catch non-specific items that aren't taken at the end of the quest. }

int property allCollectedObjectiveAlt auto
{ The alternative All Collected objective. }
ReferenceAlias property aliasToCheckForAltObjective auto
{ The reference alias that, if not filled, will cause the alternate All Collected objective to be displayed. }
int property theObjective = 0 auto
{ The objective to display. Default: 0 }
ccBGSSSE001_RadiantFishEventListener property EventListener auto
int property AllCollectedStage auto
{ The stage to set when all items have been collected. }
int property AllCollectedStageAlt auto
{ The stage to set when all items have been collected if the alternate objective is displayed. }


function StartUpQuest()
	parent.StartUpQuest()

	currentObjective = theObjective
	if !aliasToCheckForAltObjective.GetRef()
		allCollectedObjective = allCollectedObjectiveAlt
	endif

	EventListener.RegisterListener()
endFunction

function FinishQuest(bool abCompleted = true)
	EventListener.UnregisterListener()

	parent.FinishQuest(abCompleted)
endFunction

function RadiantItemAdded(int aiCount)
	bool wasDisplayed = IsObjectiveDisplayed(allCollectedObjective)
	parent.RadiantItemAdded(aiCount)

	if !wasDisplayed && IsObjectiveDisplayed(allCollectedObjective)
		if allCollectedObjective == allCollectedObjectiveAlt
			SetStage(AllCollectedStageAlt)
		else
			SetStage(AllCollectedStage)
		endif
	endif
endFunction