Scriptname RPDefault_LLInjection_Book extends RPDefault_LLInjection
{ Injects array of book forms into a leveled list }

Book[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction