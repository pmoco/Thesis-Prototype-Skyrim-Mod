scriptName dunRaldbtharPuzzleGearBlockerScript extends objectReference

explosion property havokNudge auto

auto state waiting
	event onCellAttach()
		SetMotionType(4)
		self.Reset()
		self.setDestroyed(False)
	endEvent
	
	event onLoad()
		SetMotionType(4)
		self.Reset()
		self.setDestroyed(False)
	endEvent
	
	event onActivate(objectReference akActivator)
		objectReference myLinkedRef
		myLinkedRef = getLinkedRef()
		if myLinkedRef
			myLinkedRef.activate(self)
			SetMotionType(1)
			self.setDestroyed()
			if havokNudge
				self.placeAtMe(havokNudge)
			endIf
			goToState("Done")
		endif
	endEvent
endstate


state Done
endState

event onReset()
	self.Reset()
	SetMotionType(4)
	self.setDestroyed(False)
endEvent
