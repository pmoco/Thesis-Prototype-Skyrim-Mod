;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname QF_ccBGSSSE001_MiscQuests_050009E6 Extends Quest Hidden

;BEGIN ALIAS PROPERTY BountyLetter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BountyLetter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Viriya
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Viriya Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Windhelm

; Now that the Morthal quest is complete, kick off Viriya's next main quest.
CrabMQ2.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(FalkreathQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Markarth (Dwarven)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(KhajiitQuest)

; This quest has objects in the world, so let's enable them now before
; the player reads the bounty letter.

KhajiitWorldObjectsEnableMarker.EnableNoWait()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; khajiiti
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(DwarvenQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(KhajiitQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(SolitudeQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Falkreath
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(MarkarthQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
; Solitude
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
; This quest requires text replacement on the bounty letter, so we need to fill the bounty letter
; alias in the quest itself instead of the misc quest handler.
WindhelmQuest.Start()

Actor player = Game.GetPlayer()
int questIndex = kmyQuest.MiscQuests.Find(WindhelmQuest)
ObjectReference letter = player.PlaceAtMe(kmyQuest.BountyLetters[questIndex])
WindhelmBountyLetter.ForceRefTo(letter)
player.AddItem(letter)

SetObjectiveCompleted(kmyQuest.AskObjective)
SetObjectiveDisplayed(kmyQuest.GetMiscQuestReadLetterObjective(questIndex))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(WhiterunQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(MorthalQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(MorthalQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(WhiterunQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Waiting for player to be able to accept Misc Quests
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(SolitudeQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(FalkreathQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Morthal
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GivePlayerBountyLetterForQuest(MarkarthQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(DwarvenQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Markarth (Lessons)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Whiterun
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN AUTOCAST TYPE ccBGSSSE001_MiscQuestScript
Quest __temp = self as Quest
ccBGSSSE001_MiscQuestScript kmyQuest = __temp as ccBGSSSE001_MiscQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetBountyLetterWasRead(WindhelmQuest)
WindhelmQuest.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Player finished all Misc Quests
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property WindhelmQuest  Auto  

Quest Property MorthalQuest  Auto  

Quest Property WhiterunQuest  Auto  

Quest Property FalkreathQuest  Auto  

Quest Property MarkarthQuest  Auto  

Quest Property KhajiitQuest  Auto  

Quest Property SolitudeQuest  Auto  

Quest Property DwarvenQuest  Auto  

ObjectReference Property KhajiitWorldObjectsEnableMarker  Auto  

ReferenceAlias Property WindhelmBountyLetter  Auto  

Quest Property CrabMQ2  Auto  
