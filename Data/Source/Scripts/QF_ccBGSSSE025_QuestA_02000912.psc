;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname QF_ccBGSSSE025_QuestA_02000912 Extends Quest Hidden

;BEGIN ALIAS PROPERTY SeducersCampBandit03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersCampBandit03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersBanditCampChest1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersBanditCampChest1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsBanditLeaderNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsBanditLeaderNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersCampBandit02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersCampBandit02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RiSaadNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RiSaadNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsCampBandit02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsCampBandit02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsCampBandit03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsCampBandit03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsCampBanditWithNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsCampBanditWithNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsBanditCamp1ObjectiveMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsBanditCamp1ObjectiveMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsCampBanditNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsCampBanditNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsCampBandit04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsCampBandit04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersBanditLeader
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersBanditLeader Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsBanditLeader
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsBanditLeader Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Risaad
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Risaad Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersCampBanditWithNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersCampBanditWithNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersCampBandit04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersCampBandit04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersCampBanditNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersCampBanditNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersBanditCamp2ObjectiveMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersBanditCamp2ObjectiveMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersBanditCamp1ObjectiveMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersBanditCamp1ObjectiveMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsBanditCampChest1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsBanditCampChest1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SeducersBanditLeaderNote
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SeducersBanditLeaderNote Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaintsBanditCamp2ObjectiveMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaintsBanditCamp2ObjectiveMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
PlayerTalkedToRisaad.SetValueInt(1)
SetObjectiveCompleted(0)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
if IsObjectiveDisplayed(21)
    SetObjectiveCompleted(21)
endif
SetObjectiveDisplayed(31)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
setObjectiveCompleted(70)
if IsObjectiveDisplayed(75)
    setObjectiveCompleted(75)
endif

; The player now knows that the conjurer is somewhere in Solitude.
ccBGSSSE025_PlayerKnowsSolitudeLocation.SetValueInt(1)

; If necessary, start the second quest.
if !ccBGSSSE025_QuestB.IsRunning()
    ccBGSSSE025_QuestB.Start()
endif

; If the player has both pieces of information, pop the final objective.
if ccBGSSSE025_PlayerKnowsSolitudeLocation.GetValueInt() == 1 && ccBGSSSE025_PlayerKnowsSewerLocation.GetValueInt() == 1
    SetStage(900)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveCompleted(40)
if !GetStageDone(430)
    SetObjectiveDisplayed(45)
endif

; Enable the ritual site
if SaintsCamp2EnableMarker.IsDisabled()
    SaintsCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
if IsObjectiveDisplayed(20)
    SetObjectiveCompleted(20)
endif
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
SetObjectiveCompleted(40)
if IsObjectiveDisplayed(45)
    SetObjectiveCompleted(45)
endif
if !GetStageDone(440)
    SetObjectiveDisplayed(50)
endif

; The player has now learned about the bandit groups
ccBGSSSE025_PlayerKnowsAboutBandits.SetValueInt(1)

; Enable the ritual site
if SaintsCamp2EnableMarker.IsDisabled()
    SaintsCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)

if (!GetStageDone(400))
    SetObjectiveDisplayed(20)
endif

if (!GetStageDone(500))
    SetObjectiveDisplayed(21)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
setObjectiveCompleted(70)
if !GetStageDone(460)
    setObjectiveDisplayed(75)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveCompleted(30)
if !GetStageDone(425)
    setObjectiveDisplayed(40)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
if IsObjectiveDisplayed(50)
    SetObjectiveCompleted(50)
endif
SetObjectiveDisplayed(60)

; Put out the fire at the previous campsite, has an "off" variant set as an enable opposite of parent at same location
SaintsCampCampfire.Disable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
setObjectiveCompleted(71)
if IsObjectiveDisplayed(76)
    setObjectiveCompleted(76)
endif

; The player now knows that the conjurer is somewhere in a sewer.
ccBGSSSE025_PlayerKnowsSewerLocation.SetValueInt(1)

; If necessary, start the second quest.
if !ccBGSSSE025_QuestB.IsRunning()
    ccBGSSSE025_QuestB.Start()
endif

; If the player has both pieces of information, pop the final objective.
if ccBGSSSE025_PlayerKnowsSolitudeLocation.GetValueInt() == 1 && ccBGSSSE025_PlayerKnowsSewerLocation.GetValueInt() == 1
    SetStage(900)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveCompleted(31)
if !GetStageDone(525)
    SetObjectiveDisplayed(41)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
setObjectiveCompleted(71)
if !GetStageDone(560)
    setObjectiveDisplayed(76)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
CompleteAllObjectives()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
setObjectiveCompleted(41)
if !GetStageDone(530)
    setObjectiveDisplayed(46)
endif

; Enable the ritual site
if SeducersCamp2EnableMarker.IsDisabled()
    SeducersCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
setObjectiveCompleted(41)
if IsObjectiveDisplayed(46)
    SetObjectiveCompleted(46)
endif
if !GetStageDone(540)
    SetObjectiveDisplayed(51)
endif

; The player has now learned about the bandit groups
ccBGSSSE025_PlayerKnowsAboutBandits.SetValueInt(1)

; Enable the ritual site
if SeducersCamp2EnableMarker.IsDisabled()
    SeducersCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
setObjectiveCompleted(41)
if IsObjectiveDisplayed(46)
    SetObjectiveCompleted(46)
endif
if !GetStageDone(540)
    SetObjectiveDisplayed(51)
endif

; Enable the ritual site
if SeducersCamp2EnableMarker.IsDisabled()
    SeducersCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
SetObjectiveCompleted(30)
if !GetStageDone(425)
    setObjectiveDisplayed(40)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveCompleted(40)
if IsObjectiveDisplayed(45)
    SetObjectiveCompleted(45)
