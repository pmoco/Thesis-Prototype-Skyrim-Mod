;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname QF_ccBGSSSE001_Misc_Windhelm_050009D5 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Steward
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Steward Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ring
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ring Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OfferingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OfferingSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Fangtusk
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Fangtusk Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FishOffering
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishOffering Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
PlaceFishActRef.DisableNoWait()
Game.GetPlayer().RemoveItem(ArcticGrayling)
FishCollider.EnableNoWait()
Alias_FishOffering.GetRef().EnableNoWait()
SetObjectiveCompleted(10)
Utility.Wait(4)
Actor fangtusk = Alias_Fangtusk.GetActorRef()
fangtusk.Enable()
fangtusk.StartCombat(Game.GetPlayer())
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()

PlaceFishActRef.EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
setObjectiveCompleted(40)
setObjectiveDisplayed(50)
FishCollider.DisableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)

Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto 

ObjectReference Property FishCollider  Auto  

ObjectReference Property PlaceFishActRef  Auto  

Potion property ArcticGrayling auto
