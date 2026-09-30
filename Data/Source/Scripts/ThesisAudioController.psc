Scriptname ThesisAudioController extends Quest


ThesisLoggerScript Property  Logger Auto


;====ARCHETYPE CONSTANTS====================
int ROGUE     = 1 
int WARRIOR    = 0

int archetype = -1

;=================================


;==========================================
;==========Settings=====================
;==========================================




SoundCategory property Ambient Auto 
Float property AMBRogue = 0.0 Auto 
Float Property AMBWarrior = 1.0  Auto 

SoundCategory property Armour Auto 
Float property ArmorRogue = 0.0 Auto 
Float Property ArmorWarrior = 1.0  Auto

SoundCategory property Footstep Auto 
Float property FSTRogue = 0.0 Auto 
Float Property FSTWarrior = 1.0  Auto 
 
SoundCategory property FootstepNPC Auto 
Float property FSTNPCRogue = 0.0 Auto 
Float Property FSTNPCWarrior = 1.0  Auto 

SoundCategory property MusicCat Auto 
Float property MusicValue = 0.0 Auto 

 
SoundCategory property Heartbeat Auto 
Float property HBRogue = 0.0  Auto 
Float Property HBWarrior = 1.0  Auto 

SoundCategory property Breathing Auto 
Float property BRTRogue = 0.0 Auto 
Float Property BRTWarrior = 1.0  Auto 

SoundCategory property Effects Auto 
Float property SFXRogue = 0.0 Auto 
Float Property SFXWarrior = 1.0  Auto 


SoundCategory property Voice Auto 
Float property VoiceRogue = 0.0 Auto 
Float Property VoiceWarrior = 1.0  Auto 

SoundCategory property WeaponCat Auto 
Float property WPNRogue = 0.0 Auto 
Float Property WPNWarrior = 1.0  Auto 

SoundCategory property Traps Auto 
Float property TRPRogue = 0.0 Auto 
Float Property TRPWarrior = 1.0  Auto 

;=========================================





Function SetAudioByArchetype (int arch) 

	archetype = arch

	MusicCat.SetVolume(MusicValue)


	if archetype == Rogue 
		Ambient.SetVolume(	AMBRogue )
		Armour.SetVolume(  FSTRogue )
		Footstep.SetVolume( FSTRogue  ) 	
		FootstepNPC.SetVolume(	FSTNPCRogue )
		Heartbeat.SetVolume(	HBRogue  )
		Breathing.SetVolume(	BRTRogue  )
		Effects.SetVolume(	SFXRogue )
		Voice.SetVolume(	VoiceRogue )
		WeaponCat.SetVolume(	WPNRogue  )
		Traps.SetVolume(	TRPRogue  )

	elseif archetype == Warrior 

		Ambient.SetVolume(	AMBWarrior)
		Armour.SetVolume(  FSTWarrior )
		Footstep.SetVolume(FSTWarrior ) 
		FootstepNPC.SetVolume(	FSTNPCWarrior )
		Heartbeat.SetVolume(	HBWarrior  )
		Breathing.SetVolume(	BRTWarrior  )
		Effects.SetVolume(	SFXWarrior )
		Voice.SetVolume(	VoiceWarrior )
		WeaponCat.SetVolume(	WPNWarrior  )
		Traps.SetVolume(	TRPWarrior  )
	



	else 
		Logger. Log("Error WRONG Archetype Value"+  arch, true)
	endif 


	
EndFunction 









