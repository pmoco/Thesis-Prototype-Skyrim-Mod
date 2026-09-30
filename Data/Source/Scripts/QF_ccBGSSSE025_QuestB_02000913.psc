;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname QF_ccBGSSSE025_QuestB_02000913 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Boss
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Boss Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BossBarrier
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BossBarrier Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ExploreRootCaveMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ExploreRootCaveMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ExploreSewersMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ExploreSewersMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jyggalag
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jyggalag Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Allow the player entrance to the dungeon
DungeonEntrance.Enable()

SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Ri'saad's note to the player
CourierQuest.Start()

; Staada quest
StaadaQuest.SetStage(11)

Actor playerRef = Game.GetPlayer()
shakeSound.Play(playerRef)

; Pacing.
Utility.Wait(1)

dustDropRef.Activate(playerRef)
Game.ShakeCamera(Alias_Jyggalag.GetRef(), 7.2, 3.8)
Game.ShakeController(0.6, 0.4, 3.8)

CompleteAllObjectives()

; Add more equipment to Ri'saad
BYOHLItemKhajiitCaravans.AddForm(ccBGSSSE025_LItemGSDSEquipment, 1, 1)
BYOHLItemKhajiitCaravans.AddForm(ccBGSSSE025_LItemOreAmber, 1, 1)
BYOHLItemKhajiitCaravans.AddForm(ccBGSSSE025_LItemOreMadness, 1, 1)

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ccBGSSSE025_BossControllerScript
Quest __temp = self as Quest
ccBGSSSE025_BossControllerScript kmyQuest = __temp as ccBGSSSE025_BossControllerScript
;END AUTOCAST
;BEGIN CODE
; The player entered the boss chamber.

SetObjectiveCompleted(30)
SetObjectiveDisplayed(40)

kmyQuest.OnBossEnterCombat()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE ccBGSSSE025_BossControllerScript
Quest __temp = self as Quest
ccBGSSSE025_BossControllerScript kmyQuest = __temp as ccBGSSSE025_BossControllerScript
;END AUTOCAST
;BEGIN CODE
; The boss is dead, deactivate the barrier.

SetObjectiveCompleted(40)
SetObjectiveDisplayed(50)

Alias_BossBarrier.GetRef().DisableNoWait()

kmyQuest.OnBossDeath()
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

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property DungeonEntrance  Auto  

LeveledItem Property ccBGSSSE025_LItemGSDSEquipment Auto

LeveledItem Property BYOHLItemKhajiitCaravans Auto

LeveledItem Property ccBGSSSE025_LItemOreMadness  Auto  

LeveledItem Property ccBGSSSE025_LItemOreAmber  Auto  

Quest Property CourierQuest  Auto  

Sound Property shakeSound  Auto  

ObjectReference Property dustDropRef  Auto  

Quest Property StaadaQuest  Auto  
