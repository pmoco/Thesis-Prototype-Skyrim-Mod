;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SSE_ccBGSSSE037_RareCurios_0100084D Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
LItemMoonSugar75.addform(ccBGSSSE037_LItem_RareCurios, 1, 2)
BYOHLItemKhajiitCaravans.addform(ccBGSSSE037_LItem_RareCurios, 1, 1)
LItemSpecialLoot100.addform(ccBGSSSE037_LItem_WelkyndStone, 1, 1)
LItemSpecialLoot100.addform(ccBGSSSE037_LItem_VarlaStone, 1, 1)
DLC1VendorGadgetsSorineJurardBolts75.addform(ccBGSSSE037_LItem_Bolts, 1, 10)
Game.GetPlayer().Addperk(ccBGSSSE037_PoisonedPerk)
Game.GetPlayer().Addperk(ccBGSSSE037_SilverboltPerk)
LLI_Vendor_SpecialItems.addform(ccBGSSSE037_LItem_Chokeberries, 1, 1)
BYOHLItemKhajiitCaravans.addform(ccBGSSSE037_LItem_CorkbulbItems, 1, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LeveledItem Property LItemSpecialLoot100  Auto  

LeveledItem Property ccBGSSSE037_LItem_RareCurios Auto  

LeveledItem Property LItemMoonSugar75 Auto

Perk Property ccBGSSSE037_PoisonedPerk  Auto  

Perk Property ccBGSSSE037_SilverboltPerk  Auto  

LeveledItem Property ccBGSSSE037_LItem_WelkyndStone  Auto  

LeveledItem Property ccBGSSSE037_LItem_VarlaStone  Auto  

LeveledItem Property DLC1VendorGadgetsSorineJurardBolts75  Auto  

LeveledItem Property ccBGSSSE037_LItem_Bolts  Auto  

LeveledItem Property BYOHLItemKhajiitCaravans  Auto

LeveledItem Property ccBGSSSE037_LItem_Chokeberries  Auto  

LeveledItem Property LLI_Vendor_SpecialItems  Auto  

LeveledItem Property ccBGSSSE037_LItem_CorkbulbItems  Auto  
