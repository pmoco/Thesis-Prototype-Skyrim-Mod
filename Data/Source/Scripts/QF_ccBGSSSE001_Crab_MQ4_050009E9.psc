;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 21
Scriptname QF_ccBGSSSE001_Crab_MQ4_050009E9 Extends Quest Hidden

;BEGIN ALIAS PROPERTY FlamingPotCrab3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FlamingPotCrab3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Phase2Trigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Phase2Trigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FlamingPotCrab1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FlamingPotCrab1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GhostEmperorCrabGuardTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GhostEmperorCrabGuardTarget Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultController2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultController2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FlamingPotCrab2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FlamingPotCrab2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GhostEmperorCrab
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GhostEmperorCrab Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SetDressingEnableMarkerPhase2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SetDressingEnableMarkerPhase2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BattleSiteMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BattleSiteMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultTrigger2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultTrigger2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardEnableMarkerImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardEnableMarkerImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WoundedGuard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WoundedGuard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FlamingPotCrab5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FlamingPotCrab5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SetDressingEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SetDressingEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BattleApproachTrigger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BattleApproachTrigger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultController1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultController1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RegroupMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RegroupMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LocalFisherman
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LocalFisherman Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultTrigger4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultTrigger4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultTrigger3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultTrigger3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FlamingPotCrab4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FlamingPotCrab4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CatapultTrigger1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultTrigger1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardEnableMarkerSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardEnableMarkerSons Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
;Player spoke to Viriya, crab roars and destroys the wagon.
OilWagon.DisableNoWait()

Actor playerRef = Game.GetPlayer()
ObjectReference giantCrab = Alias_GhostEmperorCrab.GetRef()
Alias_SetDressingEnableMarkerPhase2.GetRef().Enable()
Alias_Phase2Trigger.GetRef().Enable()

; Should also play Ambush Exit SFX on enable
giantCrab.Enable(true)

Utility.Wait(1.0)
Actor viriya = Alias_Viriya.GetActorRef()
viriya.Say(ViriyaSurpriseTopic)
Utility.Wait(1.0)
int id2 = ShakeSound.Play(playerRef)
Game.ShakeCamera(afStrength = 0.4, afDuration = 3.0)
Game.ShakeController(0.5, 0.5, 2.5)
viriya.PlayIdle(StaggerIdle)
ShackDustDrop.EnableNoWait()

Utility.Wait(2.0)
Game.EnablePlayerControls()

