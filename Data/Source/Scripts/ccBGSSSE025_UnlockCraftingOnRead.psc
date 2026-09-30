scriptname ccBGSSSE025_UnlockCraftingOnRead extends ObjectReference

GlobalVariable property craftingFlag1 auto
GlobalVariable property craftingFlag2 auto
Message property craftingUnlockedMessage auto
Message property craftingUnlockedMessage2 auto

Event OnRead()
	if craftingFlag1.GetValueInt() == 0 || craftingFlag2.GetValueInt() == 0
		craftingFlag1.SetValue(1)
		if craftingFlag2
			craftingFlag2.SetValue(1)
		endif
		if craftingUnlockedMessage
			craftingUnlockedMessage.Show()
		endif
		if craftingUnlockedMessage2
			craftingUnlockedMessage2.Show()
		endif
	endif
endEvent