Scriptname RPDefault_CalendarDayEnablerScript extends ObjectReference
{A default script to enable a marker on a specific day of the year.  Marker is disabled on all other days.}

ObjectReference Property EnableMarker Auto
{ Marker to enable. }

Int Property EnableMonth Auto
{ Month for the marker to enable in. }

Int Property EnableDay Auto
{ Day for the marker to enable on. }

GlobalVariable Property GameMonth Auto
{ Auto-Fill }

GlobalVariable Property GameDay Auto
{ Auto-Fill }


Event OnLoad()
	; Enable my marker on the specified day of the month.
	if GameMonth.GetValueInt() == EnableMonth && GameDay.GetValueInt() == EnableDay
		EnableMarker.EnableNoWait()
    else
        EnableMarker.DisableNoWait()
	endif
EndEvent