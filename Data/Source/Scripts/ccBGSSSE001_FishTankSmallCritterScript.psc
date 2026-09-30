scriptname ccBGSSSE001_FishTankSmallCritterScript extends ccBGSSSE001_FishTankCritterScript

float property smallCritterSplineCurve = 75.0 autoReadOnly
float Property smallCritterTranslationSpeedMean = 15.0 autoReadOnly

float function GetSplineCurve()
	return smallCritterSplineCurve
endFunction

float function GetTranslationSpeedMean()
	return smallCritterTranslationSpeedMean
endFunction