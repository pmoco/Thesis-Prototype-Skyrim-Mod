Scriptname RPDefault_VersionedQuest extends Quest  
{ Sets up a quest with native update capability. 

IMPORTANT: Be sure to setup an alias pointing at the player with the script RPDefault_VersionedQuest_PlayerAlias}

; -------------------------------------------
; Editor Properties
; -------------------------------------------

GlobalVariable Property gCurrentVersion Auto
{ Set up a unique global with const flag set and a starting value of 1. Then increase the value of this global to have code in HandleVersionChanges run when the player loads the update. }

; -------------------------------------------
; Hidden Properties
; -------------------------------------------

int Property iLastInstalledVersion = 0 Auto Hidden

; -------------------------------------------
; Events
; -------------------------------------------

; -------------------------------------------
; Functions
; -------------------------------------------

Function TriggerGameLoaded()
	TryToInstallPatches()
	
	HandleGameLoaded()
EndFunction

Function HandleGameLoaded()
	; Extend me
EndFunction

Function TryToInstallPatches()
	int iCurrentVersion = gCurrentVersion.GetValueInt()
    if(iCurrentVersion > iLastInstalledVersion)
		HandleVersionChanges(iCurrentVersion, iLastInstalledVersion)
    endif
        
    iLastInstalledVersion = iCurrentVersion
EndFunction

Function HandleVersionChanges(Int aiNewVersion, Int aiPreviousVerison)
	; Extend me
EndFunction