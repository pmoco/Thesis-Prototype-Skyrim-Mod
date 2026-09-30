Scriptname ThWhistling extends   ObjectReference


Sound Property Whistle Auto

Float Property UpdateInterval = 0.5 Auto
Float Property ResumeDelay = 5.0 Auto
ThesisLoggerScript Property Logger  Auto

int SoundInstance = -1

bool IsWhistling = false
float ResumeTimer = -1.0

Actor Guard

event OnLoad() 
	;StartSound()
	
EndEvent



Function StartSound()
	
    if IsWhistling
        return
    endif
	
    Logger.Log("START SOUND")

    SoundInstance = Whistle.Play(Self)
    IsWhistling = true

EndFunction


Function StopSound()

    if !IsWhistling
        return
    endif

    if SoundInstance > 0
        Sound.StopInstance(SoundInstance)
    endif

	
	Logger.Log("STOP  SOUND")

    SoundInstance = -1
    IsWhistling = false

EndFunction