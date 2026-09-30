scriptname ccBGSSSE025_HarvestableActivator extends ObjectReference

Ingredient property itemToHarvest auto
LeveledItem property leveledRareCuriosItem auto
GlobalVariable property isRareCuriosLoaded auto
bool property useRareCuriosItem = false auto
Actor property PlayerRef auto
Sound property HarvestSound auto
Message property harvestFailedMsg auto
Perk Property GreenThumb auto

bool needsReset = false

Auto State Ready
	Event OnActivate(ObjectReference akActivator)
		if akActivator == PlayerRef
			GoToState("Harvested")
			int harvestQuantity = 1
			if PlayerRef.HasPerk(GreenThumb)
				harvestQuantity = 2
			endif
			if useRareCuriosItem && isRareCuriosLoaded.GetValueInt() == 1
				PlayerRef.AddItem(leveledRareCuriosItem, harvestQuantity)
			else
				PlayerRef.AddItem(itemToHarvest, harvestQuantity)
			endif
			HarvestSound.Play(self)
			self.PlayAnimation("Harvest")
		endif
	endEvent
endState

State Harvested
	Event OnActivate(ObjectReference akActivator)
		harvestFailedMsg.Show()
	endEvent
endState

Event OnReset()
	if Is3DLoaded()
		RegisterForSingleUpdate(2)
	else
		needsReset = true
	endif
EndEvent

Event OnUpdate()
	GoToState("Ready")
	self.PlayAnimation("Reset")
	needsReset = false
endEvent

Event OnLoad()
    if needsReset
        RegisterForSingleUpdate(2)
    endif
endEvent