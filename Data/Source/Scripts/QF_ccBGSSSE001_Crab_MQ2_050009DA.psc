;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_ccBGSSSE001_Crab_MQ2_050009DA Extends Quest Hidden

;BEGIN ALIAS PROPERTY Crab6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab8
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab8 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NecromancerClutterEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NecromancerClutterEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NecromancerJournal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NecromancerJournal Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BattleLocation
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BattleLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Note
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Note Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab10 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Necromancer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Necromancer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab7
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab7 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab9
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab9 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Crab12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Crab12 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
MiscQuests.SetObjectiveCompleted(2000)
SetObjectiveDisplayed(0)
; Add and fill the note alias.
ObjectReference theNote = PlayerRef.PlaceAtMe(Note)
Alias_Note.ForceRefTo(theNote)
PlayerRef.AddItem(theNote)

Alias_NecromancerClutterEnableMarker.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Player picked up the necromancer's journal
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabEncMonitor
Quest __temp = self as Quest
ccBGSSSE001_CrabEncMonitor kmyQuest = __temp as ccBGSSSE001_CrabEncMonitor
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(5)
kmyQuest.SpawnCrabs()
Utility.Wait(2)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
if IsObjectiveDisplayed(25)
    SetObjectiveCompleted(25)
endif
SetObjectiveCompleted(20)

if IsObjectiveCompleted(10)
    SetStage(50)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; The last bit of dialogue has been spoken, it's safe to stop the quest now.
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
ObjectReference player = Game.GetPlayer()
player.AddItem(AlikriFishingRod)
AlikriFishingRodCrafting.SetValueInt(1)
CraftingUnlockMessage.Show()
CompleteAllObjectives()
MiscQuests.SetObjectiveCompleted(2000, false)
MiscQuests.SetObjectiveDisplayed(2000, true, true)

; Enable the fisherman in the shack where the battle took place
ShackFisherman.EnableNoWait()

; Hide the necromancer clutter
Alias_NecromancerClutterEnableMarker.GetRef().DisableNoWait()

; Start Fish MQ3 if the player has reached the end of that quest
if ccBGSSSE001_Fish_MQ2.IsCompleted()
    ObjectReference courierNote = player.PlaceAtMe(ccBGSSSE001_SwimsNote2)
    courierAlias.ForceRefTo(courierNote)
    WICourier.AddItemToContainer(courierNote)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(10)

if !IsObjectiveCompleted(20)
    SetObjectiveDisplayed(20)
else
    SetStage(50)
endif

; Increase the size of Viriya's pet mudcrab
SmallPetMudcrab.DisableNoWait()
MediumPetMudcrab.EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property Note  Auto  

Actor Property PlayerRef  Auto  

WEAPON Property AlikriFishingRod  Auto  

GlobalVariable Property AlikriFishingRodCrafting  Auto  

Message Property CraftingUnlockMessage  Auto  

Quest Property ccBGSSSE001_Fish_MQ2  Auto  

WICourierScript Property WICourier  Auto  

Book Property ccBGSSSE001_SwimsNote2  Auto  

ReferenceAlias Property courierAlias  Auto  

Actor Property SmallPetMudcrab  Auto  

Actor Property MediumPetMudcrab  Auto  

Quest Property MiscQuests  Auto  

Actor Property ShackFisherman  Auto  