endif
if !GetStageDone(440)
    SetObjectiveDisplayed(50)
endif

; Enable the ritual site
if SaintsCamp2EnableMarker.IsDisabled()
    SaintsCamp2EnableMarker.EnableNoWait()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveCompleted(60)
setObjectiveDisplayed(70)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
if IsObjectiveDisplayed(20)
    SetObjectiveCompleted(20)
endif
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
setObjectiveCompleted(61)
setObjectiveDisplayed(71)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
if IsObjectiveDisplayed(21)
    SetObjectiveCompleted(21)
endif
SetObjectiveDisplayed(31)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE


; Add perks
Actor PlayerRef = Game.GetPlayer()
PlayerRef.AddPerk(ccBGSSSE025_Smithing)
PlayerRef.AddPerk(ccBGSSSE040_MatchingSet)
PlayerRef.AddPerk(ccBGSSSE040_MatchingSetHeavy)

; Add new books
BYOHLItemKhajiitCaravans.AddForm(ccBGSSSE025_LItemAllBooks, 1, 1)
LItemBook4All.AddForm(ccBGSSSE025_LItemAllBooks, 1, 1)

; --- Add Atronach Forge Recipes
; Staada Tome
AtrFrgRecipes.AddForm(StaadaAtrFrgRecipe)
AtrFrgResults.AddForm(StaadaTome)
; Staada Scroll
AtrFrgRecipes.AddForm(StaadaAtrForgeRecipeScroll)
AtrFrgResults.AddForm(StaadaScroll)
; Staada Hostile
AtrFrgRecipes.AddForm(StaadaAtrForgeRecipeHostile)
AtrFrgResults.AddForm(HostileStaada)
; Golden Saint Tome
AtrFrgRecipes.AddForm(GSAtrForgeRecipeTome)
AtrFrgResults.AddForm(GSTome)
; Golden Saint Scroll
AtrFrgRecipes.AddForm(GSAtrForgeRecipeScroll)
AtrFrgResults.AddForm(GSScroll)
; Golden Saint Hostile
AtrFrgRecipes.AddForm(GSAtrForgeRecipeHostile)
AtrFrgResults.AddForm(HostileGS)
; Dark Seducer Tome
AtrFrgRecipes.AddForm(DSAtrForgeRecipeTome)
AtrFrgResults.AddForm(DSTome)
; Dark Seducer Scroll
AtrFrgRecipes.AddForm(DSAtrForgeRecipeScroll)
AtrFrgResults.AddForm(DSScroll)
; Dark Seducer Hostile
AtrFrgRecipes.AddForm(DSAtrForgeRecipeHostile)
AtrFrgResults.AddForm(HostileDS)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
if IsObjectiveDisplayed(51)
    SetObjectiveCompleted(51)
endif
SetObjectiveDisplayed(61)

; Put out the fire at the previous campsite, has an "off" variant set as an enable opposite of parent at same location
SeducersCampCampfire.Disable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
if PlayerTalkedToRisaad.GetValueInt() == 1
    SetObjectiveDisplayed(80)
else
    SetObjectiveDisplayed(81)
endif

; Grant the player access to the Solitude Sewers
ccBGSSSE025_QuestB.SetStage(10)

; Kick off the Player Hunt WI quest
SaintsHuntPlayerQuest.Start()
SeducersHuntPlayerQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveCompleted(31)
if !GetStageDone(525)
    SetObjectiveDisplayed(41)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property ccBGSSSE025_PlayerKnowsAboutBandits  Auto  

ObjectReference Property SaintsCamp2EnableMarker  Auto  

ObjectReference Property SeducersCamp2EnableMarker  Auto  

ObjectReference Property SaintsCampCampfire  Auto  

ObjectReference Property SeducersCampCampfire  Auto  

GlobalVariable Property ccBGSSSE025_PlayerKnowsSolitudeLocation  Auto  

Quest Property ccBGSSSE025_QuestB  Auto  

GlobalVariable Property ccBGSSSE025_PlayerKnowsSewerLocation  Auto  

LeveledItem Property BYOHLItemKhajiitCaravans  Auto  

LeveledItem Property ccBGSSSE025_LItemAllBooks  Auto  

LeveledItem Property LItemBook4All  Auto  

FormList Property AtrFrgResults  Auto  

FormList Property AtrFrgRecipes  Auto  

FormList Property StaadaAtrFrgRecipe  Auto  

Book Property StaadaTome  Auto  

FormList Property StaadaAtrForgeRecipeScroll  Auto  

FormList Property StaadaAtrForgeRecipeHostile  Auto  

FormList Property GSAtrForgeRecipeTome  Auto  

FormList Property GSAtrForgeRecipeScroll  Auto  

FormList Property GSAtrForgeRecipeHostile  Auto  

FormList Property DSAtrForgeRecipeTome  Auto  

FormList Property DSAtrForgeRecipeScroll  Auto  

FormList Property DSAtrForgeRecipeHostile  Auto  

ActorBase Property HostileStaada  Auto  

ActorBase Property HostileGS  Auto  

ActorBase Property HostileDS  Auto  

LeveledItem Property GSTome  Auto  

LeveledItem Property DSTome  Auto  

LeveledItem Property GSScroll  Auto  

LeveledItem Property DSScroll  Auto  

Scroll Property StaadaScroll  Auto  

GlobalVariable Property PlayerTalkedToRisaad  Auto  

Perk Property ccBGSSSE040_MatchingSet  Auto  

Perk Property ccBGSSSE040_MatchingSetHeavy  Auto  

Perk Property ccBGSSSE025_Smithing  Auto  

Quest Property SaintsHuntPlayerQuest  Auto  

Quest Property SeducersHuntPlayerQuest  Auto  
