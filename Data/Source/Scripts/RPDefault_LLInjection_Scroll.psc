Scriptname RPDefault_LLInjection_Scroll extends RPDefault_LLInjection
{ Injects array of scroll forms into a leveled list }

Scroll[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction