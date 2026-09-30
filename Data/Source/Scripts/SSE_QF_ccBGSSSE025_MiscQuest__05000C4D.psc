;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SSE_QF_ccBGSSSE025_MiscQuest__05000C4D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Madness
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Madness Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ArcaneBlacksmith
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ArcaneBlacksmith Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Amber
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Amber Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Journal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Journal Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Inspect Evethra
SetObjectiveCompleted(15)
SetObjectiveDisplayed(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Find Evethra
SetObjectiveDisplayed(10)

; Enable the camp and encounter
EnableMarker.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Read Journal
SetObjectiveCompleted(18)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Kill Evethra
SetObjectiveCompleted(10)
SetObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
LitemSpecialLoot100.AddForm(ccBGSSSE025_LItemAmberMadnessOre, 1, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LeveledItem Property LItemSpecialLoot100  Auto  

LeveledItem Property ccBGSSSE025_LItemAmberMadnessOre  Auto  

LeveledItem Property LItemLootIMineralsProcessed  Auto  

ObjectReference Property enableMarker  Auto  
