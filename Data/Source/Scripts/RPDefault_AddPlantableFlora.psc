Scriptname RPDefault_AddPlantableFlora extends Quest
{ Makes Flora compatible with Hearthfire soil plots. }

FormList property flPlanterPlantedFlora auto
{ Auto-Fill }
FormList property flPlanterPlantableItem auto
{ Auto-Fill }
Ingredient property PlantableIngredient  auto
{ Ingredient to plant }
Flora property PlantableFlora auto
{ Flora to spawn in soil }

Event OnInit()
    AddPlantableFlora()
endEvent

Function AddPlantableFlora()
    if flPlanterPlantedFlora.Find(PlantableFlora) < 0
        flPlanterPlantedFlora.AddForm(PlantableFlora)
    endif
    if flPlanterPlantableItem.Find(PlantableIngredient) < 0
        flPlanterPlantableItem.AddForm(PlantableIngredient)
    endif    
EndFunction