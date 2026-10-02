Scriptname ThCheckpointTrigger extends ObjectReference

;========================================
; Properties

ThCheckpointTrigger[] Property LinkedTriggers Auto

ThesisStateController Property Controller Auto

Float Property CheckInterval = 1.0 Auto
Float Property SaveDelay = 0.5 Auto


String Property checkPointName = "Autosave" Auto

;========================================
; Variables

bool Triggered = false
bool PendingSave = false

;========================================
; Trigger

Function TriggerAutoSave()

    ; small delay to avoid saving mid-activation
    Utility.Wait(SaveDelay)

    Debug.Trace("[AUTO SAVE] Triggered  ___ " +  checkpointName  )
    Game.RequestAutoSave()

EndFunction



Function DisableTrigger()

	Triggered = true
    	PendingSave = false

 	GoToState("Inactive")

EndFunction


Auto State Active





	Event OnTriggerEnter(ObjectReference akActionRef)

    		; Only the player activates checkpoints
    		if akActionRef != Game.GetPlayer()
       		 return
    		endif

    		; Already used?
    		if Triggered
       		 return
    		endif

    		Triggered = true

    		; Disable every linked checkpoint
    		int i = 0
    		while i < LinkedTriggers.Length

        		if LinkedTriggers[i]
            			LinkedTriggers[i].DisableTrigger()
        		endif

        		i += 1
   	 	endwhile

    		; If the player is still fighting,
    		; wait until combat finishes.
    		PendingSave = true
    		RegisterForSingleUpdate(CheckInterval)

EndEvent


;========================================
; Wait for combat to end

	Event OnUpdate()

    		if !PendingSave
        		return
    		endif

    ; Still fighting?
    		if Controller.isPlayerInDanger() 

        		RegisterForSingleUpdate(CheckInterval)
        		return

    		endif

    		PendingSave = false
		TriggerAutoSave()
    		Debug.Notification("Checkpoint reached")
		
    		

    		DisableTrigger()

	EndEvent


;========================================

EndState

;========================================

State Inactive

    Event OnTriggerEnter(ObjectReference akActionRef)
        ; Disabled
    EndEvent

EndState