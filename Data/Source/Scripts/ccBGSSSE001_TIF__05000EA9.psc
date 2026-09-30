;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__05000EA9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
Actor player = Game.GetPlayer()
player.AddItem(ccBGSSSE001_ArtifactArgonianDagger)

player.RemoveItem(Lyretail, 1, true)
player.RemoveItem(Angelfish, 1, true)
player.RemoveItem(Angler, 1, true)
player.RemoveItem(Scorpionfish, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property IdleGive  Auto  

Ingredient Property Angelfish  Auto  

Potion Property Angler  Auto  

Potion Property Scorpionfish  Auto  

Ingredient Property Lyretail  Auto  

WEAPON Property ccBGSSSE001_ArtifactArgonianDagger  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  
