Scriptname ThesisAutoSave extends ObjectReference  


Bool Property EnableAutoSave = True Auto
Float Property SaveDelay = 0.5 Auto

Event OnActivate(ObjectReference akActionRef)

    	if (akActionRef == Game.GetPlayer())

        	if (EnableAutoSave)
            		TriggerAutoSave()
        	endif
  	EndIf

EndEvent

Function TriggerAutoSave()

    ; small delay to avoid saving mid-activation
    Utility.Wait(SaveDelay)

    Debug.Trace("[AUTO SAVE] Triggered")
    Game.RequestAutoSave()

EndFunction