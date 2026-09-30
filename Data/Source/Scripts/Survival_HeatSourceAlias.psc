scriptname Survival_HeatSourceAlias extends ReferenceAlias

ObjectReference property HeatSourceTrigger auto
{ The heat source trigger for this alias. }

ObjectReference property Survival_HeatSourceReturnRef auto
{ Where to send the trigger box when not in use. }

Survival_HeatCheck property Heat auto
int property HeatAliasIndex auto

Event OnInit()
	ObjectReference currentRef = self.GetReference()

	if currentRef
		if currentRef != Heat.LastKnownHeatRefs[HeatAliasIndex]
			HeatSourceTrigger.MoveTo(currentRef)
			Heat.LastKnownHeatRefs[HeatAliasIndex] = currentRef
		endif
	else
		HeatSourceTrigger.MoveTo(Survival_HeatSourceReturnRef)
	endif
EndEvent
