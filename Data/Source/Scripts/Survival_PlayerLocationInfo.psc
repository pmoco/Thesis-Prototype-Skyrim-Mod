scriptname Survival_PlayerLocationInfo extends ReferenceAlias

import Survival_GlobalFunctions

Actor property PlayerRef auto

bool property inWarmArea = false auto hidden
bool property inCoolArea = false auto hidden
bool property inFreezingArea = false auto hidden

bool property inSouthForestMountainsFreezingArea = false auto hidden
bool property inFallForestMountainsFreezingArea = false auto hidden

FormList property Survival_InteriorAreas auto
FormList property Survival_ColdInteriorLocations auto
FormList property Survival_ColdInteriorCells auto

int areaTypeChillyInterior = -1
int areaTypeInterior = 0
int areaTypeWarm = 1
int areaTypeCool = 2
int areaTypeFreezing = 3

function RegionEntered(string regionName)
	; Avoid a race condition when the mode starts up for the first time where the
	; quest may not be running yet.
	while !self.GetOwningQuest().IsRunning()
		Utility.Wait(0.5)
	endWhile

	bool wasChange = false
	if regionName == "WarmArea"
		wasChange = !inWarmArea
		inWarmArea = true
	elseif regionName == "CoolArea"
		wasChange = !inCoolArea
		inCoolArea = true
	elseif regionName == "FreezingArea"
		wasChange = !inFreezingArea
		inFreezingArea = true
	elseif regionName == "SouthForestMtnsFreezingArea"
		wasChange = !inSouthForestMountainsFreezingArea
		inSouthForestMountainsFreezingArea = true
	elseif regionName == "FallForestMtnsFreezingArea"
		wasChange = !inFallForestMountainsFreezingArea
		inFallForestMountainsFreezingArea = true
	endif

	if wasChange
		SurvivalLogMessage("{{LOCATION}} Entered New Region Type: " + regionName)
	endif
endFunction

function RegionLeft(string regionName)
	bool wasChange = false
	
	if regionName == "WarmArea"
		wasChange = inWarmArea
		inWarmArea = false
	elseif regionName == "CoolArea"
		wasChange = inCoolArea
		inCoolArea = false
	elseif regionName == "FreezingArea"
		wasChange = inFreezingArea
		inFreezingArea = false
	elseif regionName == "SouthForestMtnsFreezingArea"
		wasChange = inSouthForestMountainsFreezingArea
		inSouthForestMountainsFreezingArea = false
	elseif regionName == "FallForestMtnsFreezingArea"
		wasChange = inFallForestMountainsFreezingArea
		inFallForestMountainsFreezingArea = false
	endif

	if wasChange
		SurvivalLogMessage("{{LOCATION}} Exited Region Type: " + regionName)
	endif
endFunction

int function GetCurrentAreaType()
	if PlayerRef.IsInInterior() || Survival_InteriorAreas.HasForm(PlayerRef.GetWorldSpace())
		if Survival_ColdInteriorLocations.HasForm(PlayerRef.GetCurrentLocation()) || Survival_ColdInteriorCells.HasForm(PlayerRef.GetParentCell())
			SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Cold Area (Interior)")
			return areaTypeChillyInterior
		else
			SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Warm Area (Interior)")
			return areaTypeInterior
		endif
	endif

	if inSouthForestMountainsFreezingArea
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Freezing Area (Bleak Falls Barrow, Helgen)")
		return areaTypeFreezing
	elseif inFallForestMountainsFreezingArea
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Freezing Area (Fall Forest)")
		return areaTypeFreezing
	elseif inWarmArea
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Warm Area")
		return areaTypeWarm
	elseif inCoolArea
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Cool Area")
		return areaTypeCool
	elseif inFreezingArea
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Freezing Area")
		return areaTypeFreezing
	else
		SurvivalLogMessage("{{LOCATION}} DetermineCurrentAreaType = Unknown, returning Cool Area")
		return areaTypeCool
	endif
endFunction