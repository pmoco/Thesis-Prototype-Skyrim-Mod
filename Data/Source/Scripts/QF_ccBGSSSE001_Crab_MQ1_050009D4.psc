;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Crab_MQ1_050009D4 Extends Quest Hidden

;BEGIN ALIAS PROPERTY DeadAdventurer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DeadAdventurer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CrabCritter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CrabCritter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DeadAdventurerNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DeadAdventurerNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Note
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Note Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Alias_CrabCritter.GetRef().DisableNoWait()

CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(1001)
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Player read the bounty
SetObjectiveCompleted(1000)
SetObjectiveDisplayed(1001)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(1000)

; Enable the Juvenile Mudcrab critter.
Alias_CrabCritter.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Ingredient Property JuvenileMudcrab  Auto  

Actor Property PlayerRef  Auto  
