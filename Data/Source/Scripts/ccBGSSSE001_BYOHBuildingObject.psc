scriptname ccBGSSSE001_BYOHBuildingObject extends Form
{ Script that handles enabling Hearthfire upgrades when built. }

ccBGSSSE001_DLCDetectionScript property DLCDetection auto
{ The Fishing DLC Detection script. }
MiscObject property thisItem auto
{ This MiscItem. }

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor player = Game.GetPlayer()

	If akNewContainer == player && akOldContainer == None
		Location playerLoc = player.GetCurrentLocation()
		DLCDetection.BuildBYOHObject(playerLoc, playerLoc, thisItem)
	EndIf
EndEvent