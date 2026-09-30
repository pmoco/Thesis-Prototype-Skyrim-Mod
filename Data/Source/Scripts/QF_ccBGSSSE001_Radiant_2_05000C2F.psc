;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_ccBGSSSE001_Radiant_2_05000C2F Extends Quest Hidden

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Alchemist
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Alchemist Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Town
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Town Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantFishQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantFishQuest kmyQuest = __temp as ccBGSSSE001_RadiantFishQuest
;END AUTOCAST
;BEGIN CODE
; The Innkeeper has died, fail the quest.
kmyQuest.FinishQuest(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantFishQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantFishQuest kmyQuest = __temp as ccBGSSSE001_RadiantFishQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShowQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantFishQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantFishQuest kmyQuest = __temp as ccBGSSSE001_RadiantFishQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.FinishQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantFishQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantFishQuest kmyQuest = __temp as ccBGSSSE001_RadiantFishQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUpQuest()
kmyQuest.GivePlayerBountyLetter()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
