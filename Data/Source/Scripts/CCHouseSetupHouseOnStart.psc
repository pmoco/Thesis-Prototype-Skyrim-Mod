scriptname CCHouseSetupHouseOnStart extends Quest
{ Sets up a new Creation Club house on startup. }

int property HouseID auto
{ The House ID. Valid range: 101 - 120. }

ObjectReference property HouseCenterMarker auto
{ The house center marker reference. }

Location property HouseInteriorLocation auto
{ The house interior location. }

Location property HouseExteriorLocation auto
{ The house exterior location. }

CCHouseQuestScript property CCHouse auto
{ The Creation Club House Quest as CCHouseQuestScript. }

bool property StartsOwned = false auto
{ If True, the house starts as "owned" by the player. }

bool property StartsWithChildBedroom = false auto
{ If True, the house starts with a bed for adopted children. }

event OnInit()
	CCHouse.SetHouseData(HouseID, HouseCenterMarker, HouseInteriorLocation, HouseExteriorLocation)

	if StartsOwned
		CCHouse.SetHouseOwned(HouseID)
	endif

	if StartsWithChildBedroom
		CCHouse.SetHasChildBedroom(HouseID)
	endif
endEvent
