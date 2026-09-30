Scriptname RPDefault_LLInjection_Weapon extends RPDefault_LLInjection
{ Injects array of weapon forms into a leveled list }

Weapon[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction