;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ccBGSSSE001_Radiant_3_05000C8C Extends Quest Hidden

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Town
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Town Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Steward
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Steward Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyLetter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantJunkQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantJunkQuest kmyQuest = __temp as ccBGSSSE001_RadiantJunkQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShowQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantJunkQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantJunkQuest kmyQuest = __temp as ccBGSSSE001_RadiantJunkQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.FinishQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantJunkQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantJunkQuest kmyQuest = __temp as ccBGSSSE001_RadiantJunkQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUpQuest()
kmyQuest.GivePlayerBountyLetter()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
