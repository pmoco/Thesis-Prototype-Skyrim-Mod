scriptname CCHouseQuestScript extends Quest conditional
{ Maintains Creation Club House variables. }

; PROPERTIES
; -----------------------------------------

; House Ownership
bool PlayerOwns_AnyCCHouse conditional
bool PlayerOwns_CCHouse01 conditional
bool PlayerOwns_CCHouse02 conditional
bool PlayerOwns_CCHouse03 conditional
bool PlayerOwns_CCHouse04 conditional
bool PlayerOwns_CCHouse05 conditional
bool PlayerOwns_CCHouse06 conditional
bool PlayerOwns_CCHouse07 conditional
bool PlayerOwns_CCHouse08 conditional
bool PlayerOwns_CCHouse09 conditional
bool PlayerOwns_CCHouse10 conditional
bool PlayerOwns_CCHouse11 conditional
bool PlayerOwns_CCHouse12 conditional
bool PlayerOwns_CCHouse13 conditional
bool PlayerOwns_CCHouse14 conditional
bool PlayerOwns_CCHouse15 conditional
bool PlayerOwns_CCHouse16 conditional
bool PlayerOwns_CCHouse17 conditional
bool PlayerOwns_CCHouse18 conditional
bool PlayerOwns_CCHouse19 conditional
bool PlayerOwns_CCHouse20 conditional

; Has Child Bedroom
bool HasChildBedroom_Any conditional
bool HasChildBedroom_Multiple conditional
bool HasChildBedroom_CCHouse01 conditional
bool HasChildBedroom_CCHouse02 conditional
bool HasChildBedroom_CCHouse03 conditional
bool HasChildBedroom_CCHouse04 conditional
bool HasChildBedroom_CCHouse05 conditional
bool HasChildBedroom_CCHouse06 conditional
bool HasChildBedroom_CCHouse07 conditional
bool HasChildBedroom_CCHouse08 conditional
bool HasChildBedroom_CCHouse09 conditional
bool HasChildBedroom_CCHouse10 conditional
bool HasChildBedroom_CCHouse11 conditional
bool HasChildBedroom_CCHouse12 conditional
bool HasChildBedroom_CCHouse13 conditional
bool HasChildBedroom_CCHouse14 conditional
bool HasChildBedroom_CCHouse15 conditional
bool HasChildBedroom_CCHouse16 conditional
bool HasChildBedroom_CCHouse17 conditional
bool HasChildBedroom_CCHouse18 conditional
bool HasChildBedroom_CCHouse19 conditional
bool HasChildBedroom_CCHouse20 conditional

; House Center Markers
ObjectReference[] property CCHouseMarkers auto hidden

; House Exterior Locations
Location[] CCHouseExteriorLocs

; House Interior Locations
Location[] CCHouseInteriorLocs

int property CCHouseMinID = 101 autoReadOnly hidden
int property CCHouseMaxID = 120 autoReadOnly hidden

Event OnInit()
	CCHouseMarkers = new ObjectReference[20]
	CCHouseExteriorLocs = new Location[20]
	CCHouseInteriorLocs = new Location[20]
endEvent

; FUNCTIONS
; -----------------------------------------

function SetHouseData(int houseID, ObjectReference houseCenterMarker, Location houseInteriorLocation, Location houseExteriorLocation = None)
	; REQUIRED - Call to set up a new CC House on start-up.
	; Use the same ID numbering system as RelationshipMarriageSpouseHouseScript (assigned house ID + 100).
	; Internal house IDs range from 101 - 120.

	houseID -= CCHouseMinID
	if houseID < 0 || houseID > 19
		return
	endif

	; Does this ID already have data set?
	if CCHouseMarkers[houseID] != None
		debug.trace("WARNING: House ID " + houseID + " already has data!")
	endif

	CCHouseMarkers[houseID] = houseCenterMarker
	CCHouseInteriorLocs[houseID] = houseInteriorLocation
	CCHouseExteriorLocs[houseID] = houseExteriorLocation
endFunction

function SetHouseOwned(int houseID, bool isOwned = true)
	; Set or unset the house ownership flags based on ID.
	; If unset, also clears the child bedroom flag.
	; Use the same ID numbering system as RelationshipMarriageSpouseHouseScript (assigned house ID + 100).

	if houseID < CCHouseMinID || houseID > CCHouseMaxID
		return
	endif

	if houseID == 101
		PlayerOwns_CCHouse01 = isOwned
 	elseif houseID == 102
 		PlayerOwns_CCHouse02 = isOwned
 	elseif houseID == 103
 		PlayerOwns_CCHouse03 = isOwned
 	elseif houseID == 104
 		PlayerOwns_CCHouse04 = isOwned
 	elseif houseID == 105
 		PlayerOwns_CCHouse05 = isOwned
 	elseif houseID == 106
 		PlayerOwns_CCHouse06 = isOwned
 	elseif houseID == 107
 		PlayerOwns_CCHouse07 = isOwned
 	elseif houseID == 108
 		PlayerOwns_CCHouse08 = isOwned
 	elseif houseID == 109
 		PlayerOwns_CCHouse09 = isOwned
 	elseif houseID == 110
 		PlayerOwns_CCHouse10 = isOwned
 	elseif houseID == 111
 		PlayerOwns_CCHouse11 = isOwned
 	elseif houseID == 112
 		PlayerOwns_CCHouse12 = isOwned
 	elseif houseID == 113
 		PlayerOwns_CCHouse13 = isOwned
 	elseif houseID == 114
 		PlayerOwns_CCHouse14 = isOwned
 	elseif houseID == 115
 		PlayerOwns_CCHouse15 = isOwned
 	elseif houseID == 116
 		PlayerOwns_CCHouse16 = isOwned
 	elseif houseID == 117
 		PlayerOwns_CCHouse17 = isOwned
 	elseif houseID == 118
 		PlayerOwns_CCHouse18 = isOwned
 	elseif houseID == 119
 		PlayerOwns_CCHouse19 = isOwned
 	elseif houseID == 120
 		PlayerOwns_CCHouse20 = isOwned
 	endif

 	; If removing house ownership, clear child bedroom flag as well.
 	if !isOwned
 		SetHasChildBedroom(houseID, false)
 	endif

 	UpdateAnyHouseOwnedStatus()
endFunction

function UpdateAnyHouseOwnedStatus()
	; Update the 'Any' house ownership flag.

	if PlayerOwns_CCHouse01 \
	|| PlayerOwns_CCHouse02 \
	|| PlayerOwns_CCHouse03 \
	|| PlayerOwns_CCHouse04 \
	|| PlayerOwns_CCHouse05 \
	|| PlayerOwns_CCHouse06 \
	|| PlayerOwns_CCHouse07 \
	|| PlayerOwns_CCHouse08 \
	|| PlayerOwns_CCHouse09 \
	|| PlayerOwns_CCHouse10 \
	|| PlayerOwns_CCHouse11 \
	|| PlayerOwns_CCHouse12 \
	|| PlayerOwns_CCHouse13 \
	|| PlayerOwns_CCHouse14 \
	|| PlayerOwns_CCHouse15 \
	|| PlayerOwns_CCHouse16 \
	|| PlayerOwns_CCHouse17 \
	|| PlayerOwns_CCHouse18 \
	|| PlayerOwns_CCHouse19 \
	|| PlayerOwns_CCHouse20
		PlayerOwns_AnyCCHouse = true
	else
		PlayerOwns_AnyCCHouse = false
	endif
endFunction

function SetHasChildBedroom(int houseID, bool hasChildBedroom = true)
	; Set or unset the child bedroom flags based on ID.
	; To set, the player must own the house.
	; Use the same ID numbering system as RelationshipMarriageSpouseHouseScript (assigned house ID + 100).

	if houseID < CCHouseMinID || houseID > CCHouseMaxID
		return
	endif

	if houseID == 101 && (PlayerOwns_CCHouse01 || !hasChildBedroom)
		HasChildBedroom_CCHouse01 = hasChildBedroom
 	elseif houseID == 102 && (PlayerOwns_CCHouse02 || !hasChildBedroom)
 		HasChildBedroom_CCHouse02 = hasChildBedroom
 	elseif houseID == 103 && (PlayerOwns_CCHouse03 || !hasChildBedroom)
 		HasChildBedroom_CCHouse03 = hasChildBedroom
 	elseif houseID == 104 && (PlayerOwns_CCHouse04 || !hasChildBedroom)
 		HasChildBedroom_CCHouse04 = hasChildBedroom
 	elseif houseID == 105 && (PlayerOwns_CCHouse05 || !hasChildBedroom)
 		HasChildBedroom_CCHouse05 = hasChildBedroom
 	elseif houseID == 106 && (PlayerOwns_CCHouse06 || !hasChildBedroom)
 		HasChildBedroom_CCHouse06 = hasChildBedroom
 	elseif houseID == 107 && (PlayerOwns_CCHouse07 || !hasChildBedroom)
 		HasChildBedroom_CCHouse07 = hasChildBedroom
 	elseif houseID == 108 && (PlayerOwns_CCHouse08 || !hasChildBedroom)
 		HasChildBedroom_CCHouse08 = hasChildBedroom
 	elseif houseID == 109 && (PlayerOwns_CCHouse09 || !hasChildBedroom)
 		HasChildBedroom_CCHouse09 = hasChildBedroom
 	elseif houseID == 110 && (PlayerOwns_CCHouse10 || !hasChildBedroom)
 		HasChildBedroom_CCHouse10 = hasChildBedroom
 	elseif houseID == 111 && (PlayerOwns_CCHouse11 || !hasChildBedroom)
 		HasChildBedroom_CCHouse11 = hasChildBedroom
 	elseif houseID == 112 && (PlayerOwns_CCHouse12 || !hasChildBedroom)
 		HasChildBedroom_CCHouse12 = hasChildBedroom
 	elseif houseID == 113 && (PlayerOwns_CCHouse13 || !hasChildBedroom)
 		HasChildBedroom_CCHouse13 = hasChildBedroom
 	elseif houseID == 114 && (PlayerOwns_CCHouse14 || !hasChildBedroom)
 		HasChildBedroom_CCHouse14 = hasChildBedroom
 	elseif houseID == 115 && (PlayerOwns_CCHouse15 || !hasChildBedroom)
 		HasChildBedroom_CCHouse15 = hasChildBedroom
 	elseif houseID == 116 && (PlayerOwns_CCHouse16 || !hasChildBedroom)
 		HasChildBedroom_CCHouse16 = hasChildBedroom
 	elseif houseID == 117 && (PlayerOwns_CCHouse17 || !hasChildBedroom)
 		HasChildBedroom_CCHouse17 = hasChildBedroom
 	elseif houseID == 118 && (PlayerOwns_CCHouse18 || !hasChildBedroom)
 		HasChildBedroom_CCHouse18 = hasChildBedroom
 	elseif houseID == 119 && (PlayerOwns_CCHouse19 || !hasChildBedroom)
 		HasChildBedroom_CCHouse19 = hasChildBedroom
 	elseif houseID == 120 && (PlayerOwns_CCHouse20 || !hasChildBedroom)
 		HasChildBedroom_CCHouse20 = hasChildBedroom
 	endif

 	UpdateHouseChildBedroomStatus()
endFunction

function UpdateHouseChildBedroomStatus()
	; Update the 'Any' and 'Multiple' child bedroom flags.

	int childBedroomCount = 0

	if HasChildBedroom_CCHouse01
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse02
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse03
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse04
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse05
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse06
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse07
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse08
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse09
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse10
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse11
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse12
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse13
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse14
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse15
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse16
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse17
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse18
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse19
		childBedroomCount += 1
	endif
	if HasChildBedroom_CCHouse20
		childBedroomCount += 1
	endif

	if childBedroomCount == 0
		HasChildBedroom_Any = false
		HasChildBedroom_Multiple = false
	elseif childBedroomCount == 1
		HasChildBedroom_Any = true
		HasChildBedroom_Multiple = false
	else
		HasChildBedroom_Any = true
		HasChildBedroom_Multiple = true
	EndIf
endFunction

