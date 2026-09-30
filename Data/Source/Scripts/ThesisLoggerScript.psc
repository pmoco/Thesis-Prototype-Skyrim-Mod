Scriptname ThesisLoggerScript extends Quest

; =========================
; CONFIG
; =========================

Bool Property ToScreen = False Auto

String Property Prefix = "[Thesis]" Auto
String Property Version = "v0.5" Auto 




; =========================
; CORE LOG FUNCTION
; =========================

Function Log(String text, String addedPrefix = "", bool WriteToScreen = True)
    String finalPrefix = Prefix

    if (addedPrefix != "")
        finalPrefix = finalPrefix + "_" + addedPrefix
    endif

    String finalMessage = finalPrefix + "  " + text

    ; Write to Papyrus log
    Debug.Trace(finalMessage)

    ; Optional on-screen notification
    if (WriteToScreen && ToScreen)
        Debug.Notification(finalMessage)
    endif
EndFunction

; =========================
; NOTIFY ONLY
; =========================

Function Notify(String text)
    Debug.Notification(text)
EndFunction






; =========================
; INIT  ONLY
; =========================


Event OnInit()
	Log("Thesis Mod Initialized ::"+ version, "LOG")
EndEvent 

