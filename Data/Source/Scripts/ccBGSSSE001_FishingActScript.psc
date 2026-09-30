Scriptname ccBGSSSE001_FishingActScript extends ObjectReference
{ The main script attached to fishing supply items, which drives the majority of the fishing mechanic. }

import Utility

;/ 
 / ================
 /  PROPERTIES
 / ================
 /;

 ;/ 
  / System Required Properties
  /;
ccBGSSSE001_FishingSystemScript property FishingSystem auto
{ The system that handles all fishing gameplay mechanics. }

int property BiomeType = 0 auto
{ What type of biome this set of fishing supplies is in. 0 = Temperate Stream, 1 = Temperate Lake, 2 = Arctic, 3 = Cave. Default: 0 }

;/ 
 / Optional Per-Reference Properties
 /;
Quest property myQuest = None auto
{ (Optional) The quest, if any, this set of fishing supplies is associated with. Default: None }

FormList property myQuestCatchDataList = None auto
{ (Optional) The quest item list to draw from for this set of fishing supplies. Default: None }

Int property myQuestStageToSet = -1 auto
{ (Optional) The quest stage to set once a quest item is caught. Default: -1 }

Int property myQuestRequiredStage = -1 auto
{ (Optional) The minimum (or specific, if no RequiredStageMax set) quest stage required in order to catch items from the Quest Catch Data List, if any. Default: -1 }

Int property myQuestRequiredStageMax = -1 auto
{ (Optional) The maximum quest stage required in order to catch items from the Quest Catch Data List, if any. Default: -1 }

GlobalVariable property myQuestItemCaughtGlobal = None auto
{ (Optional) The global variable that must be 0 to catch items from the Quest Catch Data List, if any. Intended use is to track when enough of the quest item has been caught. Must be set externally (this script does not change the value). Default: None }

GlobalVariable property myQuestAllowCatchGlobal = None auto
{ (Optional) The global variable that must be 1 to catch items from the Quest Catch Data List, if any. Intended use is to track when catching the quest item is allowed when a required Quest Stage will not work. Must be set externally (this script does not change the value). Default: None }

Int property myQuestSetStageRequiredRodType = -1 auto
{ (Optional) If this rod type is used, set myQuestStageToSet when the first item is caught. RODTYPE_IMPERIAL = 0, RODTYPE_ALIKRI = 1, RODTYPE_ARGONIAN = 2, RODTYPE_DWARVEN = 3 Default: -1 }

float property myQuestCatchChance = 1.0 auto
{ (Optional) What chance do I have of catching the quest item? Default: 1.0 }

FormList property myOverrideJunkCatchDataList auto
{ The junk override list to draw from for this set of fishing supplies, used for catching specific flavors of junk. }

;/ 
 / ================
 /  LOCAL STATE
 / ================
 /;
bool calculatedPopulationRecently = false
bool wasMorningEvening = false
int currentFishPopulation = 0

; @TODO: Disable fishing as a werewolf or vampire lord (maybe already done)

;/ 
 / ================
 /  FUNCTIONS
 / ================
 /;

;/ 
 / Events
 /;
Auto State Waiting
	Event OnActivate(ObjectReference akActivatorRef)
		GoToState("Busy")
		if akActivatorRef == Game.GetPlayer()
			FishingSystem.StartPlayerInteraction(self)
		endif
		GoToState("Waiting")
	endEvent
endState

State Busy
	; Do nothing
endState

ObjectReference function GetFishingMarker()
	return self.GetLinkedRef()
endFunction

function RegisterForPopulationUpdate(float afHours)
	RegisterForSingleUpdateGameTime(afHours)
endFunction

Event OnUpdateGameTime()
	; Called on the morning after first usage to reset the population.
	debug.trace("Fishing Supplies " + self + " OnUpdateGameTime()")

	SetCalculatedPopulationRecently(false)
	SetWasMorningEvening(false)
	SetFishPopulation(0)
endEvent

function UpdateNibble()
	; EXTEND
endFunction

function UpdateFishCatchSuccess()
	; EXTEND
endFunction

function UpdateFish()
	; EXTEND
endFunction

;/ 
 / Fish Population
 /;
function SetFishPopulation(int aiValue)
	currentFishPopulation = aiValue
endFunction

function ReduceFishPopulation(int aiAmount)
	currentFishPopulation -= aiAmount
	if currentFishPopulation < 0
		currentFishPopulation = 0
	endif
endFunction

bool function GetCalculatedPopulationRecently()
	return calculatedPopulationRecently
endFunction

function SetCalculatedPopulationRecently(bool akCalculatedRecently)
	calculatedPopulationRecently = akCalculatedRecently
endFunction

bool function GetWasMorningEvening()
	return wasMorningEvening
endFunction

function SetWasMorningEvening(bool abWasMorningEvening)
	wasMorningEvening = abWasMorningEvening
endFunction

;/ 
 / Queries
 /;
int function GetCurrentFishPopulation()
	return currentFishPopulation
endFunction

bool function CanCatchQuestItem()
	;/
	 / Determine if the player can catch a quest item based on a number of factors.
	 /
	 / (Required) Is a Quest Catch Data List filled?
	 / If a Required Stage is set, is the quest on that stage?
	 / If a Quest Item Caught global is set, is the value of that global 0?
	 / If a required Rod Type is set, is the player using that rod type?
	 / If a required rod alias is set, is the player using that rod alias?
	 / Were the odds ever in our favor?
	 /;

	if !myQuestCatchDataList
		return false
	endif
	
	if myQuestRequiredStage > -1 
		int currentStage = myQuest.GetStage()

		if myQuestRequiredStageMax > -1
			; Check a range of quest stages.
			if currentStage < myQuestRequiredStage || currentStage > myQuestRequiredStageMax
				return false
			endif
		else
			; Check if the required quest stage is specifically met.
			if currentStage != myQuestRequiredStage
				return false
			endif
		endif
	endif

	if myQuestItemCaughtGlobal && myQuestItemCaughtGlobal.GetValueInt() != 0
		return false
	endif

	if myQuestAllowCatchGlobal && myQuestAllowCatchGlobal.GetValueInt() != 1
		return false
	endif

	if myQuestSetStageRequiredRodType > -1 && FishingSystem.GetCurrentFishingRodType() != myQuestSetStageRequiredRodType
		return false
	endif

	if RandomFloat() > myQuestCatchChance
		return false
	endif

	return true
endFunction

