;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Misc_Khajiit_050009E2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bottle2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bottle2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Risaad
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Risaad Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bottle1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bottle1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bottle3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bottle3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_Trigger.GetRef().Enable()
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Actor player = Game.GetPlayer()
player.RemoveItem(Alias_Bottle1.GetRef())
player.RemoveItem(Alias_Bottle2.GetRef(), abSilent = true)
player.RemoveItem(Alias_Bottle3.GetRef(), abSilent = true)
player.AddItem(RingOfKhajiit)

CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)

; Increase the size of Viriya's pet mudcrab
PetMudcrabMedium.DisableNoWait()
PetMudcrabLarge.EnableNoWait()

Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property RingOfKhajiit  Auto  

ccBGSSSE001_MiscQuestScript property MiscQuests auto

Actor Property PetMudcrabMedium  Auto  

Actor Property PetMudcrabLarge  Auto  
