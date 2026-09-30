;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__05000EAC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
Actor player = Game.GetPlayer()
player.AddItem(Gold001, QuestReward04Wow.GetValueInt())

player.RemoveItem(GlassCatfish, 1, true)
player.RemoveItem(Direfish, 1, true)
player.RemoveItem(VampireFish, 1, true)
player.Removeitem(TripodFish, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property GlassCatfish  Auto  

Potion Property Direfish  Auto  

Potion Property TripodFish  Auto  

Potion Property VampireFish  Auto  

Idle Property IdleGive  Auto  

MiscObject Property Gold001  Auto  

GlobalVariable Property QuestReward04Wow  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  
