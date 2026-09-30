;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ccBGSSSE001_TIF__05000AEF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()
PlayerRef.AddItem(DwarvenFishingRod)
CraftingGlobal.SetValueInt(1)
CraftingMessage.Show()
GetOwningQuest().SetStage(90)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

WEAPON Property DwarvenFishingRod  Auto  

Message Property CraftingMessage  Auto  

GlobalVariable Property CraftingGlobal  Auto  
