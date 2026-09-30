scriptname Survival_GlobalFunctions hidden
{ Contains globally accessible functions for Survival Mode. }

import Math

function SurvivalLogMessage(string asMessage) global
	; debug.trace("{{SURVIVAL}} " + asMessage)
endFunction

string function HungerStaminaPenaltyAV() global
	return "Variable02"
endFunction

string function ExhaustionMagickaPenaltyAV() global
	return "Variable03"
endFunction

string function ColdHealthPenaltyAV() global
	return "Variable04"
endFunction

string function WarmthRatingAV() global
	return "Variable09"
endFunction

float function ClampFloatTo(float value, float min, float max) global
	if value > max
		return max
	elseif value < min
		return min
	else
		return value
	endif
endFunction

bool function Between(float value, float upper, float lower, bool inclusiveUpperBound = false) global
    if inclusiveUpperBound
    	if value <= upper && value >= lower
        	return true
    	endif
    else
    	if value < upper && value >= lower
        	return true
    	endif
    endif
    
    return false
endFunction
