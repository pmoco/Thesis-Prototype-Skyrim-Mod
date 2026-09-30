Scriptname ccBGSSSE001_RadiantFishQuest extends ccBGSSSE001_RadiantItemQuest conditional
{ For radiant quests where the player needs to catch one of several different possible kinds of specific fish. }

Form property itemToCollect auto hidden
Potion[] property potionsToCollect auto
Ingredient[] property ingredientsToCollect auto
ccBGSSSE001_RadiantItemPlayerScript property thePlayer auto

function StartUpQuest()
	parent.StartUpQuest()

	if potionsToCollect && potionsToCollect.length > 0
		currentObjective = Utility.RandomInt(0, potionsToCollect.length - 1)
		itemToCollect = potionsToCollect[currentObjective]
	elseif ingredientsToCollect && ingredientsToCollect.length > 0
		currentObjective = Utility.RandomInt(0, ingredientsToCollect.length - 1)
		itemToCollect = ingredientsToCollect[currentObjective]
	endif
endFunction

function ShowQuest()
	thePlayer.SetPlayerInventoryEventFilter(itemToCollect)
	CheckPlayerForRadiantItems()

	parent.ShowQuest()
endFunction

function FinishQuest(bool abCompleted = true)
	if abCompleted
		PlayerRef.RemoveItem(itemToCollect, itemTotalGlobal.GetValueInt())
	endif

	parent.FinishQuest()
endFunction

function CheckPlayerForRadiantItems()
	int count = PlayerRef.GetItemCount(itemToCollect)
	if count > 0
		RadiantItemAdded(count)
	endif
endFunction