Scriptname RPDefault_SpellTomeInjector extends Quest

int Property iSpellLevel_Novice = 1 autoReadOnly
int Property iSpellLevel_Apprentice = 2 autoReadOnly
int Property iSpellLevel_Adept = 3 autoReadOnly
int Property iSpellLevel_Expert = 4 autoReadOnly
int Property iSpellLevel_Master = 5 autoReadOnly

int Property iSpellSchool_Alteration = 1 autoReadOnly
int Property iSpellSchool_Conjuration = 2 autoReadOnly
int Property iSpellSchool_Destruction = 3 autoReadOnly
int Property iSpellSchool_Illusion = 4 autoReadOnly
int Property iSpellSchool_Restoration = 5 autoReadOnly

; Novice
	; Alteration
LeveledItem Property LItemSpellTomes00AllAlteration Auto
LeveledItem Property LItemSpellTomes00Alteration Auto
	; Conjuration
LeveledItem Property LItemSpellTomes00AllConjuration Auto
LeveledItem Property LItemSpellTomes00Conjuration Auto
	; Destruction
LeveledItem Property LItemSpellTomes00AllDestruction Auto
LeveledItem Property LItemSpellTomes00Destruction Auto
	; Illusion
LeveledItem Property LItemSpellTomes00AllIllusion Auto
LeveledItem Property LItemSpellTomes00Illusion Auto
	; Restoration
LeveledItem Property LItemSpellTomes00AllRestoration Auto
LeveledItem Property LItemSpellTomes00Restoration Auto
	; All spell lists
LeveledItem Property LItemSpellTomes00AllSpells Auto
LeveledItem Property LItemSpellTomes00Spells Auto
	
; Apprentice
	; Alteration
LeveledItem Property LItemSpellTomes25AllAlteration Auto
LeveledItem Property LItemSpellTomes25Alteration Auto
	; Conjuration
LeveledItem Property LItemSpellTomes25AllConjuration Auto
LeveledItem Property LItemSpellTomes25Conjuration Auto
	; Destruction
LeveledItem Property LItemSpellTomes25AllDestruction Auto
LeveledItem Property LItemSpellTomes25Destruction Auto
	; Illusion
LeveledItem Property LItemSpellTomes25AllIllusion Auto
LeveledItem Property LItemSpellTomes25Illusion Auto
	; Restoration
LeveledItem Property LItemSpellTomes25AllRestoration Auto
LeveledItem Property LItemSpellTomes25Restoration Auto
	; All spell lists
LeveledItem Property LItemSpellTomes25AllSpells Auto
LeveledItem Property LItemSpellTomes25Spells Auto
	
; Adept
	; Alteration
LeveledItem Property LItemSpellTomes50AllAlteration Auto
LeveledItem Property LItemSpellTomes50Alteration Auto
	; Conjuration
LeveledItem Property LItemSpellTomes50AllConjuration Auto
LeveledItem Property LItemSpellTomes50Conjuration Auto
	; Destruction
LeveledItem Property LItemSpellTomes50AllDestruction Auto
LeveledItem Property LItemSpellTomes50Destruction Auto
	; Illusion
LeveledItem Property LItemSpellTomes50AllIllusion Auto
LeveledItem Property LItemSpellTomes50Illusion Auto
	; Restoration
LeveledItem Property LItemSpellTomes50AllRestoration Auto
LeveledItem Property LItemSpellTomes50Restoration Auto
	; All spell lists
LeveledItem Property LItemSpellTomes50Spells Auto ; Only 1 of these lists for Adept

; Expert
	; Alteration
LeveledItem Property LItemSpellTomes75AllAlteration Auto
LeveledItem Property LItemSpellTomes75Alteration Auto
	; Conjuration
LeveledItem Property LItemSpellTomes75AllConjuration Auto
LeveledItem Property LItemSpellTomes75Conjuration Auto
	; Destruction
LeveledItem Property LItemSpellTomes75AllDestruction Auto
LeveledItem Property LItemSpellTomes75Destruction Auto
	; Illusion
LeveledItem Property LItemSpellTomes75AllIllusion Auto
LeveledItem Property LItemSpellTomes75Illusion Auto
	; Restoration
