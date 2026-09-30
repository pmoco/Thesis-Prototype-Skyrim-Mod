Scriptname DLC1PrisonerAliasScript extends WEPrisonerAliasScript  
{Extends WEPrisonerAliasScript to set a stage when freed}

int Property StageToSetWhenFreed auto

Function FreePrisoner(Actor ActorRef, bool playerIsLiberator= true, bool OpenInventory = False)
; 	debug.trace(self + "FreePrisoner(" + ActorRef + "," + playerIsLiberator + ", " + OpenInventory +")")	
	GetOwningQuest().SetStage(StageToSetWhenFreed)

	Parent.FreePrisoner(ActorRef, playerIsLiberator, OpenInventory)
		
EndFunction