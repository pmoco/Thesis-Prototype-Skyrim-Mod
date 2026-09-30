;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ccBGSSSE025_ElytraPetAcqu_050010C3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ElytraMania
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ElytraMania Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintContainer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintContainer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CageDoor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CageDoor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ManiaKey
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ManiaKey Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(10)

; Pacing.
Utility.Wait(1.9)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Game.GetPlayer().AddSpell(PetSummonSpell)
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property PetSummonSpell  Auto  
