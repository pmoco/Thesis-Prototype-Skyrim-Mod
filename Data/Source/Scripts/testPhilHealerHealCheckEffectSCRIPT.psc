Scriptname testPhilHealerHealCheckEffectSCRIPT extends ActiveMagicEffect  

;the heal spell we're using
SPELL PROPERTY healSpell AUTO

;dont do this too often
BOOL canHeal=FALSE

EVENT onEffectStart(Actor akTarget, Actor akCaster)
			
	;make sure we can cast the heal first
	IF(akCaster.getAV("variable07") == 0)
		
		akCaster.playAnimation("MagicFireForgetLeftOutro")
		healSpell.cast(akCaster, akTarget)

		;turn our healer's ability off
		akCaster.setAV("variable07", 1)

		;wait 7 seconds before being able to heal again
		utility.wait(5)

		;we can heal again!
		akCaster.setAV("variable07", 0)			

	ENDIF

ENDEVENT
