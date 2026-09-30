scriptname ccBGSSSE001_DwarvenColumnScript extends ObjectReference

float property targetZPos auto
ObjectReference property myWaterChurn auto
ObjectReference property myRealColumn auto
Sound property Rumble auto
Sound property Rumble2 auto
Sound property Rumble3 auto

int loopingSoundId

function Rise()
	loopingSoundId = Rumble.Play(self)
	Game.ShakeCamera()
	Game.ShakeController(0.5, 0.5, 2.0)
	
	Utility.Wait(0.25)
	myWaterChurn.Enable(true)

	Utility.Wait(0.25)
	Rumble2.Play(self)
	ObjectReference objectOnColumn = self.GetLinkedRef()
	float objectTargetZPos = (objectOnColumn.GetPositionZ() - self.GetPositionZ()) + targetZPos
	objectOnColumn.BlockActivation(true)
	
	self.TranslateTo(self.GetPositionX(), self.GetPositionY(), targetZPos, self.GetAngleX(), self.GetAngleY(), self.GetAngleZ(), 50.0)
	objectOnColumn.TranslateTo(objectOnColumn.GetPositionX(), objectOnColumn.GetPositionY(), objectTargetZPos, objectOnColumn.GetAngleX(), objectOnColumn.GetAngleY(), objectOnColumn.GetAngleZ(), 50.0)
	
	Utility.Wait(2)
	Rumble3.Play(self)
	Utility.Wait(2)
endFunction

Event OnTranslationComplete()
	EnableRealColumn()
endEvent

Event OnTranslationFailed()
	EnableRealColumn()
endEvent

function EnableRealColumn()
	myRealColumn.Enable()
	self.GetLinkedRef().DisableNoWait()
	self.DisableNoWait()

	Sound.StopInstance(loopingSoundId)

	Utility.Wait(0.5)
	myWaterChurn.Disable(true)
endFunction