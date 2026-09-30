scriptname ccBGSSSE001_ItemCatchData extends ccBGSSSE001_CatchData
{ Script for defining caught items. }

LeveledItem property item auto
{ The LeveledItem list to draw items from. }

Form function getCaughtObject()
	return item
endFunction

int function getCatchType()
	return ccBGSSSE001_CatchTypeObject.GetValueInt()
endFunction
