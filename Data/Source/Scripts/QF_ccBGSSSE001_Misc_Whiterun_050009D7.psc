;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname QF_ccBGSSSE001_Misc_Whiterun_050009D7 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Note
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Note Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Child
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Child Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PetFishMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PetFishMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY chest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_chest Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
Actor player = Game.GetPlayer()
if player.GetItemCount(MilaNote) == 0
    ObjectReference note = player.PlaceAtMe(MilaNote)
    Alias_Note.ForceRefTo(note)
    player.AddItem(note)
endif
if player.GetItemCount(MilaKey) == 0
    player.AddItem(MilaKey)
endif
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
; Player read the letter
SetObjectiveCompleted(1000)
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Forcegreet player and reward them
Alias_Child.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
Alias_Child.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscWhiterunCourier
Quest __temp = self as Quest
ccBGSSSE001_MiscWhiterunCourier kmyQuest = __temp as ccBGSSSE001_MiscWhiterunCourier
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartCourierTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Player received the letter
SetObjectiveDisplayed(1000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Alias_Child.GetActorRef().EvaluatePackage()
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Mila is waiting at the trough
Alias_FollowTrigger.GetRef().EnableNoWait()
Alias_PetFishMarker.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
setObjectiveCompleted(40)
setObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Trigger placing the fish scene
SetObjectiveCompleted(30)
fishScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Topic Property PetReactionTopic  Auto  

Book Property MilaNote  Auto  

Key Property MilaKey  Auto  

Scene Property fishScene  Auto  

Ingredient Property Goldfish  Auto  

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto  
