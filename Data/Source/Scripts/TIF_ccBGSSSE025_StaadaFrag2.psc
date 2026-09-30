;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_ccBGSSSE025_StaadaFrag2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()
PlayerRef.RemoveItem(SwordOfJyggalag)
Staada.GetActorRef().RemoveItem(SaintHelmet)
PlayerRef.AddItem(StaadaHelmet)
akSpeaker.PlayIdle(IdleGive)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Staada  Auto  

Armor Property StaadaHelmet  Auto  

MiscObject Property OddAmber  Auto  

WEAPON Property SwordOfJyggalag  Auto  

Armor Property SaintHelmet  Auto  

Idle Property IdleGive  Auto  
