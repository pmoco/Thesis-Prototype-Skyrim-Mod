scriptname ccBGSSSE025_RCIntegrationScript extends ReferenceAlias

string property RARE_CURIOS_PLUGIN = "ccBGSSSE037-Curios.esl" autoReadOnly hidden

GlobalVariable property RareCuriosInstalled auto

LeveledItem property IngredientsShiveringCommon50 auto
LeveledItem property IngredientsShiveringCommon100 auto
LeveledItem property IngredientsShiveringRare100 auto
LeveledItem property IngredientsFirestalk100 auto
LeveledItem property IngredientsOrderHeart100 auto
LeveledItem property ElytraDeathItemList auto
LeveledItem property SprigganDeathUniqueItemList50 auto
LeveledItem property SprigganDeathUniqueItemList100 auto

int property INGREDIENT_ID_ALOCASIAFRUIT = 0x0D62 autoReadOnly hidden
int property INGREDIENT_ID_WATCHERSEYE = 0x0821 autoReadOnly hidden
int property INGREDIENT_ID_BLISTERPODCAP = 0x0D6A autoReadOnly hidden
int property INGREDIENT_ID_HYDNUMSPORE = 0x080D autoReadOnly hidden
int property INGREDIENT_ID_REDKELPBLADDER = 0x0817 autoReadOnly hidden
int property INGREDIENT_ID_SCALONFIN = 0x081B autoReadOnly hidden
int property INGREDIENT_ID_WITHERINGMOON = 0x0824 autoReadOnly hidden
int property INGREDIENT_ID_WORMSHEADCAP = 0x0825 autoReadOnly hidden
int property INGREDIENT_ID_ASTERBLOOMCORE = 0x0D66 autoReadOnly hidden
int property INGREDIENT_ID_BLINDWATCHERSEYE = 0x0822 autoReadOnly hidden
int property INGREDIENT_ID_GNARLBARK = 0x082C autoReadOnly hidden
int property INGREDIENT_ID_ORDERHEART = 0x0851 autoReadOnly hidden
int property INGREDIENT_ID_HUNGERTONGUE = 0x080C autoReadOnly hidden
int property INGREDIENT_ID_VOIDESSENCE = 0x0820 autoReadOnly hidden
int property INGREDIENT_ID_ELYTRAICHOR = 0x0828 autoReadOnly hidden
int property INGREDIENT_ID_FLAMESTALK = 0x082A autoReadOnly hidden

Event OnPlayerLoadGame()
	if RareCuriosInstalled.GetValueInt() == 0
		RunIntegration()
	endif
endEvent

function RunIntegration()
	if IsRareCuriosInstalled()
		RareCuriosInstalled.SetValueInt(1)
		PopulateLists()
	endif
endFunction

bool function IsRareCuriosInstalled()
	return Game.GetFormFromFile(INGREDIENT_ID_FLAMESTALK, RARE_CURIOS_PLUGIN) as bool
endFunction

function PopulateLists()
	; Common Ingredients
	AddFormToList(INGREDIENT_ID_ALOCASIAFRUIT, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_WATCHERSEYE, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_BLISTERPODCAP, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_HYDNUMSPORE, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_REDKELPBLADDER, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_SCALONFIN, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_WITHERINGMOON, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	AddFormToList(INGREDIENT_ID_WORMSHEADCAP, IngredientsShiveringCommon100, IngredientsShiveringCommon50)
	
	; Rare Ingredients
	AddFormToList(INGREDIENT_ID_ASTERBLOOMCORE, IngredientsShiveringRare100)
	AddFormToList(INGREDIENT_ID_BLINDWATCHERSEYE, IngredientsShiveringRare100)
	AddFormToList(INGREDIENT_ID_GNARLBARK, IngredientsShiveringRare100)
	AddFormToList(INGREDIENT_ID_HUNGERTONGUE, IngredientsShiveringRare100)
	AddFormToList(INGREDIENT_ID_VOIDESSENCE, IngredientsShiveringRare100)
	
	; Death Lists
	AddFormToList(INGREDIENT_ID_ELYTRAICHOR, ElytraDeathItemList)
	AddFormToList(INGREDIENT_ID_BLISTERPODCAP, SprigganDeathUniqueItemList50)
	AddFormToList(INGREDIENT_ID_HYDNUMSPORE, SprigganDeathUniqueItemList50)
	AddFormToList(INGREDIENT_ID_WATCHERSEYE, SprigganDeathUniqueItemList50)
	AddFormToList(INGREDIENT_ID_WORMSHEADCAP, SprigganDeathUniqueItemList50)
	AddFormToList(INGREDIENT_ID_GNARLBARK, SprigganDeathUniqueItemList100)

	; Unique Ingredients
	AddFormToList(INGREDIENT_ID_ORDERHEART, IngredientsOrderHeart100)
	AddFormToList(INGREDIENT_ID_FLAMESTALK, IngredientsFirestalk100)
endFunction

function AddFormToList(int aiFormID, LeveledItem firstList, LeveledItem secondList = None)
	Form myItem = Game.GetFormFromFile(aiFormID, RARE_CURIOS_PLUGIN)

	firstList.AddForm(myItem, 1, 1)

	if secondList
		secondList.AddForm(myItem, 1, 1)
	endif
endFunction
