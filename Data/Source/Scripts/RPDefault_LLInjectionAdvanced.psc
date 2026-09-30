Scriptname RPDefault_LLInjectionAdvanced extends RPDefault_VersionedQuest Hidden

LeveledItem[] Property InjectToLists Auto
Int[] Property InjectAtLevel Auto
Int[] Property InjectCount Auto

Event OnInit()
	if(IsRunning())
		HandleQuestInit()
	endif
EndEvent

Function HandleQuestInit()
	HandleInjectToLists(InjectToLists, InjectAtLevel, InjectCount)
EndFunction


Function HandleInjectToLists(LeveledItem[] aListsToInjectTo, Int[] aInjectAtLevels, Int[] aiInjectCounts)
	int i = 0
	while(i < aListsToInjectTo.Length)
		HandleInjection(aListsToInjectTo[i], aInjectAtLevels[i], aiInjectCounts[i], i)
		
		i += 1
	endWhile
EndFunction

Function HandleInjection(LeveledItem aList, Int aiLevel, Int aiCount, Int aiIndex)
	; extend me
EndFunction