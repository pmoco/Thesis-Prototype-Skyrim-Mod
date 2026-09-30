Scriptname RPDefault_LLInjection_Ingredient extends RPDefault_LLInjection
{ Injects array of ingredient forms into a leveled list }

Ingredient[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction