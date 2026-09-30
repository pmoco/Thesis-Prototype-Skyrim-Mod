;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_ccBGSSSE001_Fish_MQ2_050009EB Extends Quest Hidden

;BEGIN ALIAS PROPERTY Guide
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guide Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SwimsInDeepWaters
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SwimsInDeepWaters Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HatFishingSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HatFishingSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY list
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_list Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY hat
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_hat Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; Wait for the player to exit the letter.
Utility.Wait(0.1)

SetObjectiveCompleted(100)
SetObjectiveDisplayed(75)
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).DisplayAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Add the fish to the fish tank
fishTank.AddFish(Spadefish, 1)
fishTank.AddFish(Pearlfish, 1)
fishTank.UpdateFish()

; Put Swims-In-Deep-Water's hat on
PlayerRef.RemoveItem(FishingHat, 1, true)
Alias_SwimsInDeepWaters.GetActorRef().SetOutfit(FishingHatOutfit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Add the fish to the fish tank
fishTank.AddFish(Spadefish, 1)
fishTank.AddFish(Pearlfish, 1)
fishTank.UpdateFish()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
; The last bit of dialogue has been spoken, it's safe to stop the quest now.

CompleteAllObjectives()
nextQuest.Start()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveCompleted(75)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; The player fished up the lucky fishing hat
(Alias_Player as ccBGSSSE001_ItemCollectObjectiveScript).CompleteAuxObjective()

; Swap the hat that they caught with one filled by the quest reference alias.
PlayerRef.RemoveItem(FishingHat, 1, true)
ObjectReference hat = PlayerRef.PlaceAtMe(FishingHat)
Alias_Hat.ForceRefTo(hat)
PlayerRef.AddItem(hat, 1, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Actor player = Game.GetPlayer()
ObjectReference theList = player.PlaceAtMe(FishList)
Alias_List.ForceRefTo(theList)
player.AddItem(theList)

Alias_Guide.GetRef().EnableNoWait()
SetObjectiveDisplayed(10)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property fishList  Auto  

Armor Property FishingHat  Auto  

Actor Property PlayerRef  Auto  

ccBGSSSE001_FishTankContainerScript property fishTank auto
Ingredient Property Pearlfish  Auto  

Ingredient Property Spadefish  Auto  

Outfit Property FishingHatOutfit  Auto  

Quest Property NextQuest  Auto  
