;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_ccBGSSSE025_StaadaQuest_05198277 Extends Quest Hidden

;BEGIN ALIAS PROPERTY OddAmber
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OddAmber Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Staada
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Staada Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Player read the courier note
PlayerReadNoteGlobal.SetValueInt(1)
if (IsObjectiveDisplayed(0))
    SetObjectiveCompleted(0)
endif
If (!GetStageDone(200))
    SetObjectiveDisplayed(10)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Actor staadaRef = Alias_Staada.GetActorRef()
staadaRef.SetAV("Aggression", 2)
staadaRef.StartCombat(Game.GetPlayer())

if (IsObjectiveDisplayed(10) && !IsObjectiveCompleted(10))
    SetObjectiveFailed(10)
endif

if (IsObjectiveDisplayed(10) && !IsObjectiveCompleted(10))
    SetObjectiveCompleted(10)
endif

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Player got the courier note
if (!GetStageDone(200))
    SetObjectiveDisplayed(0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Player found Staada
CompleteAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Player finished talking to Staada and gave Amber or Sword
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Player picked up the amber OR picked up the Sword of Jyggalag
; If both have been done, add the note to the courier and enable Staada

if PlayerRef.GetItemCount(ccBGSSSE025_AmberOddity) > 0 && QuestB.IsCompleted()
    Alias_Staada.GetActorRef().Enable()
    CourierQuest.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; Player picked up the amber OR picked up the Sword of Jyggalag
; If both have been done, add the note to the courier and enable Staada

if PlayerRef.GetItemCount(ccBGSSSE025_AmberOddity) > 0 && QuestB.IsCompleted()
    Alias_Staada.GetActorRef().Enable()
    CourierQuest.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property CourierQuest  Auto  

GlobalVariable Property PlayerReadNoteGlobal  Auto  

Actor Property PlayerRef  Auto  

MiscObject Property ccBGSSSE025_AmberOddity  Auto  

Quest Property QuestB  Auto  
