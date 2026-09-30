Scriptname RPDefault_LLInjectionAdv_Armor extends RPDefault_LLInjectionAdvanced
{ Injects array of armor forms into a series of leveled lists. Each InjectForms entry must have a corresponding entry in all other arrays. }

Armor[] Property InjectForms Auto

Function HandleInjection(LeveledItem aList, Int aiLevel, Int aiCount, Int aiIndex)
	aList.AddForm(InjectForms[aiIndex], aiLevel, aiCount)
EndFunction