;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Start_MQ2_050009DB Extends Quest Hidden

;BEGIN ALIAS PROPERTY Fishery
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Fishery Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SwimsInDeepWaters
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SwimsInDeepWaters Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
MiscQuestHandler.Start()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
CompleteAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property MiscQuestHandler  Auto
