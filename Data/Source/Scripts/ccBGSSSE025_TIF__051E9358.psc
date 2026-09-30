;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE025_TIF__051E9358 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Grant reward
Game.GetPlayer().AddItem(Gold001, RewardAmount.GetValueInt())

;Complete Quest
GetOwningQuest().SetStage(2000)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RewardAmount  Auto  

MiscObject Property Gold001  Auto  
