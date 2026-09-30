scriptname ccBGSSSE001_CatchData extends Activator hidden
{ Base script for defining fishing catch data. }

GlobalVariable property ccBGSSSE001_CatchTypeSmallFish auto ; constant
GlobalVariable property ccBGSSSE001_CatchTypeLargeFish auto ; constant
GlobalVariable property ccBGSSSE001_CatchTypeObject auto ; constant
GlobalVariable property ccBGSSSE001_CatchTypeQuestEvent auto ; constant

bool property isOneTimeCatch = false auto
{ Should this object only be caught once, ever? Default: False }

string property successNodeName = "SuccessNodeFish" auto
{ The node to move the object to when caught as part of the fanfare screen. Default: SuccessNodeFish }

Form function getCaughtObject()
	;/  Extend
	    
	    Return the caught object.
	/;

	return None
endFunction

float[] function getCatchSequence()
	;/  Extend
	
	    Positive values: Nibble, then wait (float) seconds.
	    0.0: End sequence and tug line

	    Examples:
	        [3.2, 0.6, 0.6, 0.0]: Nibble once and wait 3.2 seconds, 
	        then nibble twice, waiting 0.6 in between, and then tug the line.

	        [0.0]: Immediately tug the line (no nibbles).
	/;

	return new Float[1]
endFunction

int function getCatchType()
	;/ Extend
		Returns the values of one of the following globals:
		ccBGSSSE001_CatchTypeSmallFish
		ccBGSSSE001_CatchTypeLargeFish
		ccBGSSSE001_CatchTypeObject
		ccBGSSSE001_CatchTypeQuestEvent
	/;

	return -1
endFunction

Weapon function getRequiredRod()
	;/ Extend
	   The rod required to catch this, if any.
	/;
	return None
endFunction
