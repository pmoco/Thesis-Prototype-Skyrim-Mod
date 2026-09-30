Scriptname RPDefault_LLInjection_Potion extends RPDefault_LLInjection
{ Injects array of potion forms into a leveled list }

Potion[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction