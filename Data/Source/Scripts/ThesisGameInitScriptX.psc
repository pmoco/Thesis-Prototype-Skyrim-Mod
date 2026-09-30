Scriptname ThesisGameInitScript extends Quest  

ThesisAudioController Property Audio Auto
ThesisLogger Property Logger Auto


Bool HasInitialized = False 




Event OnInit()

    InitializeExperiment()


EndEvent



Event OnPlayerLoadGame()
    
    InitializeExperiment()

EndEvent 




Function InitializeExperiment()

    If HasInitialized
        Return
    EndIf
    
    HasInitialized = True
    
    Actor player = GetActorReference()

    ; Register combat event explicitly
    RegisterForCombatState()

    Logger.Log("Player registered for combat state")



















EndFunction


