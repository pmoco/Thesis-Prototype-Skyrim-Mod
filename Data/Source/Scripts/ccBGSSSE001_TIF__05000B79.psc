;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname ccBGSSSE001_TIF__05000B79 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.GetPlayer()
if GavePlayerPoleGlobal.GetValueInt() == 1 && player.GetItemCount(FishingPole) > 0
    GavePlayerPoleGlobal.SetValueInt(0)
    player.RemoveItem(FishingPole)
    akSpeaker.AddItem(FishingPole)
    akSpeaker.EquipItem(FishingPole)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property GavePlayerPoleGlobal  Auto  

WEAPON Property FishingPole  Auto  
