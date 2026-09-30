Scriptname ccBGSSSE001_SwapOutfitOnCellAttach extends ReferenceAlias  

ReferenceAlias property FalkreathJarl auto
Actor property ImperialJarl auto
Actor property SonsJarl auto
Outfit property ImperialOutfit auto
Outfit property SonsOutfit auto
Weapon property ImperialWeapon auto
Weapon property SonsWeapon auto

Event OnCellAttach()
	Actor jarl = FalkreathJarl.GetActorRef()
	Actor mySelf = self.GetActorRef()
	if jarl == ImperialJarl
		mySelf.SetOutfit(ImperialOutfit)
		mySelf.RemoveItem(SonsWeapon)
		mySelf.AddItem(ImperialWeapon)
	elseif jarl == SonsJarl
		mySelf.SetOutfit(SonsOutfit)
		mySelf.RemoveItem(ImperialWeapon)
		mySelf.AddItem(SonsWeapon)
	endif
endEvent