LeveledItem Property LItemSpellTomes75AllRestoration Auto
LeveledItem Property LItemSpellTomes75Restoration Auto
	; All spell lists
LeveledItem Property LItemSpellTomes75Spells Auto ; Only 1 of these lists for Expert

; Master
	; Alteration
LeveledItem Property LItemSpellTomes100Alteration Auto
LeveledItem Property MGRitualAlterationBooks Auto
	; Conjuration
LeveledItem Property LItemSpellTomes100Conjuration Auto
LeveledItem Property MGRitualConjurationBooks Auto
	; Destruction
LeveledItem Property LItemSpellTomes100Destruction Auto
LeveledItem Property MGRitualDestructionBooks Auto
	; Illusion
LeveledItem Property LItemSpellTomes100Illusion Auto
LeveledItem Property MGRitualIllusionBooks Auto
	; Restoration
LeveledItem Property LItemSpellTomes100Restoration Auto
LeveledItem Property MGRitualRestorationBooks Auto
	; All spell lists
; No all spell lists for Master spells

	

Function InjectTomes(Book[] aTomesToInject, Int[] aiSpellSchool, Int[] aiSpellLevel, Int[] aiInjectLevel = None, Int[] aiInjectCount = None)
	int i = 0
	while(i < aTomesToInject.Length)
		if(aTomesToInject[i] && aiSpellSchool.Length > i && aiSpellSchool[i] >= 1 && aiSpellSchool[i] <= 5 && aiSpellLevel.Length > i && aiSpellLevel[i] >= 1 && aiSpellLevel[i] <= 5)
			; Most use cases will just inject a single entry at level 1, so we're allowing the Inject Level and Inject Count to be optional
			
			int iInjectAtLevel = 1
			if(aiInjectLevel && aiInjectLevel.Length > i && aiInjectLevel[i] > 0)
				iInjectAtLevel = aiInjectLevel[i]
			endif
						
			int iInjectCount = 1
			if(aiInjectCount && aiInjectCount.Length > i && aiInjectCount[i] > 0)
				iInjectCount = aiInjectCount[i]
			endif
			
			InjectTome(aTomesToInject[i], aiSpellSchool[i], aiSpellLevel[i], iInjectAtLevel, iInjectCount)
		endif
		
		i += 1
	endWhile
EndFunction

Function InjectTome(Book aTomeToInject, Int aiSpellSchool, Int aiSpellLevel, Int aiInjectLevel = 1, Int aiInjectCount = 1)
	LeveledItem[] InjectToLists = _GetSpellTomeLeveledLists(aiSpellSchool, aiSpellLevel)
	int i = 0
	while(i < InjectToLists.Length)
		if(InjectToLists[i])
			InjectToLists[i].AddForm(aTomeToInject, aiInjectLevel, aiInjectCount)
		else
			; Blank entry detected, exiting loop
			return
		endif
		
		i += 1
	endWhile
EndFunction



