Scriptname RPDefault_AddToInstalledContentMenu extends Quest  
{A default script to add messages to the in-game Installed Content Menu.}

Message property TheMessage auto
{ The message to add to the Installed Content Menu. }

FormList property HelpManualInstalledContent auto
{ Auto-Fill }

FormList property HelpManualInstalledContentAE auto
{ Auto-Fill }

Event OnInit()
    if HelpManualInstalledContent.Find(TheMessage) < 0
        HelpManualInstalledContent.AddForm(TheMessage)
    endif

    if HelpManualInstalledContentAE.Find(TheMessage) < 0
        HelpManualInstalledContentAE.AddForm(TheMessage)
    endif
endEvent