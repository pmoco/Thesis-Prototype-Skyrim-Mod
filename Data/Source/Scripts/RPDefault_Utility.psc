Scriptname RPDefault_Utility

import RPDefault_Math

; ------------------------------
; PositionRelativeTo
;
; Description: Places an item positioned and rotated relative to another, based on a set of offset positions and angles
;
; Params:
; akMoveMe = ObjectReference that should be moved
; akRelativeTo = ObjectReference used to calculate relative positions/angles
; afOffsetPosition = array of exactly 3 entries, which should be the x/y/z offset from the position of akRelativeTo, for example, to place an item 100 units above, the array would be 0, 0, 100
; afOffsetAngle = array of exactly 3 entries, which should be the x/y/z offset from the rotation of akRelativeTo. For those of you more familiar with other terminology, x = Bank, Y = Heading, Z = Attitude
;
; Returns: ObjectReference of spawned item
; ------------------------------
Function PositionRelativeTo(ObjectReference akMoveMe, ObjectReference akRelativeTo, Float[] afOffsetPosition, Float[] afOffsetAngle) global
	Float[] fStartPos = new Float[3]
	fStartPos[0] = akRelativeTo.X
	fStartPos[1] = akRelativeTo.Y
	fStartPos[2] = akRelativeTo.Z
	
	Float[] fStartAngle = new Float[3]
	fStartAngle[0] = akRelativeTo.GetAngleX()
	fStartAngle[1] = akRelativeTo.GetAngleY()
	fStartAngle[2] = akRelativeTo.GetAngleZ()
	
	Float[] fNew3dData = GetOffset3dData(fStartPos, fStartAngle, afOffsetPosition, afOffsetAngle)
	
	akMoveMe.SetPosition(fNew3dData[0], fNew3dData[1], fNew3dData[2])
	akMoveMe.SetAngle(fNew3dData[3], fNew3dData[4], fNew3dData[5])
EndFunction


; ------------------------------
; PlaceInFrontOfMe
;
; Description: Spawns an item in front of the player a certain distance away. Can also place behind the player by using negative numbers for afDistance
;
; Params:
; akPlaceForm = Form to be placed
; akPlaceInFrontOf = ObjectReference to be placed in front of
; afDistance = Distance from akPlaceInFrontOf
; abFadeIn = If true, the new item will fade into existence after positioning, otherwise it will pop in
;
; Returns the newly placed ref
; ------------------------------
ObjectReference Function PlaceInFrontOfMe(Form akPlaceForm, ObjectReference akPlaceInFrontOf, Float afDistance, Bool abFadeIn = true) global
	ObjectReference kPlaceMe = akPlaceInFrontOf.PlaceAtMe(akPlaceForm, abInitiallyDisabled = true)
	
	MoveBehind(kPlaceMe, akPlaceInFrontOf, -afDistance)
	kPlaceMe.Enable(abFadeIn)
	
	return kPlaceMe
EndFunction


; ------------------------------
; MoveBehindPlayer
;
; Description: Moves an item behind the player a certain distance away. Can also place in front of the player by using negative numbers for afDistance
;
; Params:
; akMoveMe = ObjectReference that should be moved
; afDistance = Distance from the player
; ------------------------------
Function MoveBehindPlayer(ObjectReference akMoveMe, Float afDistance) global
	MoveBehind(akMoveMe, Game.GetPlayer(), afDistance)
EndFunction

; ------------------------------
; MoveBehind
;
; Description: Moves an item behind another a certain distance away. Can also place in front of the other item by using negative numbers for afDistance
;
; Params:
; akMoveMe = ObjectReference that should be moved
; akMoveBehindTarget = ObjectReference to move behind
; afDistance = Distance from akMoveBehindTarget
; ------------------------------
Function MoveBehind(ObjectReference akMoveMe, ObjectReference akMoveBehindTarget, Float afDistance) global
	ObjectReference[] kMoveRefs = new ObjectReference[1]
	kMoveRefs[0] = akMoveMe as ObjectReference

	MoveRefsBehind(kMoveRefs, akMoveBehindTarget, afDistance)
EndFunction

