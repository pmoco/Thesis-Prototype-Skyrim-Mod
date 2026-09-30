;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_ccBGSSSE001_Misc_Solitude_050009E3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY MealLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MealLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Reward
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Reward Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DinnerGuest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DinnerGuest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FeastTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FeastTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChairDinnerGuest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChairDinnerGuest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FeastEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FeastEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY plate
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_plate Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierLetter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Alias_FeastEnableMarker.GetRef().Disable()

Alias_Reward.GetRef().EnableNoWait()
Alias_MealLetter.GetRef().EnableNoWait()
Alias_DinnerGuest.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(30)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Courier has delivered the letter
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Alias_FeastTrigger.GetRef().DisableNoWait()

Actor player = Game.GetPlayer()
int listLength = FoodList.GetSize()

int i = 0
while i < listLength
    player.RemoveItem(FoodList.GetAt(i), abSilent = true)
    i += 1
endWhile

Alias_FeastEnableMarker.GetRef().Enable()
SetObjectiveCompleted(50)

; Have the dinner guest come up the stairs.
Actor dinnerGuest = Alias_DinnerGuest.GetActorRef()
dinnerGuest.MoveTo(WarpMarker)
dinnerGuest.EvaluatePackage()
SetObjectiveDisplayed(29)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_FeastTrigger.GetRef().EnableNoWait()
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ccBGSSSE001_Quest_SetStageAfterTimer
Quest __temp = self as Quest
ccBGSSSE001_Quest_SetStageAfterTimer kmyQuest = __temp as ccBGSSSE001_Quest_SetStageAfterTimer
;END AUTOCAST
;BEGIN CODE
CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)
kMyQuest.StartWaitTimer(24.0, 250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Send the letter
Book SongLetter
int playerGender = Game.GetPlayer().GetActorBase().GetSex()
if playerGender == 0 ; Male
    SongLetter = FishingSongMale
elseif playerGender == 1 ; Female
    SongLetter = FishingSongFemale
endif
ObjectReference myLetter = Alias_DinnerGuest.GetActorRef().PlaceAtMe(SongLetter)
Alias_CourierLetter.ForceRefTo(myLetter)
CourierScript.AddItemToContainer(myLetter)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE ccBGSSSE001_Quest_SetStageAfterTimer
Quest __temp = self as Quest
ccBGSSSE001_Quest_SetStageAfterTimer kmyQuest = __temp as ccBGSSSE001_Quest_SetStageAfterTimer
;END AUTOCAST
;BEGIN CODE
kMyQuest.StartWaitTimer(1.0, 40)
SetObjectiveCompleted(29)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FormList Property FoodList  Auto  

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto 

ObjectReference Property WarpMarker  Auto  

Book Property FishingSongMale  Auto  

Book Property FishingSongFemale  Auto  

WICourierScript Property CourierScript  Auto  
