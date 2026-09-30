scriptname ccBGSSSE001_FishPlaqueScript extends ObjectReference

Actor property PlayerRef auto
FormList property ccBGSSSE001_FishPlaqueGiftFilterList auto
{ The list of all fish that can be placed on this plaque. }
FormList property ccBGSSSE001_FishPlaqueSmallFishList auto
FormList property ccBGSSSE001_FishPlaqueLargeFishList auto
FormList property ccBGSSSE001_FishPlaqueXLargeFishList auto
Keyword property ccBGSSSE001_FishPlaqueSmallFishMarkerKW auto
{ The keyword of the small fish linked marker reference. }
Keyword property ccBGSSSE001_FishPlaqueLargeFishMarkerKW auto
{ The keyword of the large fish linked marker reference. }
Keyword property ccBGSSSE001_FishPlaqueXLargeFishMarkerKW auto
{ The keyword of the x-large fish linked marker reference. }
Keyword property ccBGSSSE001_FishPlaqueActivatorKW auto
{ The keyword of the activator linked marker reference. }
ccBGSSSE001_FishPlaqueContainerScript property PlaqueContainer auto
{ The actor that handles giving a fish to this plaque. }
ccBGSSSE001_FishPlaqueAliasScript property PlaqueFishAlias auto
{ The reference alias for the displayed fish. Set per-reference. }

function PlaqueActivated()
	PlaqueContainer.SetPlaque(self)
	PlaqueFishAlias.SetPlaque(self)
	PlaqueContainer.ShowGiftMenu(abGivingGift = true, apFilterList = ccBGSSSE001_FishPlaqueGiftFilterList, abShowStolenItems = true, abUseFavorPoints = false)
endFunction

function DisplayFish(Form akFish)
	; Move and position the fish
	ObjectReference theFish = PlaqueContainer.DropObject(akFish)
	if theFish
		; We can't disable the fish plaque activator since it has an enable state parent, so move it instead
		GetLinkedRef(ccBGSSSE001_FishPlaqueActivatorKW).MoveTo(self, abMatchRotation = false)

		PositionFishAndDisablePhysics(theFish)
		PlaqueFishAlias.ForceRefTo(theFish)

		; Re-enable activation
		theFish.BlockActivation(false)
	endif
endFunction

bool function IsFishDisplayed()
	return PlaqueFishAlias.GetRef()
endFunction

function PositionFishAndDisablePhysics(ObjectReference akFishOnDisplayRef)
	if akFishOnDisplayRef
		akFishOnDisplayRef.MoveTo(PlayerRef)
		akFishOnDisplayRef.BlockActivation()

		while !akFishOnDisplayRef.Is3DLoaded()
			Utility.Wait(0.1)
		endWhile

		akFishOnDisplayRef.SetMotionType(Motion_Keyframed, false)

		ObjectReference displayMarker
		Form akFishForm = akFishOnDisplayRef.GetBaseObject()
		if ccBGSSSE001_FishPlaqueSmallFishList.HasForm(akFishForm)
			displayMarker = GetLinkedRef(ccBGSSSE001_FishPlaqueSmallFishMarkerKW)
		elseif ccBGSSSE001_FishPlaqueLargeFishList.HasForm(akFishForm)
			displayMarker = GetLinkedRef(ccBGSSSE001_FishPlaqueLargeFishMarkerKW)
		elseif ccBGSSSE001_FishPlaqueXLargeFishList.HasForm(akFishForm)
			displayMarker = GetLinkedRef(ccBGSSSE001_FishPlaqueXLargeFishMarkerKW)
		endif

		akFishOnDisplayRef.MoveTo(displayMarker)
	endif
endFunction

function FishTaken(ObjectReference akFish)
	PlaqueFishAlias.Clear()

	; We can't enable the fish plaque activator since it has an enable state parent, so move it instead
	GetLinkedRef(ccBGSSSE001_FishPlaqueActivatorKW).MoveTo(GetLinkedRef(), abMatchRotation = false)
endFunction