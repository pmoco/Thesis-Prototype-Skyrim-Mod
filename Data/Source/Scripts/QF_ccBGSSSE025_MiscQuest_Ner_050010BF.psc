;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_ccBGSSSE025_MiscQuest_Ner_050010BF Extends Quest Hidden

;BEGIN ALIAS PROPERTY OfferTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OfferTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Journal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Journal Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BanditWithNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BanditWithNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BanditNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BanditNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nerveshatter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nerveshatter Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Player obtained Amber Ore
SetObjectiveCompleted(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Player has obtained Nerveshatter
SetObjectiveCompleted(40)
Stop()

; Spawn the two roaming bandits
Actor banditFirst = Alias_Bandit1.GetActorRef()
Actor banditSecond = Alias_Bandit2.GetActorRef()

banditFirst.EnableNoWait()
banditFirst.StartCombat(PlayerRef)
banditSecond.EnableNoWait()
banditSecond.StartCombat(PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Player obtained Madness Ore
SetObjectiveCompleted(21)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Player has both ores, place them near the resting location
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; Breadcrumb to the journal with more details
if GetStage() < 5
    SetObjectiveDisplayed(5)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Player placed the ore, cause Nerveshatter to appear
SetObjectiveCompleted(30)

Alias_OfferTrigger.GetRef().Disable()
PlayerRef.RemoveItem(AmberOre, 1, true)
PlayerRef.RemoveItem(MadnessOre, 1, true)
placedAmber.EnableNoWait()
placedMadness.EnableNoWait()

shakeSound.Play(PlayerRef)

; Pacing.
Utility.Wait(1)

SetObjectiveDisplayed(40)

ObjectReference nerveshatterRef = Alias_Nerveshatter.GetRef()
nerveshatterRef.Enable()

dustDropRef.Activate(PlayerRef)
Game.ShakeCamera(nerveshatterRef, 6.2, 3.8)
Game.ShakeController(0.6, 0.4, 3.8)

nerveshatterRef.PlaceAtMe(SummonFX)

if nerveshatterRef.Is3DLoaded()
	MGTeleportInEffect.Play(nerveshatterRef)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ccBGSSSE025_NerveshQuestScript
Quest __temp = self as Quest
ccBGSSSE025_NerveshQuestScript kmyQuest = __temp as ccBGSSSE025_NerveshQuestScript
;END AUTOCAST
;BEGIN CODE
; Player has found the journal near the shrine in Crystaldrift Cave

; Clear breadcrumbs
if IsObjectiveDisplayed(5)
    SetObjectiveCompleted(5)
endif
if IsObjectiveDisplayed(10)
    SetObjectiveCompleted(10)
endif

kmyQuest.countOre()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Player has found the journal leading to Crystaldrift Cave

; Clear breadcrumb
if IsObjectiveDisplayed(5)
    SetObjectiveCompleted(5)
endif

if GetStage() < 10
    SetObjectiveDisplayed(10)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef  Auto  

MiscObject Property AmberOre  Auto  

MiscObject Property MadnessOre  Auto  

ObjectReference Property placedAmber  Auto  

ObjectReference Property placedMadness  Auto  

EffectShader Property revealFX  Auto  

VisualEffect Property MGTeleportInEffect  Auto  

Sound Property shakeSound  Auto  

Activator Property SummonFX  Auto  

ObjectReference Property dustDropRef  Auto  
