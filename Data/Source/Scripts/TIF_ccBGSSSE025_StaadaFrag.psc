;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_ccBGSSSE025_StaadaFrag Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()
PlayerRef.RemoveItem(OddAmber)
Staada.GetActorRef().RemoveItem(SaintHelmet)
PlayerRef.AddItem(StaadaHelmet)
akSpeaker.PlayIdle(IdleGive)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property StaadaHelmet  Auto  

ReferenceAlias Property Staada  Auto  

MiscObject Property OddAmber  Auto  

Armor Property SaintHelmet  Auto  

Idle Property IdleGive  Auto  
