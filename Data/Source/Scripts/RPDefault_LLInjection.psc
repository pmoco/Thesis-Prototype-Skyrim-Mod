Scriptname RPDefault_LLInjection extends RPDefault_VersionedQuest Hidden

LeveledItem[] Property InjectToLists Auto
Int Property InjectAtLevel = 1 Auto
Int Property InjectCount = 1 Auto

Event OnInit()	
	if(IsRunning())
		HandleQuestInit()
	endif
EndEvent

Function HandleQuestInit()
	HandleInjectToLists(InjectToLists)
EndFunction

Function HandleInjectToLists(LeveledItem[] aListsToInjectTo)
	int i = 0
	while(i < aListsToInjectTo.Length)
		HandleInjection(aListsToInjectTo[i])
		
		i += 1
	endWhile
EndFunction

Function HandleInjection(LeveledItem aList)
	; extend me
EndFunction