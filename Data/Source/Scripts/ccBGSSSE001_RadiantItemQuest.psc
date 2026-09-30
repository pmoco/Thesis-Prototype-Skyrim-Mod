Scriptname ccBGSSSE001_RadiantItemQuest extends Quest hidden conditional
{ The base radiant quest script. }

int property currentObjective auto conditional hidden
int property allCollectedObjective auto
int property bountyLetterObjectiveBase auto
int property minItemsToCollect auto
int property maxItemsToCollect auto
GlobalVariable property itemCountGlobal auto
GlobalVariable property itemTotalGlobal auto
GlobalVariable property radiantQuestRunning auto
ReferenceAlias property MapMarker auto
Actor property PlayerRef auto
MiscObject property Gold001 auto
Book[] property BountyLetters auto
ReferenceAlias property BountyLetterAlias auto
int property GoldRewardAmount01 = 100 AutoReadOnly
int property GoldRewardAmount02 = 175 AutoReadOnly
int property GoldRewardAmount03 = 250 AutoReadOnly
int property GoldRewardAmount04 = 325 AutoReadOnly
int property GoldRewardAmount05 = 400 AutoReadOnly

function StartUpQuest()
	radiantQuestRunning.SetValueInt(1)

	; Start a random objective
	itemCountGlobal.SetValueInt(0)

	int totalToCollect = Utility.RandomInt(minItemsToCollect, maxItemsToCollect)
	itemTotalGlobal.SetValueInt(totalToCollect)

	UpdateCurrentInstanceGlobal(itemCountGlobal)
	UpdateCurrentInstanceGlobal(itemTotalGlobal)
endFunction

function GivePlayerBountyLetter()
	ObjectReference theLetter = PlayerRef.PlaceAtMe(BountyLetters[currentObjective])
	BountyLetterAlias.ForceRefTo(theLetter)
	PlayerRef.AddItem(theLetter)

	; Prompt them to read the bounty letter
	SetobjectiveDisplayed(bountyLetterObjectiveBase + currentObjective)
endFunction

function ShowQuest()
	; Player has read the bounty letter
	SetobjectiveCompleted(bountyLetterObjectiveBase + currentObjective)

	SetObjectiveDisplayed(currentObjective)
	SetStage(currentObjective + 10)

	ObjectReference mapMarkerRef = MapMarker.GetRef()
	if mapMarkerRef
		mapMarkerRef.AddToMap()
	EndIf
endFunction

function FinishQuest(bool abCompleted = true)
	radiantQuestRunning.SetValueInt(0)

	if abCompleted
		PlayerRef.AddItem(Gold001, GetRewardAmount())
		CompleteAllObjectives()
	else
		FailAllObjectives()
	endif

	Stop()
endFunction

function RadiantItemAdded(int aiCount)
	float newValue = itemCountGlobal.Mod(aiCount)
	float totalValue = itemTotalGlobal.GetValue()
	UpdateCurrentInstanceGlobal(itemCountGlobal)

	if newValue >= totalValue && !IsObjectiveCompleted(currentObjective)
		SetObjectiveCompleted(currentObjective)
		SetObjectiveDisplayed(allCollectedObjective)
	elseif newValue < totalValue
		SetObjectiveDisplayed(currentObjective, abForce = true)
	endif
endFunction

function RadiantItemRemoved(int aiCount)
	float newValue = itemCountGlobal.Mod(-aiCount)
	float totalValue = itemTotalGlobal.GetValue()
	UpdateCurrentInstanceGlobal(itemCountGlobal)

	if newValue < totalValue
		if IsObjectiveCompleted(currentObjective)
			SetObjectiveCompleted(currentObjective, false)
			SetObjectiveDisplayed(currentObjective, abForce = true)
			SetObjectiveDisplayed(allCollectedObjective, false)
		else
			SetObjectiveDisplayed(currentObjective, abForce = true)
		endif
	endif
endFunction

int function GetRewardAmount()
	int level = PlayerRef.GetLevel()
	if level < 10
		return GoldRewardAmount01
	elseif level < 20
		return GoldRewardAmount02
	elseif level < 30
		return GoldRewardAmount03
	elseif level < 40
		return GoldRewardAmount04
	else
		return GoldRewardAmount05
	endif
endFunction