;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ccBGSSSE001_Misc_Whiterun_05000E5D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Child
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Child Auto
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

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
Alias_Child.GetActorRef().EvaluatePackage()

CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)
Stop()

; Start the next quest in the chain
nextQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
Alias_Child.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Forcegreet player and reward them
SetObjectiveCompleted(30)
Alias_Child.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Mila is waiting at the trough
Alias_FollowTrigger.GetRef().EnableNoWait()
Alias_PetFishMarker.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto  

Quest Property NextQuest  Auto  
