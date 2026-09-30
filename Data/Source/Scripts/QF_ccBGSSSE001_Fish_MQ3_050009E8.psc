;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ccBGSSSE001_Fish_MQ3_050009E8 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Guide
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guide Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SwimsInDeepWaters
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SwimsInDeepWaters Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY list
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_list Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierNote Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Add the fish to the fish tank
fishTank.AddFish(AnglerLarvae, 1)
fishTank.UpdateFish()

CompleteAllObjectives()
nextQuest.Start()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveCompleted(75)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
if !GetStageDone(10)
    SetObjectiveDisplayed(4)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
if IsObjectiveDisplayed(4)
    SetObjectiveCompleted(4)
    SetObjectiveDisplayed(6)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Wait for the player to exit the letter.
Utility.Wait(0.1)

SetObjectiveCompleted(100)
SetObjectiveDisplayed(75)
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
if !GetStageDone(6)
    WICourier.RemoveRefFromContainer(Alias_CourierNote.GetRef())
endif

if IsObjectiveDisplayed(4) && !IsObjectiveCompleted(4)
    SetObjectiveDisplayed(4, false)
endif

Actor player = Game.GetPlayer()
ObjectReference theList = player.PlaceAtMe(FishList)
Alias_List.ForceRefTo(theList)
player.AddItem(theList)

Alias_Guide.GetRef().EnableNoWait()
SetObjectiveCompleted(6)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property NextQuest  Auto  

WICourierScript Property WICourier  Auto  

Book Property fishList  Auto  

ccBGSSSE001_FishTankContainerScript property fishTank auto
Ingredient Property AnglerLarvae  Auto  
