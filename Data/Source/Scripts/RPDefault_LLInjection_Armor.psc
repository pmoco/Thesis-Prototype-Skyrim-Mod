Scriptname RPDefault_LLInjection_Armor extends RPDefault_LLInjection
{ Injects array of armor forms into a leveled list }

Armor[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction