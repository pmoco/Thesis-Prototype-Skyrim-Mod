Scriptname Thesis_Detection  extends Quest


ThesisLoggerScript PROPERTY Logger Auto

Event OnInit() 

	Logger.Notify("QuestStarted") 
    	RegisterForSingleUpdate(0.5)
EndEvent 


Event OnUpdate() 

	Logger.Notify("Im alive") 
	RegisterForSingleUpdate(2)

EndEvent 