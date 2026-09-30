;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname QF_ccBGSSSE001_Misc_Dwarven_05000AD6 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Spider1Ambush2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Spider1Ambush2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishermanJournal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishermanJournal Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Axe
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Axe Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Spider1Ambush1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Spider1Ambush1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Stairs
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Stairs Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingSpot1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Core1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Core1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishermanJournalMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishermanJournalMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SchematicMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SchematicMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ColumnChest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ColumnChest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Calcelmo
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Calcelmo Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Core2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Core2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY chest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_chest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY steam
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_steam Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Schematic
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Schematic Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DynamoHolder2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DynamoHolder2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Axe02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Axe02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DynamoHolder1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DynamoHolder1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingSpot2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CaveInvestigateMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CaveInvestigateMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(0)
CaveQuestTrigger.EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Core1SetGlobal.SetValueInt(1)

if ModObjectiveGlobal(1.0, coresLeftGlobal, 50, coresTotalGlobal.GetValue())
    SetStage(300)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE ccBGSSSE001_Quest_SetStageAfterTimer
Quest __temp = self as Quest
ccBGSSSE001_Quest_SetStageAfterTimer kmyQuest = __temp as ccBGSSSE001_Quest_SetStageAfterTimer
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(18)
SetObjectiveDisplayed(20)
kMyQuest.StartWaitTimer(24.0, 40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(50, abForce = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
setObjectiveCompleted(25)
SetObjectiveDisplayed(28)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Core2SetGlobal.SetValueInt(1)

if ModObjectiveGlobal(1.0, coresLeftGlobal, 50, coresTotalGlobal.GetValue())
    SetStage(300)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(50, abForce = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ObjectReference steam = Alias_Steam.GetRef()
steam.Enable(true)

RevealMusic.Add()
Alias_Stairs.GetRef().PlayAnimation("Raise")
(Alias_ColumnChest.GetRef() as ccBGSSSE001_DwarvenColumnScript).Rise()

Utility.Wait(3)
CompleteAllObjectives()
MiscQuests.SetQuestComplete(self, false)
steam.Disable(true)

; Spawn the ambush
Actor player = Game.GetPlayer()
Alias_Spider1Ambush1.GetRef().Activate(player)
Alias_Spider1Ambush2.GetRef().Activate(player)

; Allow the player to remove the dynamos.
(Alias_DynamoHolder1.GetRef() as ccBGSSSE001_DynamoTriggerScript).AllowItemRemoval()
(Alias_DynamoHolder2.GetRef() as ccBGSSSE001_DynamoTriggerScript).AllowItemRemoval()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveCompleted(15)
SetObjectiveDisplayed(18)

; Kick off Viriya's next main quest in parallel with this one.
CrabMQ4.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveCompleted(10)
setObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
; The player picked up one of the 2 reward axes.
CraftingUnlockMessage.Show()
CraftingUnlockGlobal.SetValueInt(1)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property ccBGSSSE001_MDDLeft  Auto  

GlobalVariable Property ccBGSSSE001_MDDTotal  Auto  

MusicType Property RevealMusic  Auto  

GlobalVariable Property CoresCaughtGlobal  Auto  

MiscObject Property DynamoCore  Auto  

ObjectReference Property CaveQuestTrigger  Auto  

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto 

GlobalVariable Property coresLeftGlobal  Auto  

GlobalVariable Property coresTotalGlobal  Auto  

GlobalVariable Property Core1SetGlobal  Auto  

GlobalVariable Property Core2SetGlobal  Auto  

Quest Property CrabMQ4 Auto  

Message Property CraftingUnlockMessage  Auto  

GlobalVariable Property CraftingUnlockGlobal  Auto  
