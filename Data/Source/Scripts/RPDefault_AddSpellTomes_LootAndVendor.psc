Scriptname RPDefault_AddSpellTomes_LootAndVendor extends RPDefault_VersionedQuest
{ Injects spell tomes into a variety of leveled lists based on their skill level and school. }

RPDefault_SpellTomeInjector Property RPDefaultSpellTomeInjector Auto
{ Autofill }

Book[] Property SpellTomesToInject Auto
{ For each tome, be sure to also add an entry to the SpellSchool and SpellLevel properties! }
Int[] Property SpellSchool Auto
{ 1 = Alteration, 2 = Conjuration, 3 = Destruction, 4 = Illusion, 5 = Restoration }
Int[] Property SpellLevel Auto
{ 1 = Novice, 2 = Apprentice, 3 = Adept, 4 = Expert, 5 = Master }

Int[] Property InjectAtLevel Auto
{ Optional - fill these out to change which level the tomes will start appearing in leveled lists. Defaults to 1 for all. }
Int[] Property InjectCount Auto
{ Optional - fill these out to change how many of this tome will be added to leveled lists. Defaults to 1 for all. }

Event OnInit()
	if(IsRunning())
		HandleQuestInit()
	endif
EndEvent

Function HandleQuestInit()
	HandleInjections()
EndFunction

Function HandleInjections()
	RPDefaultSpellTomeInjector.InjectTomes(SpellTomesToInject, SpellSchool, SpellLevel, InjectAtLevel, InjectCount)
EndFunction