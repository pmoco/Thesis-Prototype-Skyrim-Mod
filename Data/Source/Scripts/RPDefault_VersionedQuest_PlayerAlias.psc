Scriptname RPDefault_VersionedQuest_PlayerAlias extends ReferenceAlias
{ Must go on an alias pointing at the player. For use with quests using RPDefault_VersionedQuest. }

Event OnPlayerLoadGame()
    (GetOwningQuest() as RPDefault_VersionedQuest).TriggerGameLoaded()
EndEvent