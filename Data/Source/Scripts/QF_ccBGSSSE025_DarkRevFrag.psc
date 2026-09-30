;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname QF_ccBGSSSE025_DarkRevFrag Extends Quest Hidden

;BEGIN ALIAS PROPERTY Thug2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Victim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Victim Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Attacker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Attacker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thug1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Location
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Location Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Thug3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Thug3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ccBGSSSE025_WIKillScript
Quest __temp = self as Quest
ccBGSSSE025_WIKillScript kmyQuest = __temp as ccBGSSSE025_WIKillScript
;END AUTOCAST
;BEGIN CODE
kmyquest.SetNextEventGlobals()		;lives in parent script WorldInteractionsScript
Alias_Thug1.TryToDisable()
Alias_Thug2.TryToDisable()
Alias_Thug3.TryToDisable()
Alias_Thug1.GetReference().AddItem(Alias_Letter1.GetReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
