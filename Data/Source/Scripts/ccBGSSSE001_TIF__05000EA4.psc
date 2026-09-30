;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__05000EA4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
Actor player = Game.GetPlayer()
player.AddItem(Gold001, QuestReward03Large.GetValueInt())

player.RemoveItem(AnglerLarvae, 1, true)
player.RemoveItem(Grayling, 1, true)
player.RemoveItem(Char, 1, true)
player.RemoveItem(Cod, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property QuestReward03Large  Auto  

MiscObject Property Gold001  Auto  

Ingredient Property AnglerLarvae  Auto  

Potion Property Grayling  Auto  

Potion Property Char  Auto  

Potion Property Cod  Auto  

Idle Property IdleGive  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  
