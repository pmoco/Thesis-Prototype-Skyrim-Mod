Scriptname ThesisStaminaStateControl extends ReferenceAlias  

Int currentState = -1

ThesisLoggerScript Property Logger Auto

Float Property st = 1.0  Auto

; 0 = normal
; 1 = low
; 2 = exhausted





Function UpdateState(Actor p)
    ;st = p.GetAV("Stamina") / p.GetAV("StaminaMax")

    st =  p.GetAVPercentage("Stamina")

    int newState = 0

    if (st < 0.25)
        newState = 2
    elseif (st < 0.5)
        newState = 1
    endif

    if (newState != currentState)
        currentState = newState
	 Logger.Notify("Stamina: "+  p.GetAVPercentage("Stamina") )
        OnStateChanged(p, newState)
    endif
EndFunction


Function OnStateChanged(Actor p, int newState)
    if (newState== 2)
        Logger.Notify("Stamina: EXHAUSTED")
    elseif (newState== 1)
        Logger.Notify("Stamina: LOW")
    else
        Logger.Notify("Stamina: NORMAL")
    endif
EndFunction