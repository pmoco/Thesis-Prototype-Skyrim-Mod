;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ccBGSSSE025_TIF__02000981 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Grant the player the quest note
Actor player = Game.GetPlayer()
ObjectReference note = player.PlaceAtMe(RisaadNote)
RisaadNoteAlias.ForceRefTo(note)
player.AddItem(note)

GetOwningQuest().SetStage(200)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property RiSaadNote  Auto  

ReferenceAlias Property RisaadNoteAlias  Auto  
