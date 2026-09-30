Scriptname ccBGSSSE001_AddIngredientAndDisable extends ObjectReference  
{ Adds an ingredient to the player and then disables this reference. For faking a flora-type pick-up. }

Ingredient property IngredientToAdd auto
Sound property harvestSound auto

Auto State Ready
	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		Actor player = Game.GetPlayer()
		if akActionRef == player
			GoToState("Done")
			player.AddItem(IngredientToAdd)
			harvestSound.Play(self)
			DisableNoWait()
		else
			GoToState("Ready")
		endIf
	endEvent
endState

State Busy
	Event OnActivate(ObjectReference akActionRef)
		; Do nothing
	endEvent
endState

State Done
	Event OnActivate(ObjectReference akActionRef)
		; Do nothing
	endEvent
endState