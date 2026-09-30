;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_ccBGSSSE025_ElytraPetAcqu_050010C0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY DementiaKey
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DementiaKey Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducerBandit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducerBandit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducerCageDoor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducerCageDoor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ElytraDementia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ElytraDementia Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.GetPlayer().AddSpell(PetSummonSpell)
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(10)

; Pacing.
Utility.Wait(1.9)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property PetSummonSpell  Auto