LeveledItem[] Function _GetSpellTomeLeveledLists(Int aiSpellSchool, Int aiSpellLevel)
	LeveledItem[] TargetLists = new LeveledItem[4] ; 4 is the most lists we could get from the code below
	int iIndex = 0
	
	if(aiSpellLevel == iSpellLevel_Novice)
		if(aiSpellSchool == iSpellSchool_Alteration)
			TargetLists[iIndex] = LItemSpellTomes00AllAlteration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes00Alteration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Conjuration)
			TargetLists[iIndex] = LItemSpellTomes00AllConjuration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes00Conjuration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Destruction)
			TargetLists[iIndex] = LItemSpellTomes00AllDestruction
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes00Destruction
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Illusion)
			TargetLists[iIndex] = LItemSpellTomes00AllIllusion
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes00Illusion
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Restoration)
			TargetLists[iIndex] = LItemSpellTomes00AllRestoration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes00Restoration
			iIndex += 1
		endif
		
			; All - we'll always inject to the "all" lists, regardless of what schools are checked
		TargetLists[iIndex] = LItemSpellTomes00AllSpells
		iIndex += 1
		TargetLists[iIndex] = LItemSpellTomes00Spells
		iIndex += 1
	elseif(aiSpellLevel == iSpellLevel_Apprentice)
		if(aiSpellSchool == iSpellSchool_Alteration)
			TargetLists[iIndex] = LItemSpellTomes25AllAlteration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes25Alteration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Conjuration)
			TargetLists[iIndex] = LItemSpellTomes25AllConjuration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes25Conjuration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Destruction)
			TargetLists[iIndex] = LItemSpellTomes25AllDestruction
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes25Destruction
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Illusion)
			TargetLists[iIndex] = LItemSpellTomes25AllIllusion
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes25Illusion
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Restoration)
			TargetLists[iIndex] = LItemSpellTomes25AllRestoration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes25Restoration
			iIndex += 1
		endif
		
			; All - we'll always inject to the "all" lists, regardless of what schools are checked
		TargetLists[iIndex] = LItemSpellTomes25AllSpells
		iIndex += 1
		TargetLists[iIndex] = LItemSpellTomes25Spells
		iIndex += 1
	elseif(aiSpellLevel == iSpellLevel_Adept)
		if(aiSpellSchool == iSpellSchool_Alteration)
			TargetLists[iIndex] = LItemSpellTomes50AllAlteration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes50Alteration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Conjuration)
			TargetLists[iIndex] = LItemSpellTomes50AllConjuration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes50Conjuration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Destruction)
			TargetLists[iIndex] = LItemSpellTomes50AllDestruction
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes50Destruction
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Illusion)
			TargetLists[iIndex] = LItemSpellTomes50AllIllusion
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes50Illusion
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Restoration)
			TargetLists[iIndex] = LItemSpellTomes50AllRestoration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes50Restoration
			iIndex += 1
		endif
		
			; All - we'll always inject to the "all" lists, regardless of what schools are checked
				; There is no 50AllSpells LL
		TargetLists[iIndex] = LItemSpellTomes50Spells
		iIndex += 1
	elseif(aiSpellLevel == iSpellLevel_Expert)
		if(aiSpellSchool == iSpellSchool_Alteration)
			TargetLists[iIndex] = LItemSpellTomes75AllAlteration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes75Alteration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Conjuration)
			TargetLists[iIndex] = LItemSpellTomes75AllConjuration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes75Conjuration
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Destruction)
			TargetLists[iIndex] = LItemSpellTomes75AllDestruction
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes75Destruction
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Illusion)
			TargetLists[iIndex] = LItemSpellTomes75AllIllusion
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes75Illusion
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Restoration)
			TargetLists[iIndex] = LItemSpellTomes75AllRestoration
			iIndex += 1
			TargetLists[iIndex] = LItemSpellTomes75Restoration
			iIndex += 1
		endif
		
			; All - we'll always inject to the "all" lists, regardless of what schools are checked
				; There is no 75AllSpells LL
		TargetLists[iIndex] = LItemSpellTomes75Spells
		iIndex += 1
	elseif(aiSpellLevel == iSpellLevel_Master)
		if(aiSpellSchool == iSpellSchool_Alteration)
			TargetLists[iIndex] = LItemSpellTomes100Alteration
			iIndex += 1
			TargetLists[iIndex] = MGRitualAlterationBooks
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Conjuration)
			TargetLists[iIndex] = LItemSpellTomes100Conjuration
			iIndex += 1
			TargetLists[iIndex] = MGRitualConjurationBooks
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Destruction)
			TargetLists[iIndex] = LItemSpellTomes100Destruction
			iIndex += 1
			TargetLists[iIndex] = MGRitualDestructionBooks
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Illusion)
			TargetLists[iIndex] = LItemSpellTomes100Illusion
			iIndex += 1
			TargetLists[iIndex] = MGRitualIllusionBooks
			iIndex += 1
		elseif(aiSpellSchool == iSpellSchool_Restoration)
			TargetLists[iIndex] = LItemSpellTomes100Restoration
			iIndex += 1
			TargetLists[iIndex] = MGRitualRestorationBooks
			iIndex += 1
		endif
		
		; No All lists for master spells
	endif
	
	return TargetLists
EndFunction