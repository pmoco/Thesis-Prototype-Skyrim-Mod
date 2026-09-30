scriptname DefaultAddMessageToHelpMenuScript extends Quest
{ A default script to add messages to the in-game Help Menu. }

Message property TheMessage auto
{ The message to add to the Help Menu. }

FormList property HelpManualPC auto
{ Auto-Fill }

FormList property HelpManualXBox auto
{ Auto-Fill }

Event OnInit()
    if HelpManualPC.Find(TheMessage) < 0
        HelpManualPC.AddForm(TheMessage)
    endif

    if HelpManualXBox.Find(TheMessage) < 0
        HelpManualXBox.AddForm(TheMessage)
    endif
endEvent