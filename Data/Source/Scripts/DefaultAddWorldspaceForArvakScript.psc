scriptname DefaultAddWorldspaceForArvakScript extends Quest
{ A default script to add additional worldspaces to Arvak's list of available locations. }

Worldspace property WorldspaceToAdd auto
{ The message to add to the Help Menu. }


FormList property RidableWorldSpaces auto
{ Auto-Fill }

Event OnInit()
    if RidableWorldSpaces.Find(WorldspaceToAdd) < 0
        RidableWorldSpaces.AddForm(WorldspaceToAdd)
    endif
endEvent