;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF_ccBGSSSE001_Misc_Markarth_050009DF Extends Quest Hidden

;BEGIN ALIAS PROPERTY FishingLocation
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingLocationTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingLocationTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Student
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Student Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Lynea arrived at the fishing location.
Alias_FishingLocationTrigger.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Actor player = Game.GetPlayer()
player.AddItem(Amulet)
Actor student = Alias_Student.GetActorRef()
student.SetOutfit(NoAmuletOutfit)
student.SetRelationshipRank(player, 4)
student.AddToFaction(PotentialMarriageFaction)
student.GetActorBase().SetEssential(false)
student.EvaluatePackage()
CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Player arrived at the fishing location while Lynea was there.
SetObjectiveCompleted(10)
Alias_Student.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Lynea forcegreeted player.
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)

; Have Lynea go to the new waiting location
SetStage(27)
Alias_Student.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; All fish have been caught
SetObjectiveDisplayed(40)
Alias_Student.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)

Actor student = Alias_Student.GetActorRef()
if student.GetItemCount(SteelDagger) > 0
    student.RemoveItem(SteelDagger)
endif
student.AddItem(PracticeRod)
student.EquipItem(PracticeRod)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

WEAPON Property PracticeRod  Auto  

Armor Property Amulet  Auto  

Topic Property Comment1  Auto  

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto 

WEAPON Property SteelDagger  Auto  

Outfit Property NoAmuletOutfit  Auto  

Faction Property PotentialMarriageFaction  Auto  