kmyQuest.SetWave(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
; Get ready for wave 2!
SetObjectiveCompleted(15)
SetObjectiveDisplayed(25)
kmyQuest.SetWave(2)

; Make the guards take their defensive positions again.
int i = 0
while i < guardAliases.Length
    Actor guardRef = guardAliases[i].GetActorRef()
    if !guardRef.IsDead()
        guardRef.EvaluatePackage()
    endif
    i += 1
endWhile

Actor viriya = Alias_Viriya.GetActorRef()
viriya.RestoreActorValue("Health", 1000.0)
viriya.EvaluatePackage()

; "Hold the line!"
Utility.Wait(2)
Alias_Guard1.GetActorRef().Say(HoldTheLineTopic)

Utility.Wait(10)

SetStage(215)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
; "Push them back!"
Alias_Guard1.GetActorRef().Say(PushBackTopic)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
BattleZone.SetAndPlayBossMusic()
Utility.Wait(0.5)

kmyQuest.SpawnInitialCrabs()

Alias_Viriya.GetActorRef().EvaluatePackage()

Utility.Wait(2.5)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Send the letter
ObjectReference myLetter = Alias_Viriya.GetActorRef().PlaceAtMe(ViriyaLetter)
Alias_Letter.ForceRefTo(myLetter)
CourierScript.AddItemToContainer(myLetter)

; Enable the battle site in case the player goes there first
Alias_BattleApproachTrigger.GetRef().EnableNoWait()
BattleZone.EnableNoWait()
OilWagon.EnableNoWait()
Alias_SetDressingEnableMarker.GetRef().EnableNoWait()

; Enable the correct guards based on the current civil war status, and fill the
; appropriate aliases.
Actor[] guardArray
if Alias_Jarl.GetActorRef() == SkaldTheElderREF
    ; Stormcloaks
    Reinforcements.SetCivilWarSide(abIsImperial = false)
    Alias_GuardEnableMarkerSons.GetRef().EnableNoWait()
    Alias_WoundedGuard.ForceRefTo(SonsWoundedGuard)
    guardArray = SonsGuards
elseif Alias_Jarl.GetActorRef() == BrinaMerilisREF
    ; Imperial
    Reinforcements.SetCivilWarSide(abIsImperial = true)
    Alias_GuardEnableMarkerImperial.GetRef().EnableNoWait()
    Alias_WoundedGuard.ForceRefTo(ImperialWoundedGuard)
    guardArray = ImperialGuards
endif

int i = 0
while i < guardArray.Length
    GuardAliases[i].ForceRefTo(guardArray[i])
    guardArray[i].EvaluatePackage()

    ; The first guard is Essential. The rest are Protected until the fight begins.
    if i == 0
        guardArray[i].GetLeveledActorBase().SetEssential()
    else
        guardArray[i].GetLeveledActorBase().SetProtected()
    endif
    i += 1
endWhile

; Move the fisherman inside the shack and have him die from his wounds.
Actor localFisherman = Alias_LocalFisherman.GetActorRef()
if localFisherman
    localFisherman.MoveTo(WoundedFishermanMarker)
    localFisherman.Kill()
endif

; Disable Snippy for now.
PetCrab.DisableNoWait()

Actor viriya = Alias_Viriya.GetActorRef()
viriya.SetOutfit(ViriyaCombatOutfit)
viriya.AddItem(ImperialBow)
viriya.AddItem(SteelArrow)
viriya.AddItem(SteelSword)
viriya.EquipItem(ImperialBow)
viriya.MoveTo(ViriyaMarkerBattleStart)
viriya.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
; If the player went straight to the battle site before receiving the letter,
; stop the courier.
if !GetStageDone(50)
    CourierScript.RemoveRefFromContainer(Alias_Letter.GetRef())
endif

if IsObjectiveDisplayed(10)
    SetObjectiveCompleted(10)
endif
SetObjectiveDisplayed(15)

; Now that the fight has begun, the guards are the player's allies.
; Only keep one of the guards as essential.
int i = 0
while i < guardAliases.Length
    Actor guardRef = guardAliases[i].GetActorRef()
    guardRef.IgnoreFriendlyHits()
    guardRef.SetPlayerTeammate()
    if i >= 1
        guardRef.GetLeveledActorBase().SetProtected(false)
    endif
    i += 1
endWhile

; Viriya is the player's teammate.
Actor viriya = Alias_Viriya.GetActorRef()
viriya.AddToFaction(CrabMQ4GuardFaction)
viriya.SetPlayerTeammate()
viriya.IgnoreFriendlyHits()

; Get hype
Alias_Guard1.GetActorRef().Say(HereTheyComeTopic)

; Begin the first wave.
kmyQuest.SpawnInitialCrabs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Viriya is waiting inside the shack.
RegroupTrigger.EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Player received the letter

SetObjectiveDisplayed(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
(Alias_CatapultController1.GetRef() as ccBGSSSE001_CatapultCtrlScript).SetStateDisabled()
(Alias_CatapultController2.GetRef() as ccBGSSSE001_CatapultCtrlScript).SetStateDisabled()

; Player hit the crab enough times with the catapults, play death animation.
(Alias_GhostEmperorCrab.GetRef() as ccBGSSSE001_CrabMQ4CrabCtrlr).KillEmperorCrabGuardian()

BattleZone.RemoveZone()

; Have the guards mop up the remaining crabs
CrabMQ4GuardFaction.SetReaction(CrabMQ4FlamingPotCrabFaction, 1)

; The guards can stop firing at the crab.
int i = 0
while i < guardAliases.Length
    guardAliases[i].GetActorRef().EvaluatePackage()
    i += 1
endWhile

Alias_Viriya.GetActorRef().RestoreActorValue("Health", 1000.0)

Utility.Wait(5)

; Time to talk to Viriya
SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveCompleted(18)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
setObjectiveCompleted(25)
SetObjectiveDisplayed(15, abForce = true)
Alias_Guard1.GetActorRef().Say(TakeThemTopic)
kmyQuest.SpawnInitialCrabs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Actor player = Game.GetPlayer()
player.AddItem(Gold001, QuestRewardGlobal.GetValueInt())
CompleteAllObjectives()

Alias_Viriya.GetActorRef().SetOutfit(ViriyaNormalOutfit)

; The guards can now be removed.
int i = 0
while i < guardAliases.Length
    Actor guardRef = guardAliases[i].GetActorRef()
    if !guardRef.IsDead()
        guardRef.DisableNoWait()
        guardRef.Delete()
    endif
    i += 1
endWhile

Alias_GuardEnableMarkerSons.GetRef().DisableNoWait()
Alias_GuardEnableMarkerImperial.GetRef().DisableNoWait()

; Disable the battle site
OilWagon.DisableNoWait()
Alias_SetDressingEnableMarker.GetRef().DisableNoWait()
Alias_SetDressingEnableMarkerPhase2.GetRef().DisableNoWait()

; The outside of the crab shack now has new crab meat barrels.
ShackCrabMeatBarrelRef.EnableNoWait()

CrabMQ3.Start()

; Snippy can return!
PetCrab.EnableNoWait()

; Enable the crab in the tank at the Riften Fishery
tankCrabRef.EnableNoWait()

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(100)

; Viriya returns to Riften
Alias_Viriya.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
BattleZone.SetAndPlayNoMusic()

; Send Viriya to the shack.
Actor viriya = Alias_Viriya.GetActorRef()
viriya.RestoreActorValue("Health", 1000.0)
viriya.EvaluatePackage()

SetObjectiveCompleted(15)
SetObjectiveDisplayed(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE ccBGSSSE001_CrabMQ4CrabSpawner
Quest __temp = self as Quest
ccBGSSSE001_CrabMQ4CrabSpawner kmyQuest = __temp as ccBGSSSE001_CrabMQ4CrabSpawner
;END AUTOCAST
;BEGIN CODE
; CRAB BATTLE QUICKSTART

Alias_BattleApproachTrigger.GetRef().DisableNoWait()
kmyQuest.SetWave(3)
BattleZone.SetAndPlayBossMusic()
BattleZone.EnableNoWait()
Alias_SetDressingEnableMarker.GetRef().Enable()
ObjectReference giantCrab = Alias_GhostEmperorCrab.GetRef()
Alias_SetDressingEnableMarkerPhase2.GetRef().Enable()
Alias_Phase2Trigger.GetRef().Enable()
giantCrab.Enable(true)

Actor[] guardArray
if Alias_Jarl.GetActorRef() == SkaldTheElderREF
    ; Stormcloaks
    Reinforcements.SetCivilWarSide(abIsImperial = false)
    Alias_GuardEnableMarkerSons.GetRef().Enable()
    Alias_WoundedGuard.ForceRefTo(SonsWoundedGuard)
    guardArray = SonsGuards
elseif Alias_Jarl.GetActorRef() == BrinaMerilisREF
    ; Imperial
    Reinforcements.SetCivilWarSide(abIsImperial = true)
    Alias_GuardEnableMarkerImperial.GetRef().Enable()
    Alias_WoundedGuard.ForceRefTo(ImperialWoundedGuard)
    guardArray = ImperialGuards
endif

int i = 0
while i < guardArray.Length
    GuardAliases[i].ForceRefTo(guardArray[i])
    guardArray[i].EvaluatePackage()
    guardArray[i].IgnoreFriendlyHits()
    guardArray[i].SetPlayerTeammate()

    ; The first guard is Essential.
    if i == 0
        guardArray[i].GetLeveledActorBase().SetEssential()
    endif
    i += 1
endWhile

; Force the wounded guard and fisherman to use the wounded furniture.
Alias_WoundedGuard.GetActorRef().EvaluatePackage()
Alias_LocalFisherman.GetActorRef().EvaluatePackage()

; Disable Snippy for now.
PetCrab.DisableNoWait()

Actor viriya = Alias_Viriya.GetActorRef()
viriya.SetOutfit(ViriyaCombatOutfit)
viriya.AddItem(ImperialBow)
viriya.AddItem(SteelArrow)
viriya.AddItem(SteelSword)
viriya.EquipItem(ImperialBow)
viriya.MoveTo(ViriyaMarkerBattleStart)
viriya.EvaluatePackage()

; Viriya is the player's teammate.
viriya.AddToFaction(CrabMQ4GuardFaction)
viriya.SetPlayerTeammate()
viriya.IgnoreFriendlyHits()

SetStage(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(50)
Reinforcements.SetShouldSpawnReinforcements(false)

; Clear guard teammate status.
int i = 0
while i < guardAliases.Length
    Actor guardRef = guardAliases[i].GetActorRef()
    if !guardRef.IsDead()
        ActorBase guardRefBase = guardRef.GetLeveledActorBase()
        guardRefBase.SetEssential(false)
        guardRefBase.SetProtected(false)
        guardRef.SetPlayerTeammate(false)
        guardRef.IgnoreFriendlyHits(false)
        guardRef.SetActorValue("Aggression", 0)
    endif
    i += 1
endWhile

; Clear Viriya combat status
Actor viriya = Alias_Viriya.GetActorRef()
viriya.RemoveFromFaction(CrabMQ4GuardFaction)
viriya.SetPlayerTeammate(false)
viriya.IgnoreFriendlyHits(false)
viriya.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property SkaldTheElderREF  Auto  

Actor Property BrinaMerilisREF  Auto  

ReferenceAlias[] Property GuardAliases  Auto  

Actor[] Property SonsGuards  Auto  

Actor[] Property ImperialGuards  Auto  

Actor Property SonsWoundedGuard  Auto  

Actor Property ImperialWoundedGuard  Auto  

Outfit Property ViriyaCombatOutfit  Auto  

ObjectReference Property ViriyaMarkerBattleStart  Auto  

WEAPON Property ImperialBow  Auto  

Ammo Property SteelArrow  Auto  

WEAPON Property SteelSword  Auto  

ObjectReference Property ShackDustDrop  Auto  

ObjectReference Property RegroupTrigger  Auto  

ObjectReference Property OilWagon  Auto  

MiscObject Property FlamingPot  Auto 

Book Property ViriyaLetter  Auto  

WICourierScript Property CourierScript  Auto  

Quest Property CrabMQ3  Auto  

Actor Property PetCrab  Auto  

ObjectReference Property tankCrabRef  Auto  

ObjectReference Property ShackCrabMeatBarrelRef  Auto  

Sound Property ShakeSound  Auto  

Idle Property StaggerIdle  Auto  

Topic Property HereTheyComeTopic  Auto  

Topic Property HoldTheLineTopic  Auto  

Topic Property RegroupTopic  Auto  

Topic Property TakeThemTopic  Auto  

Topic Property PushBackTopic  Auto  

Topic Property ViriyaSurpriseTopic  Auto  

ccBGSSSE001_CrabMQ4Reinforcements property Reinforcements auto

MiscObject Property Gold001  Auto  

GlobalVariable Property QuestRewardGlobal  Auto  

Faction Property CrabMQ4GuardFaction  Auto  

Faction Property CrabMQ4FlamingPotCrabFaction  Auto  

ccBGSSSE001_CrabMQ4BattleZoneScript property BattleZone auto

Outfit Property ViriyaNormalOutfit  Auto  

ObjectReference Property WoundedFishermanMarker  Auto  
