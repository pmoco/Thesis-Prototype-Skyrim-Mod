Scriptname RPDefault_LLInjection_MiscObject extends RPDefault_LLInjection
{ Injects array of misc object forms into a leveled list }

MiscObject[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction