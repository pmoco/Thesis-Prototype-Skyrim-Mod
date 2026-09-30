Scriptname RPDefault_LLInjection_LeveledItem extends RPDefault_LLInjection
{ Injects array of leveled item forms into a leveled list }

LeveledItem[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction