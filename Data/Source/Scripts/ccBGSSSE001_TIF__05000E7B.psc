;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__05000E7B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.GetPlayer()
ObjectReference theNote = player.PlaceAtMe(MudcrabNote)
NoteAlias.ForceRefTo(theNote)
player.AddItem(theNote)
GetOwningQuest().SetStage(10)
MQ02Quest.SetObjectiveCompleted(10)

; Finish up Start_MQ2 if necessary
if MQ02Quest.IsObjectiveCompleted(20)
    MQ02Quest.SetStage(200)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property MQ02Quest  Auto  

Book Property MudcrabNote  Auto  

ReferenceAlias Property NoteAlias  Auto  
