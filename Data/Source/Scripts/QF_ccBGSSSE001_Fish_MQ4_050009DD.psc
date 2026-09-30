;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Fish_MQ4_050009DD Extends Quest Hidden

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

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveCompleted(75)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Actor player = Game.GetPlayer()
ObjectReference theList = player.PlaceAtMe(FishList)
Alias_List.ForceRefTo(theList)
player.AddItem(theList)

Alias_Guide.GetRef().EnableNoWait()
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
CompleteAllObjectives()
nextQuest.Start()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Wait for the player to exit the letter.
Utility.Wait(0.1)

SetObjectiveCompleted(100)
SetObjectiveDisplayed(75)
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property fishList  Auto  

Quest Property NextQuest  Auto  
