Scriptname ThesisSneakLogger extends Quest

ThesisLoggerScript Property Logger Auto

float Property UpdateInterval = 0.25 Auto
String Property Prefix = "[SNEAK]" Auto

bool Property StartOnInit = False Auto
bool Property  WriteToScreen = False  Auto


bool WasSneaking = false

float SneakStartTime = 0.0
float TotalSneakTime = 0.0


BOOL loggin = false

Event OnInit()
	
 	if  !StartOnInit 
		return
	endIf
	loggin= true 
    	WasSneaking = Game.GetPlayer().IsSneaking()

   	 if WasSneaking
        	SneakStartTime = Utility.GetCurrentRealTime()
    	endif

    	RegisterForSingleUpdate(UpdateInterval)

EndEvent



Function StartLogging() 

   WasSneaking = Game.GetPlayer().IsSneaking()

    if WasSneaking
        SneakStartTime = Utility.GetCurrentRealTime()
    endif

    RegisterForSingleUpdate(UpdateInterval)

EndFunction

Function EndLogging() 
	
	
	WasSneaking = false
	Float duration = Utility.GetCurrentRealTime() - SneakStartTime
	TotalSneakTime += duration

	Logger.Log("Exited Sneak | Duration = " + duration + " s | Total = " + TotalSneakTime + " s",     "{SNEAK}" , writeToScreen)		
	Logger.Log("Exited Sneak No More Logging  ||||||||||||||||||||||||||||||||||" , writeToScreen)		
	loggin = true

EndFunction 


Event OnUpdate()
	

	if (  loggin == false )
		return
	endif 

    bool isSneaking = Game.GetPlayer().IsSneaking()

    ; Player started sneaking
    if isSneaking && !WasSneaking

        WasSneaking = true
        SneakStartTime = Utility.GetCurrentRealTime()

        Logger.Log("Entered Sneak [start]  "+  SneakStartTime + "  [Total]  "+ TotalSneakTime, "{SNEAK}" ,  writeToScreen)

    ; Player stopped sneaking
    elseif !isSneaking && WasSneaking

        	WasSneaking = false
		float duration = Utility.GetCurrentRealTime() - SneakStartTime
		TotalSneakTime += duration

		Logger.Log("Exited Sneak | Duration = " + duration + " s | Total = " + TotalSneakTime + " s",     "{SNEAK}" , writeToScreen)	
    endif
	
    RegisterForSingleUpdate(UpdateInterval)

EndEvent