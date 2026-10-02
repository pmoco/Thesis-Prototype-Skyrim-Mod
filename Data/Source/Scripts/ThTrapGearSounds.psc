Scriptname ThTrapGearSounds extends ObjectReference  
Sound Property Tick Auto


ThTrapGearSounds[] property LinkedSounds Auto 


int SoundInstance = -1

bool property useOnce = FALSE auto

Event OnLoad()

	Utility.wait(1.0)
	
	StartLinked()
	
	if LinkedSounds.Length > 0 
		  ; init linkedSounds 
   		int i = 0
    		while i < LinkedSounds.Length

        		if LinkedSounds[i]
				LinkedSounds[i].LinkedSounds = LinkedSounds
			EndIf
		     	 i += 1
    		endwhile
	
	endif 

	
EndEvent 




Function StartAmbientSound()
	
   	

	if Tick
       	SoundInstance = Tick .Play(Self)
	endif
	
	 ; Stop linked sounds
   	 int i = 0
    	while i < LinkedSounds.Length

        	if LinkedSounds[i]
            		LinkedSounds[i].StartLinked()
        	endif

        	i += 1
    	endwhile

EndFunction



Function StartLinked()

    	if Tick 
		if SoundInstance <0 
       		SoundInstance = Tick.Play(Self)
		endif 
	endif 

EndFunction










Function StopSound()

    ; Stop our own sound
    if (SoundInstance > 0)
        Sound.StopInstance(SoundInstance)
        SoundInstance = -1
    endif

    ; Stop linked sounds
    int i = 0
    while i < LinkedSounds.Length

        if LinkedSounds[i]
            LinkedSounds[i].StopLinked()
        endif

        i += 1
    endwhile

EndFunction


Function StopLinked()

    if (SoundInstance > 0)
        Sound.StopInstance(SoundInstance)
        SoundInstance = -1
    endif

EndFunction



auto STATE active
	EVENT onActivate(objectReference actronaut)
		gotoState("inactive")

		StopSound()
		

		
		if ( useOnce )
		 	BlockActivation(True)
		else 
			StartAmbientSound()
		endIf 
			
	endEVENT

endSTATE

STATE inactive
	; do nothing in this state
	
endSTATE

