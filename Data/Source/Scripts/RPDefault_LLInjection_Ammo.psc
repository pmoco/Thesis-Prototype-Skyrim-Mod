Scriptname RPDefault_LLInjection_Ammo extends RPDefault_LLInjection
{ Injects array of ammo forms into a leveled list }

Ammo[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList)
	int i = 0
	while(i < InjectForms.Length)
		aList.AddForm(InjectForms[i], InjectAtLevel, InjectCount)
		
		i += 1
	endWhile
EndFunction