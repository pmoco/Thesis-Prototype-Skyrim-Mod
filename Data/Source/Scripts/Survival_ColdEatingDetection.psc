scriptname Survival_ColdEatingDetection extends ReferenceAlias

FormList property Survival_FoodRestoreCold auto
GlobalVariable property Survival_ColdRestoreMediumAmount auto
Quest property Survival_NeedColdQuest auto
Message property Survival_WarmFoodMessage auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	; Restore Cold
	if akBaseObject as Potion
		if Survival_FoodRestoreCold.HasForm(akBaseObject)
			; Survival_WarmFoodMessage.Show()
			Survival_NeedCold Cold = Survival_NeedColdQuest as Survival_NeedCold
			Cold.DecreaseCold(Survival_ColdRestoreMediumAmount.GetValue(), Cold.needStage1Value)
		endif
	endif
EndEvent