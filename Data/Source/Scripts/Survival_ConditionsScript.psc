scriptname Survival_ConditionsScript extends Quest conditional

Actor property PlayerRef auto

bool property isRidingDragon = false auto conditional hidden
bool property isFastTravelControlsEnabled = true auto conditional hidden
bool property isSwimmingInFreezingWater = false auto conditional hidden
bool property isInPlaneOfOblivion = false auto conditional hidden
bool property isBeastRace = false auto conditional hidden
bool property isMoving = false auto conditional hidden

ObjectReference property lastHeatSourceTrigger auto conditional hidden
bool function IsPlayerNearHeat()
	if lastHeatSourceTrigger
		return PlayerRef.GetDistance(lastHeatSourceTrigger) <= 580.0
	endif
	return false
endFunction

int property isHoldingTorch = 0 auto conditional hidden
function IncrementHoldingTorch()
	isHoldingTorch += 1
endFunction

function DecrementHoldingTorch()
	isHoldingTorch -= 1
endFunction