Scriptname ccBGSSSE025_CourierScript extends Quest  

ReferenceAlias property NoteGiver auto
ReferenceAlias property Note auto
Book property NoteForm auto
WICourierScript property CourierScript auto
float property TimeUntilCourier auto

function StartCourierTimer()
	RegisterForSingleUpdateGameTime(TimeUntilCourier)
endFunction

Event OnUpdateGameTime()
	ObjectReference myNote = NoteGiver.GetActorRef().PlaceAtMe(NoteForm)
	Note.ForceRefTo(myNote)
	CourierScript.AddItemToContainer(myNote)
endEvent