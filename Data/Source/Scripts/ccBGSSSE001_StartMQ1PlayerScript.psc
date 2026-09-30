Scriptname ccBGSSSE001_StartMQ1PlayerScript extends ReferenceAlias  

FormList property ccBGSSSE001_FishingRods auto
int property startingQuestStageFoundCamp auto
int property startingQuestStageRodEquipped auto
Quest property MyQuest auto

; Check if the player equipped a fishing rod for the first time.
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if MyQuest.GetStage() >= startingQuestStageFoundCamp && ccBGSSSE001_FishingRods.Find(akBaseObject) > -1
		GetOwningQuest().SetStage(startingQuestStageRodEquipped)
	endif
endEvent