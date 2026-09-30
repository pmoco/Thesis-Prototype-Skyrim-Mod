;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE001_TIF__05000A68 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
Actor player = Game.GetPlayer()

akSpeaker.RemoveItem(UnplayableRod)
player.AddItem(ccBGSSSE001_FishingRodArgonianWeap)
player.AddItem(Gold001, 400)
ccBGSSSE001_CraftingUnlockedArgonian.Show()
ccBGSSSE001_CraftingUnlockedArgonianRod.SetValue(1)

player.RemoveItem(FishingHat, 1)
player.RemoveItem(Catfish, 1, true)
player.RemoveItem(PygmySunfish, 1, true)
player.RemoveItem(Pearlfish, 1, true)
player.RemoveItem(Spadefish, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property Catfish  Auto  

Ingredient Property PygmySunfish  Auto  

Ingredient Property Pearlfish  Auto  

Ingredient Property Spadefish  Auto  

Armor Property FishingHat  Auto  

WEAPON Property ccBGSSSE001_FishingRodArgonianWeap  Auto  

GlobalVariable Property ccBGSSSE001_CraftingUnlockedArgonianRod  Auto  

Message Property ccBGSSSE001_CraftingUnlockedArgonian  Auto  

Idle Property IdleGive  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  

WEAPON Property UnplayableRod  Auto  

MiscObject Property Gold001  Auto  
