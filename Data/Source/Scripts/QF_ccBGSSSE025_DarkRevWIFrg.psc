;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ccBGSSSE025_DarkRevWIFrg Extends Quest Hidden

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thug2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thug1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thug3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TravelMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TravelMarker1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
Actor thug1Ref = Alias_Thug1.GetActorRef()
Actor thug2Ref = Alias_Thug2.GetActorRef()
Actor thug3Ref = Alias_Thug3.GetActorRef()

thug1Ref.MoveTo(Alias_TravelMarker1.GetReference())
thug2Ref.MoveTo(Alias_TravelMarker1.GetReference())
thug3Ref.MoveTo(Alias_TravelMarker1.GetReference())
thug1Ref.Enable()
thug2Ref.Enable()
thug3Ref.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
