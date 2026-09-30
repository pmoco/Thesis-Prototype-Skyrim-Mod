Scriptname ThesisPlayerLoadout extends ReferenceAlias  


Message Property LoadoutMessage Auto

ThesisLoggerScript Property Logger Auto
ThesisStateController Property StateController Auto 

Race Property RogueRace Auto
Race Property WarriorRace Auto


Armor Property RogueBoots Auto
Armor Property WarriorBoots Auto

Armor Property RogueChest Auto
Armor Property WarriorChest Auto

Armor Property RogueGauntlets  Auto
Armor Property WarriorGauntlets Auto

Armor Property RogueHelm Auto
Armor Property WarriorHelm Auto

Weapon Property RogueWeapon Auto
Weapon Property WarriorWeapon Auto

String Property Prefix = "=Equipment load=" Auto


int Property Health  = 100 Auto
int Property Magicka  = 0 Auto
int Property Stamina   = 150 Auto
Float Property HealthRate =5.0 Auto
Float Property HealthCombatRate =  -0.2 Auto
Float Property StaminaRate =2.0 Auto



int Property Sneak =999 Auto
int Property LArmor = 50 Auto
int Property Attack = 50  Auto

int Property PlayerMov = 100 auto 
int Property CarryWeight = 10000 auto 



Thesis_BreathingWarrior Property BreathingMod Auto



Function LoadEquipment() 
   int choice = LoadoutMessage.Show()

   Utility.Wait(0.2) ; ensure player is loaded

    if (choice ==0)
       ApplyWarrior()
    elseif (choice == 1)
	  ApplyRogue()
    else 
	ApplyWarrior() 
	BreathingMod.AlternateCalm ()
	choice = 0
    endif
	
	StateController.SetArchetype(choice) 
   	initStats()

EndFunction


Function ApplyRogue()

   Utility.Wait(0.2) ; ensure player is loaded

   Logger.Log("Equip Rogue Loadout VersionB", prefix, True)






    Actor p = GetActorReference()
    p.SetRace(RogueRace )

   Utility.Wait(0.5)

    p.RemoveAllItems()

    p.AddItem(RogueBoots, 1, True)
    p.EquipItem(RogueBoots, True, True)

    p.AddItem(RogueChest , 1, True)
    p.EquipItem(RogueChest , True, True)

    p.AddItem(RogueGauntlets  , 1, True)
    p.EquipItem(RogueGauntlets  , True, True)

    p.AddItem(RogueHelm , 1, True)
    p.EquipItem(RogueHelm , True, True)

    p.AddItem(RogueWeapon , 1, True)
    p.EquipItem(RogueWeapon , True, True)

EndFunction

Function ApplyWarrior()

   Utility.Wait(0.2) ; ensure player is loaded

   Logger.Log("Equip Rogue Loadout VersionB", prefix, True)
   
   Actor p = GetActorReference()
   p.SetRace(WarriorRace )

   Utility.Wait(0.5)


    p.RemoveAllItems()

    p.AddItem(WarriorBoots, 1, True)
    p.EquipItem(WarriorBoots, True, True)

    p.AddItem(WarriorChest, 1, True)
    p.EquipItem(WarriorChest, True, True)

    p.AddItem(WarriorGauntlets  , 1, True)
    p.EquipItem(WarriorGauntlets  , True, True)

    p.AddItem(WarriorHelm , 1, True)
    p.EquipItem(WarriorHelm , True, True)

    p.AddItem(WarriorWeapon , 1, True)
    p.EquipItem(WarriorWeapon , True, True)

EndFunction


Function InitStats()

    Actor player = Game.GetPlayer()

    ; =====================
    ; CORE ATTRIBUTES
    ; =====================
    player.SetActorValue("Health", Health)
    player.SetActorValue("Magicka", Magicka )
    player.SetActorValue("Stamina", Stamina)


    player.SetActorValue("HealRate", HealthRate)
    player.SetActorValue("CombatHealthRegenMult", HealthCombatRate )
    player.SetActorValue("HealRate", HealthRate)

    player.RestoreActorValue("Health", 9999)
    player.RestoreActorValue("Stamina", 9999)

    ; =====================
    ; COMBAT SKILLS
    ; =====================
    player.SetActorValue("OneHanded", Attack )
    player.SetActorValue("Block", Attack  )
    player.SetActorValue("Sneak", Sneak )
    player.SetActorValue("LightArmor", LArmor)
    player.SetActorValue("HeavyArmor", LArmor)

    ; =====================
    ; MOVEMENT
    ; =====================
    player.SetActorValue("SpeedMult", PlayerMov)

    ; =====================
    ; SURVIVAL
    ; =====================
    player.SetAV("CarryWeight", CarryWeight)

    Debug.Trace("[THESIS] Stats Initialized")

EndFunction










