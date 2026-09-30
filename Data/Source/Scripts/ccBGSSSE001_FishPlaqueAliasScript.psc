Scriptname ccBGSSSE001_FishPlaqueAliasScript extends ReferenceAlias  

ccBGSSSE001_FishPlaqueScript myPlaque

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	myPlaque.FishTaken(self.GetRef())
endEvent

function SetPlaque(ccBGSSSE001_FishPlaqueScript akPlaque)
	myPlaque = akPlaque
endFunction