Scriptname ThesisInitExperimentScript extends ReferenceAlias  

ThesisPlayerLoadout  Property LoadoutManager Auto 

ThesisLoggerScript Property Logger Auto

; Teleport target
ObjectReference Property TestMarker Auto
ThesisRoomController Property RoomController Auto

bool HasInit = False 


Event OnInit()
  
 
  InitStandards() 


EndEvent 



Function InitStandards() 

   if HasInit 
      return
   endIf 

   HasInit = true

   Logger.Log("Initializing the thesis Mod", "", true)

   ; Optional: clear UI states
   Game.DisablePlayerControls(  abMovement = false, abFighting = false,  abCamSwitch = true, abLooking = false,  abSneaking = false, abMenu = True,  abActivate = false ) 

   Game.ForceFirstPerson()
   

   ;minimal UI
   Game.SetHUDCartMode(true) 

   ;Level up lock
   ;Game.SetGameSettingInt("iLevelUpSkillCount", 999999)

   LoadOutManager.LoadEquipment()

  

   Actor p = Game.GetPlayer()



	Utility.wait(0.2)


    ObjectReference initMap =  RoomController.GetNextRoom()
    p.MoveTo(initMap )

   Logger.Log("Player Moved into the Cell ", "", true)
	
   Utility.Wait(2.0) 

  ; Logger.Log("RoomOrder "+ RoomController.FinalArrayToString() + "____Current index "+RoomController.GetCurrentIndex()  , False)

   Logger.Log("I====EXPERIMENT START=====l", "", False)

EndFunction 