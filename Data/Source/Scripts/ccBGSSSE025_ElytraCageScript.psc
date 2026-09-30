Scriptname ccBGSSSE025_ElytraCageScript extends ReferenceAlias  

Event OnLoad()
    Self.GetRef().Moveto(myCageMarker)
endEvent

ObjectReference Property myCageMarker Auto
