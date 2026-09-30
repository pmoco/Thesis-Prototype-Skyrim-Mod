;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_PetFramework_ParentQuest_01002F1C Extends Quest Hidden

;BEGIN ALIAS PROPERTY WhiterunGates
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WhiterunGates Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerFalkreath
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerFalkreath Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerWindhelm
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerWindhelm Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerBreezehome
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerBreezehome Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BYOH03DoorHeljarchenHall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BYOH03DoorHeljarchenHall Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerProudspireManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerProudspireManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerWhiterun
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerWhiterun Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BYOH02DoorWindstadManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BYOH02DoorWindstadManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerLakeviewManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerLakeviewManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerHjerim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerHjerim Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerDawnstar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerDawnstar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerHoneyside
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerHoneyside Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerWinterhold
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerWinterhold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerRiften
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerRiften Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BYOH01DoorLakeviewManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BYOH01DoorLakeviewManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerSolitude
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerSolitude Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerWindstadManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerWindstadManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerDLC2SeverinManor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerDLC2SeverinManor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerMarkarth
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerMarkarth Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerHeljarchenHall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerHeljarchenHall Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DLC2SeverinManorEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DLC2SeverinManorEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerVlindrelHall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerVlindrelHall Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HomeMarkerCCHouse
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HomeMarkerCCHouse Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE PetFramework_ParentQuestScript
Quest __temp = self as Quest
PetFramework_ParentQuestScript kmyQuest = __temp as PetFramework_ParentQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.FillRefAliasesFromDLC()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
