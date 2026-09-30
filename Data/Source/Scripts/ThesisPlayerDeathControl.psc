Scriptname ThesisPlayerDeathControl extends ReferenceAlias  

Bool Property EnableFade = True Auto

ThesisLoggerScript Property Logger Auto

Bool Property abFadingOut= True Auto
float property afSecsBeforeFade = 0.2 Auto
float property afFadeDuration = 2.0 Auto


Event OnCellLoad() 
	
EndEvent


Event OnDying(Actor akKiller)


	Logger.Log("Fading") 
	Game.FadeOutGame(false, true, 15.0, 1.0)

	if (EnableFade)
        ; Immediate fade to black
		
		

	endif

EndEvent