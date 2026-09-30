Scriptname ccBGSSSE001_SandboxFollowerScript extends ReferenceAlias  

ReferenceAlias property SandboxMarker auto

function SetFollowerIdleWhenFishing()
	ObjectReference myMarker = SandboxMarker.GetRef()
	Actor mySelf = self.GetActorRef()
	if myMarker && mySelf
		mySelf.MoveTo(myMarker)
		mySelf.EvaluatePackage()
	endif
endFunction