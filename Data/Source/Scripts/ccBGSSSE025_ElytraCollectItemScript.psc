Scriptname ccBGSSSE025_ElytraCollectItemScript extends Quest  

Potion property itemToCollect auto
GlobalVariable property collectionGlobal auto
Faction property PetFramework_PetFollowingFaction auto
ReferenceAlias property pet auto
Message property readyMessage auto

function CollectItem()
	if collectionGlobal.GetValueInt() == 1
		collectionGlobal.SetValueInt(0)
		Game.GetPlayer().AddItem(itemToCollect, 1)
		RegisterForSingleUpdateGameTime(24)
	endif
endFunction

Event OnUpdateGameTime()
	collectionGlobal.SetValueInt(1)

	if pet.GetActorRef().GetFactionRank(PetFramework_PetFollowingFaction) == 1
		readyMessage.Show()
	endif
endEvent