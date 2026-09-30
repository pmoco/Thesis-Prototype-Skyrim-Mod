Scriptname RPDefault_LLInjectionAdv_Weapon extends RPDefault_LLInjectionAdvanced
{ Injects array of weapon forms into a series of leveled lists. Each InjectForms entry must have a corresponding entry in all other arrays. }

Weapon[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList, Int aiLevel, Int aiCount, Int aiIndex)
	aList.AddForm(InjectForms[aiIndex], aiLevel, aiCount)
EndFunction