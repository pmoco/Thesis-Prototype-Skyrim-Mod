Scriptname ThesisPressurePlate extends PressurePlate

; ===========================
; CONFIG
; ===========================

Sound Property DisableSound Auto
Bool Property IsDisabled = False Auto
Bool Property OneTimeDisable = True Auto
ThesisLoggerScript  Property Logger Auto


; ===========================
; INTERACTION
; ===========================



Event OnActivate(ObjectReference akActionRef)
	
	
	Debug.Notification("Trap Disabled")

    if akActionRef != Game.GetPlayer()
        return
    endif

    if IsDisabled
        return
    endif

    ; deactivate trap
    IsDisabled = True

    ; stop triggering
    GoToState("Disabled")

    ; feedback
    if DisableSound
        DisableSound.Play(Self)
    endif

    ; optional animation
    PlayAnimation("Down")

    Debug.Notification("Trap Disabled")

EndEvent


; ===========================
; DISABLED STATE
; ===========================

State Disabled

    Event OnTriggerEnter(ObjectReference triggerRef)
        ; do nothing
    EndEvent

    Event OnTriggerLeave(ObjectReference triggerRef)
        ; do nothing
    EndEvent

    Event OnTrigger(ObjectReference triggerRef)
        ; do nothing
    EndEvent

EndState