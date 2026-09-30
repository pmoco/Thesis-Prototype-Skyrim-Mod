;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname QF_ccBGSSSE001_Misc_Falkreat_050009EC Extends Quest Hidden

;BEGIN ALIAS PROPERTY Note
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Note Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Potion
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Potion Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Zaria
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Zaria Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardSceneTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardSceneTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
Game.GetPlayer().AddItem(ArtifactRing)

SetObjectiveCompleted(60)
MiscQuests.SetQuestComplete(self)

; Enable the small pet mudcrab for Viriya
SmallPetMudcrab.EnableNoWait()

(Alias_Guard as ccBGSSSE001_DeleteOnQuestDone).DeleteIfUnloaded() ; Also stops the quest
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Game.GetPlayer().AddItem(ArtifactRing)

SetObjectiveCompleted(61)
MiscQuests.SetQuestComplete(self)

; Enable the small pet mudcrab for Viriya
SmallPetMudcrab.EnableNoWait()

(Alias_Guard as ccBGSSSE001_DeleteOnQuestDone).DeleteIfUnloaded() ; Also stops the quest
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
setObjectiveCompleted(40)
setObjectiveDisplayed(50)

Alias_Guard.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
; Guard is done panicking
Alias_Guard.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Actor player = Game.GetPlayer()
ObjectReference skooma = player.PlaceAtMe(ZariaPotion)
Alias_Potion.ForceRefTo(skooma)
player.AddItem(skooma)

SetObjectiveCompleted(30)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Guard waiting for player to arrive
Alias_GuardSceneTrigger.GetRef().EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
if IsObjectiveDisplayed(30) && !IsObjectiveCompleted(30)
    SetObjectiveFailed(40)
endif

if IsObjectiveDisplayed(40) && !IsObjectiveCompleted(40)
    SetObjectiveFailed(40)
endif

if IsObjectiveDisplayed(50) && !IsObjectiveCompleted(50)
    SetObjectiveFailed(50)
endif

if IsObjectiveDisplayed(60) && !IsObjectiveCompleted(60)
    SetObjectiveFailed(60)
endif

SetObjectiveDisplayed(61)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)

ActorBase guardBase = Alias_Guard.GetActorRef().GetActorBase()
guardBase.SetProtected(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()

ActorBase guardBase = Alias_Guard.GetActorRef().GetActorBase()
guardBase.SetEssential(true)

Actor guard = Alias_Guard.GetActorRef()
guard.Enable()
guard.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
; Guard invisibility potion scene
SetObjectiveCompleted(50)

Actor guard = Alias_Guard.GetActorRef()
guard.Say(AddictLine)

Utility.Wait(1)
guard.PlayIdle(DrinkPotion)
Utility.Wait(3)

Invisibility.Cast(guard, guard)
SetStage(70)
guard.EvaluatePackage()
(Alias_Guard as ccBGSSSE001_GuardPanicScript).StartPanicking()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Actor player = Game.GetPlayer()
ObjectReference note = player.PlaceAtMe(ZariaNote)
Alias_Note.ForceRefTo(note)
player.AddItem(Gold001, 200)
player.AddItem(note)

SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property ZariaNote  Auto  

Potion Property ZariaPotion  Auto  

Armor Property ArtifactRing  Auto  

Topic Property AddictLine  Auto  

Idle Property DrinkPotion  Auto  

SPELL Property Invisibility  Auto  

ccBGSSSE001_MiscQuestScript property MiscQuests auto

MiscObject Property Gold001  Auto  

Actor Property SmallPetMudcrab  Auto  
