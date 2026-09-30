;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Radiant_1_05000B98 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Town
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Town Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ccBGSSSE001_RadiantFishQuest
Quest __temp = self as Quest
ccBGSSSE001_RadiantFishQuest kmyQuest = __temp as ccBGSSSE001_RadiantFishQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ShowQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
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

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
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
; The Innkeeper has died, fail the quest.
kmyQuest.FinishQuest(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
