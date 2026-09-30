

REQUIREMENTS 
>  Have Installed Skyrim Special Edition
>  Have Installed SKSE (instructions below)


MOD INSTALL 

0. Run Skyrim once until the Main Menu and then leave, if freshly installed,  this will create the config directory and files .

1. go to Skyrim main folder where you see "SkyrimSE.exe" and "SkyrimSELauncher.exe"

1.1>  Not required, but to ensure the original files you can now backup them up, by copying the Data folder and its contents to a second location. (or use a Steam Backup)

2. Install the necessary Mods by extracting the Data folder contents inside the zipped file into the 
/Data folder in the Skyrim's location, if asked to subsitute/replace existing files please do so. 

3. go to the configs folder normaly in ..../My Documents\My Games\Skyrim 
and paste the following to the Skyrim.ini at the end of the file 

[Papyrus]
bEnableLogging=1
bEnableTrace=1
bLoadDebugInformation=1
fPostLoadUpdateTimeMS=500.0
[Gameplay]
bDisableAutoAim=1
bHealthBarShowing=1 

[VATS]
bVATSDisable=1
fKillMoveChance=0.0 
fKillMoveRandom=0.0
bDisableAutoAim=1

[Interface]
bShowCompass=0
bShowInventory3D=0
bShowHUDMessages=0

5. Run the skse64_loader.exe  

6. In the main menu go to "Creations"

7. Press 'T' to enter the Load Order in there 
you should have the following list of mods (total 14) , the names might be slightly different 

Destructible Skyrim 
RLO - Effects 
RLO - Exteriors
RLO - Interiors 
RLO - ILUMINATED SPELS
Immersive Sounds 
IMPROVED ComBat Sounds 
Feanor4 - TheMonarch
NW_STEEL_PLATE_ARMOR
DIS_Realistic Armor
NW_STEEL PLATE ARMORS 
NW_ STEEL PLATE REPLACER 
REalistic AI Detection -  Medium 
No Heavy Breathing 
EVE_KillMove Fixes - KillMoves
Thesis Prototype

8. Make sure all mods are active

9.Order the Mods so they follow these order/rules, or simply use the order above (on step 7).

|| press 'X' key to select/deselect  mod to relocate
|| arrow keys up and down to move selected mod in the order  

1:Destructible Skyrim 
2:ALl the RLOs (doesnt matter order)
	RLO - Effects 
	RLO - Exteriors
	RLO - Interiors 
	RLO - ILUMINATED SPELS
3:Immersive Sounds 
4:IMproved Combat Sounds 
5:All others (dont matter Order )
	Feanor4 - TheMonarch
	NW_STEEL_PLATE_ARMOR
	DIS_Realistic Armor
	NW_STEEL PLATE ARMORS 
	NW_ STEEL PLATE REPLACER 
6:Realistic AI detection 
7:No Heavy Breathing 
8:EVE_KillMove Fixes - KillMoves
9:Thesis Prototype

======================================================================================================
TO RUN >>>>>>>>>>>>>>>

[REQUIRED] Launch using the skse64_loader.exe (if you dont have redo step 2 of tutorial and install the skse)
> press the console open key this can be ` or \ or other depending on your keyboard 
> use the command : coc riverwood  (to start a new game w/ base character )
> after a loading and a few seconds, there will be a message box with version A and Version B ask researcher which one to pick
> after a short wait the game will load into the correct map and the experiment will start

you can now experiment


To exit the game : 

> Press ESC to open Menu 
> in the System you will find "Quit to Menu" and "Quit to Desktop"

OR 
> use the console key to open the console 
> use command qqq to quit the game back into your desktop

RESETing the Experiment 

from the menu you can use the command :   coc riverwood  , to restart the thesis from the very begining. 


======================================================================================================

SKSE instalation Tutorial >>>>>>>>>>>>>>>>>>>>>>><

1. Go to Skyrim  Main folder
2. check if you have "skse64_loader.exe", this might mean you already have SKSE installed 
3. in this .rar go into the /skse64_2_02_06 folder and copy the contents into the Skyrim Main Folder 





















https://www.nexusmods.com/skyrimspecialedition/mods/60854?tab=files