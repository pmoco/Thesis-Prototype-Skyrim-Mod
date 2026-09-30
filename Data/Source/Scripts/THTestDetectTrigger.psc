Scriptname THTestDetectTrigger extends ObjectReference  


int Property Intensity = 20  Auto

Actor[]  Property Enemies Auto




EVENT onActivate(objectReference actronaut)
	

	self.CreateDetectionEvent( Game.GetPlayer(), Intensity ) 

	
EndEvent 
