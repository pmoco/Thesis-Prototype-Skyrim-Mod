Scriptname ccBGSSSE001_MiscQuestScript extends Quest  

Quest[] property MiscQuests auto
Book[] property BountyLetters auto
ReferenceAlias property ActiveBountyLetter auto
Actor property PlayerRef auto
int property AskObjective auto
int property DoneStage auto

book function GivePlayerBountyLetterForQuest(Quest akQuest)
	int questIndex = MiscQuests.Find(akQuest)
	if questIndex == -1
		debug.trace("ERROR: An invalid quest was passed to GivePlayerBountyLetterForQuest!")
		return None
	endif

	ObjectReference letter = PlayerRef.PlaceAtMe(BountyLetters[questIndex])
	ActiveBountyLetter.ForceRefTo(letter)
	
	(ActiveBountyLetter as DefaultOnReadSetQuestStage).myStage = GetMiscQuestLetterWasReadStage(questIndex)
	int readLetterObjective = GetMiscQuestReadLetterObjective(questIndex)

	PlayerRef.AddItem(letter)

	SetObjectiveCompleted(AskObjective)
	SetObjectiveDisplayed(readLetterObjective)
endFunction

function SetBountyLetterWasRead(Quest akQuest)
	int questIndex = MiscQuests.Find(akQuest)
	if questIndex == -1
		debug.trace("ERROR: An invalid quest was passed to SetBountyLetterWasRead!")
		return
	endif

	int readLetterObjective = GetMiscQuestReadLetterObjective(questIndex)
	SetObjectiveCompleted(readLetterObjective)

	int questStageToSet = GetMiscQuestLetterWasReadStage(questIndex)
	SetStage(questStageToSet)

	MiscQuests[questIndex].Start()
endFunction

function SetQuestComplete(Quest akQuest, bool abAskAgain = true)
	int questIndex = MiscQuests.Find(akQuest)
	if questIndex == -1
		debug.trace("ERROR: An invalid quest was passed to SetQuestComplete!")
		return
	endif

	if abAskAgain
		int questStageToSet = GetMiscQuestCompleteStage(questIndex)
		SetStage(questStageToSet)

		SetObjectiveCompleted(AskObjective, false)
		SetObjectiveDisplayed(AskObjective)
	else
		SetStage(DoneStage)
	endif
endFunction

int function GetMiscQuestReadLetterObjective(int aiQuestIndex)
	return (aiQuestIndex * 10) ; i.e. Misc Quest 2 read letter objective = 10
endFunction

int function GetMiscQuestLetterWasReadStage(int aiQuestIndex)
	return ((aiQuestIndex + 1) * 10) + 5 ; i.e. Misc Quest 2 letter was read = Stage 35
endFunction

int function GetMiscQuestCompleteStage(int aiQuestIndex)
	return ((aiQuestIndex + 1) * 10) + 10 ; i.e. Misc Quest 2 complete = 40
endFunction
