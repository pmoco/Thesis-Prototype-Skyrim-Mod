;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ccBGSSSE001_FishingFollow_050D1017 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dog
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dog Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DogMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DogMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
if Follower.GetActorRef()
    Follower.SetFollowerIdleWhenFishing()
endif

if Dog.GetActorRef()
    Dog.SetFollowerIdleWhenFishing()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ccBGSSSE001_SandboxFollowerScript property Follower auto
ccBGSSSE001_SandboxFollowerScript property Dog auto
