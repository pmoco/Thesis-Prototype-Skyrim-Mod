;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ccBGSSSE001_TIF__050009BC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(IdleGive)
getowningquest().setstage(200)
PlayerRef.AddItem(Gold001, QuestReward01Small.GetValueInt())
if PlayerRef.GetItemCount(RiftenFisheryKey) == 0
    PlayerRef.AddItem(RiftenFisheryKey)
endif
PlayerRef.AddToFaction(RiftenFisheryFaction)
PlayerRef.RemoveItem(JuvenileMudcrab)

; Enable Misc quest chain
MiscQuests.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
 

Actor Property PlayerRef  Auto  

GlobalVariable Property QuestReward01Small  Auto  

MiscObject Property Gold001  Auto  

Ingredient Property JuvenileMudcrab  Auto  

Quest Property MiscQuests  Auto  

Key Property RiftenFisheryKey  Auto  

Idle Property IdleGive  Auto  

Faction Property RiftenFisheryFaction  Auto  
