;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF_ccBGSSSE001_Misc_Morthal_050009E4 Extends Quest Hidden

;BEGIN ALIAS PROPERTY FishingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FishingSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OldMan
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OldMan Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AmbushWizard2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AmbushWizard2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ContestLocationTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ContestLocationTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ContestLocation
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ContestLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Journal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Journal Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AmbushWizard1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AmbushWizard1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)

Alias_OldMan.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; One of the ambushers have died. Check quest advancement.

Actor oldMan = Alias_OldMan.GetActorRef()

; Did the player kill the old man early?
if oldMan.IsDead() && IsObjectiveDisplayed(15) && !IsObjectiveCompleted(15)
    SetObjectiveCompleted(15)
    SetStage(30)
endif

; Did the player defeat the ambush?
if oldMan.IsDead() && Alias_AmbushWizard1.GetActorRef().IsDead() && Alias_AmbushWizard2.GetActorRef().IsDead()
     SetStage(30)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
if !IsObjectiveCompleted(30)
    SetObjectiveCompleted(30)
endif

if IsObjectiveDisplayed(40)
    SetObjectiveCompleted(40)
endif

SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(0)
Actor oldMan = Alias_OldMan.GetActorRef()
oldMan.GetActorBase().SetProtected(true)
oldMan.SetCrimeFaction(None)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
AddJournalQuestItemToOldMan()

SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Player attacked the old man early.
if IsObjectiveDisplayed(0) && !IsObjectiveCompleted(0)
    SetObjectiveFailed(0)
endif

if IsObjectiveDisplayed(10) && !IsObjectiveCompleted(10)
    SetObjectiveFailed(10)
endif

Actor oldMan = Alias_OldMan.GetActorRef()
oldMan.GetActorBase().SetProtected(false)
oldMan.AddToFaction(PlayerEnemyFaction)

Alias_ContestLocationTrigger.GetRef().DisableNoWait()

; If the old man is at the waiting spot already, also start the ambush.
if GetStageDone(15)
    SetObjectiveDisplayed(20)
    StartAmbush()
else
    SetObjectiveDisplayed(15)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
if !GetStageDone(50)
    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(40)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
CompleteAllObjectives()
MiscQuests.SetQuestComplete(self)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
AddJournalQuestItemToOldMan()

SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)
StartAmbush()
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Brutius arrived at the fishing location.
Alias_ContestLocationTrigger.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property PlayerEnemyFaction  Auto  

SPELL Property Invisibility  Auto  

function StartAmbush()
    Actor oldMan = Alias_OldMan.GetActorRef()
    Actor wizard1 = Alias_AmbushWizard1.GetActorRef()
    Actor wizard2 = Alias_AmbushWizard2.GetActorRef()

    oldMan.AddToFaction(PlayerEnemyFaction)
    wizard1.AddToFaction(PlayerEnemyFaction)
    wizard2.AddToFaction(PlayerEnemyFaction)

    wizard1.Enable()
    Invisibility.Cast(wizard1, wizard1)
    wizard1.EvaluatePackage()

    wizard2.Enable()
    Invisibility.Cast(wizard2, wizard2)
    wizard2.EvaluatePackage()

    oldMan.GetActorBase().SetProtected(false)
    oldMan.StartCombat(Game.GetPlayer())
endFunction

Book Property Journal  Auto  

ccBGSSSE001_MiscQuestScript Property MiscQuests  Auto 

function AddJournalQuestItemToOldMan()
    Actor oldMan = Alias_OldMan.GetActorRef()
    ObjectReference theJournal = oldMan.PlaceAtMe(Journal)
    Alias_Journal.ForceRefTo(theJournal)
    oldMan.AddItem(theJournal)
endFunction
