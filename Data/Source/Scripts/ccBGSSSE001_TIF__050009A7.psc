;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__050009A7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
Actor player = Game.GetPlayer()
player.AddItem(Gold001, QuestReward.GetValueInt())
if player.GetItemCount(RiftenFisheryKey) == 0
    player.AddItem(RiftenFisheryKey)
endif
player.AddToFaction(RiftenFisheryFaction)
player.RemoveItem(Pogfish, 1, true)
player.RemoveItem(Carp, 1, true)
player.RemoveItem(Glassfish, 1, true)
player.RemoveItem(Goldfish, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Pogfish  Auto  

Potion Property Carp  Auto  

Ingredient Property Glassfish  Auto  

Ingredient Property Goldfish  Auto  

GlobalVariable Property QuestReward  Auto  

MiscObject Property Gold001  Auto  

Idle Property IdleGive  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  

Key Property RiftenFisheryKey  Auto  

Faction Property RiftenFisheryFaction  Auto  