; ------------------------------
; MoveRefsBehindPlayer
;
; Description: Moves an array of items behind the player a certain distance away. Can also place in front of the player by using negative numbers for afDistance
;
; Params:
; akMoveMe = Array of ObjectReferences that should be moved
; afDistance = Distance from the player
; ------------------------------
Function MoveRefsBehindPlayer(ObjectReference[] akMoveMe, Float afDistance) global
	MoveRefsBehind(akMoveMe, Game.GetPlayer(), afDistance)
EndFunction


; ------------------------------
; MoveRefsBehind
;
; Description: Moves an an array of items behind another a certain distance away. Can also place in front of the other item by using negative numbers for afDistance
;
; Params:
; akMoveMe = Array of ObjectReference that should be moved
; akMoveBehindTarget = ObjectReference to move behind
; afDistance = Distance from akMoveBehindTarget
; ------------------------------
Function MoveRefsBehind(ObjectReference[] akMoveMe, ObjectReference akMoveBehindTarget, Float afDistance) global
	Float fPivotAngle = akMoveBehindTarget.GetAngleZ()
	Float fDistanceInFront = afDistance * -1.0 ; Negative = behind, Can send afDistance as a negative distance to move in front of akMoveBehindTarget
	Float fX = Math.Sin(fPivotAngle) * fDistanceInFront
	Float fY = Math.Cos(fPivotAngle) * fDistanceInFront
		
	int i = 0
	while(i < akMoveMe.Length)
		akMoveMe[i].MoveTo(akMoveBehindTarget, fX, fY)
		
		i += 1
	endWhile
EndFunction


; ------------------------------
; CreateAliasedItem
;
; Description: Spawns an item, puts in into an alias, and then optionally adds to inventory of target. 
;
; Params:
; aItemToAdd: Item to spawn, aObjectAlias: alias to put the spawned item in, akContainerOrActor: ObjectReference of container or actor to spawn this item at, abPutInInventory: Whether or not to add the item to the container/actor's inventory
;
; Returns: ObjectReference of spawned item
; ------------------------------

ObjectReference Function CreateAliasedItem(Form aItemToAdd, ReferenceAlias aObjectAlias, ObjectReference akContainerOrActor, Bool abPutInInventory = true) global
	ObjectReference kSpawnedRef = akContainerOrActor.PlaceAtMe(aItemToAdd, 1)
	if(kSpawnedRef)
		aObjectAlias.ForceRefTo(kSpawnedRef)
		
		if(abPutInInventory)
			akContainerOrActor.AddItem(kSpawnedRef)
		endif
	endif
	
	return kSpawnedRef
EndFunction



; ------------------------------
; WithinGameDateRange
;
; Description: Accepts a range of dates and returns wether aiMonthToCheck and aiDayToCheck are within that date range
;
; Params:
; aiMonthToCheck: 1 through 12, aiDayToCheck: 1 through 31, 
; aiStartMonth: 1 through 12, aiStartDay: 1 through 31, 
; aiEndMonth: 1 through 12, aiEndDay: 1 through 31
;
; ------------------------------

Bool Function WithinGameDateRange(Int aiMonthToCheck, Int aiDayToCheck, Int aiStartMonth, Int aiStartDay, Int aiEndMonth, Int aiEndDay) global
	if(aiEndMonth < aiStartMonth || (aiEndMonth == aiStartMonth && aiEndDay < aiStartDay))
		; Date happens across a year
		if((aiMonthToCheck >= aiStartMonth && (aiMonthToCheck > aiStartMonth || aiDayToCheck >= aiStartDay)) || (aiMonthToCheck <= aiEndMonth && (aiMonthToCheck < aiEndMonth || aiDayToCheck <= aiEndDay)))
			return true
		else
			return false
		endif
	else		
		if(aiMonthToCheck >= aiStartMonth && (aiMonthToCheck > aiStartMonth || aiDayToCheck >= aiStartDay) && aiMonthToCheck <= aiEndMonth && (aiMonthToCheck < aiEndMonth || aiDayToCheck <= aiEndDay))
			return true
		else
			return false
		endif
	endif
EndFunction
