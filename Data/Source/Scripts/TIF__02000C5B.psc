;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__02000C5B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Force the Home Marker Alias for CC Houses to the selected house center marker.
HomeMarkerCCHouse.ForceRefTo(CCHouse.CCHouseMarkers[1])
(akSpeaker as PetFramework_PetScript).SetNewHome(HomeMarkerCCHouse, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

CCHouseQuestScript property CCHouse  Auto
ReferenceAlias Property HomeMarkerCCHouse  Auto  
