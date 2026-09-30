;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname QF_ccBGSSSE001_Crab_MQ3_050009D6 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StallEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StallEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ3_Quest
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ3_Quest kmyQuest = __temp as ccBGSSSE001_CrabMQ3_Quest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartCourierTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveCompleted(10)
ItemCollectScript.DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ3_Quest
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ3_Quest kmyQuest = __temp as ccBGSSSE001_CrabMQ3_Quest
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
kmyQuest.StartMarketStallTimer()
Alias_Viriya.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
; Send the letter
ObjectReference myLetter = Alias_Viriya.GetActorRef().PlaceAtMe(ViriyaLetter)
Alias_Letter.ForceRefTo(myLetter)
CourierScript.AddItemToContainer(myLetter)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; Stall is built, make sure she's at the stall.
Alias_StallEnableMarker.GetRef().EnableNoWait()
Actor viriya = Alias_Viriya.GetActorRef()
viriya.EvaluatePackage()
viriya.AddItem(StallKey)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Viriya is at the stall, prompt player to visit
setObjectiveCompleted(30)
setObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
CompleteAllObjectives()

; Start street vendor behavior
Actor viriya = Alias_Viriya.GetActorRef()
viriya.AddToFaction(JobMerchantFaction)
viriya.AddToFaction(ccBGSSSE001_ServicesRiftenPlazaViriya)
viriya.EvaluatePackage()

; Allow the letter to be dropped (this quest does not stop, for dialogue purposes)
Alias_Letter.Clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property ViriyaLetter  Auto  

WICourierScript Property CourierScript  Auto  

Key Property Stallkey  Auto  

Faction Property ccBGSSSE001_ServicesRiftenPlazaViriya  Auto  

Faction Property JobMerchantFaction  Auto  

Actor Property PetCrab  Auto  

ccBGSSSE001_ItemCollectObjectiveScript property ItemCollectScript auto
