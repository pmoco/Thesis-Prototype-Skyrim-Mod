;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ccBGSSSE001_TIF__050C1D0F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
GetOwningQuest().SetStage(210)
Actor player = Game.GetPlayer()

akSpeaker.RemoveItem(UnplayableRod)
player.AddItem(ccBGSSSE001_FishingRodArgonianWeap)
ccBGSSSE001_CraftingUnlockedArgonian.Show()
ccBGSSSE001_CraftingUnlockedArgonianRod.SetValue(1)

player.RemoveItem(Catfish, 1, true)
player.RemoveItem(PygmySunfish, 1, true)
player.RemoveItem(Pearlfish, 1, true)
player.RemoveItem(Spadefish, 1, true)
ccBGSSSE001_ItemsRemovedMsg.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property IdleGive  Auto  

WEAPON Property UnplayableRod  Auto  

WEAPON Property ccBGSSSE001_FishingRodArgonianWeap  Auto  

Message Property ccBGSSSE001_CraftingUnlockedArgonian  Auto  

GlobalVariable Property ccBGSSSE001_CraftingUnlockedArgonianRod  Auto  

Potion Property Catfish  Auto  

Ingredient Property PygmySunfish  Auto  

Ingredient Property Pearlfish  Auto  

Ingredient Property Spadefish  Auto  

Message Property ccBGSSSE001_ItemsRemovedMsg  Auto  