int Function ValidateCCHouseMoveDestination(int destination, int secondary)
	; When a move is triggered, confirm that the player's family can actually be moved to that location. If not, select the best alternative.
	; Like BYOHRelationshipAdoptableScript.ValidateMoveDestination(), but for CC Houses.

	int tertiary = 0
	if HasChildBedroom_CCHouse01
		if destination == 101
			return destination
		elseif tertiary == 0
			tertiary = 101
		endif
	endif
	if HasChildBedroom_CCHouse02
		if destination == 102
			return destination
		elseif tertiary == 0
			tertiary = 102
		endif
	endif
	if HasChildBedroom_CCHouse03
		if destination == 103
			return destination
		elseif tertiary == 0
			tertiary = 103
		endif
	endif
	if HasChildBedroom_CCHouse04
		if destination == 104
			return destination
		elseif tertiary == 0
			tertiary = 104
		endif
	endif
	if HasChildBedroom_CCHouse05
		if destination == 105
			return destination
		elseif tertiary == 0
			tertiary = 105
		endif
	endif
	if HasChildBedroom_CCHouse06
		if destination == 106
			return destination
		elseif tertiary == 0
			tertiary = 106
		endif
	endif
	if HasChildBedroom_CCHouse07
		if destination == 107
			return destination
		elseif tertiary == 0
			tertiary = 107
		endif
	endif
	if HasChildBedroom_CCHouse08
		if destination == 108
			return destination
		elseif tertiary == 0
			tertiary = 108
		endif
	endif
	if HasChildBedroom_CCHouse09
		if destination == 109
			return destination
		elseif tertiary == 0
			tertiary = 109
		endif
	endif
	if HasChildBedroom_CCHouse10
		if destination == 110
			return destination
		elseif tertiary == 0
			tertiary = 110
		endif
	endif
	if HasChildBedroom_CCHouse11
		if destination == 111
			return destination
		elseif tertiary == 0
			tertiary = 111
		endif
	endif
	if HasChildBedroom_CCHouse12
		if destination == 112
			return destination
		elseif tertiary == 0
			tertiary = 112
		endif
	endif
	if HasChildBedroom_CCHouse13
		if destination == 113
			return destination
		elseif tertiary == 0
			tertiary = 113
		endif
	endif
	if HasChildBedroom_CCHouse14
		if destination == 114
			return destination
		elseif tertiary == 0
			tertiary = 114
		endif
	endif
	if HasChildBedroom_CCHouse15
		if destination == 115
			return destination
		elseif tertiary == 0
			tertiary = 115
		endif
	endif
	if HasChildBedroom_CCHouse16
		if destination == 116
			return destination
		elseif tertiary == 0
			tertiary = 116
		endif
	endif
	if HasChildBedroom_CCHouse17
		if destination == 117
			return destination
		elseif tertiary == 0
			tertiary = 117
		endif
	endif
	if HasChildBedroom_CCHouse18
		if destination == 118
			return destination
		elseif tertiary == 0
			tertiary = 118
		endif
	endif
	if HasChildBedroom_CCHouse19
		if destination == 119
			return destination
		elseif tertiary == 0
			tertiary = 119
		endif
	endif
	if HasChildBedroom_CCHouse20
		if destination == 120
			return destination
		elseif tertiary == 0
			tertiary = 120
		endif
	endif

	if secondary > 0
		return secondary
	endif
	
	return tertiary 
EndFunction

ObjectReference function TranslateCCHouseIntToObj(int newHouse)
	if newHouse < CCHouseMinID || newHouse > CCHouseMaxID
		return None
	endif

	newHouse -= CCHouseMinID
	return CCHouseMarkers[newHouse]
endFunction

Location function TranslateCCHouseIntToExteriorLoc(int newHouse)
	if newHouse < CCHouseMinID || newHouse > CCHouseMaxID
		return None
	endif

	newHouse -= CCHouseMinID
	return CCHouseExteriorLocs[newHouse]
endFunction

Location function TranslateCCHouseIntToInteriorLoc(int newHouse)
	if newHouse < CCHouseMinID || newHouse > CCHouseMaxID
		return None
	endif

	newHouse -= CCHouseMinID
	return CCHouseInteriorLocs[newHouse]
endFunction

int function TranslateCCHouseExteriorLocToInt(Location newLoc)
	int i = 0
	while i < CCHouseExteriorLocs.length
		if (newLoc == CCHouseExteriorLocs[i])
			return i + CCHouseMinID
		endif
		i += 1
	endWhile

	return 0
endFunction

bool Function IsCCHouseDestination(int aDestination)
	return aDestination >= CCHouseMinID && aDestination <= CCHouseMaxID
EndFunction