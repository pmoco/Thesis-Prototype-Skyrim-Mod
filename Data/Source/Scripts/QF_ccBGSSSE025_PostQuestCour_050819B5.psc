;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ccBGSSSE025_PostQuestCour_050819B5 Extends Quest Hidden

;BEGIN ALIAS PROPERTY NoteGiver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteGiver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Note
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Note Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ccBGSSSE025_CourierScript
Quest __temp = self as Quest
ccBGSSSE025_CourierScript kmyQuest = __temp as ccBGSSSE025_CourierScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartCourierTimer()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
