Scriptname DLC2MiraakScript extends Actor  
{Actor on base DLC2Miraak actors. Attach this if you need your Miraak to appear/disappear and call these functions.}

;Notes: This assumes you only want him to AppearOnLoad once per Appear()/Disappear() function calls

;PLEASE TALK TO jduvall BEFORE EDITING THIS SCRIPT. Thanks :)

bool property AppearOnLoad auto
{Optional: default = false
If true will call the Appear() function without moving him to AppearAtRef, assuming you've already placed him where he needs to be}

ObjectReference Property AppearAtRef auto
{Optional
 When Miraak appears, where he is moved to.
 For example, Player}

ObjectReference Property DisappearToRef auto
{Optional (USE IF AppearOnLoad is true - other wise next time you are in the area he will appear)
When Miraak disappears, where he is moved to. 
For example:
DLC2SoulStealMiraakSpawnMarker in DLC2aaaMarkers cell - an xmarker in a holding cell}

Explosion Property DLC2MiraakTeleportExp auto
Explosion Property DLC2MiraakTeleportReturnExp auto



EffectShader property DLC2MiraakTeleportStartFXS auto
EffectShader property DLC2MiraakTeleportReturnFXS auto

int SoulStealInternalState = -1 ; The animation state for Miraak while appearing/disappearing. 0 is Appearing, 1 is disappearing.
bool LastMoveToAppearAtRef
bool LastUseIMOD

ImageSpaceModifier Property DLC2MiraakTeleportIMODStatic auto

bool Appeared
bool CrossFadeUpdating = false

Event OnUpdate()
;	debug.trace(self + "OnUpdate()")
	;assumes this is only ever called for the IMOD effect
	
	; SoulStealInternalState should be in -1 if not needing something specific here.
	; These are built in delays for soul stealing.
	if SoulStealInternalState == 0
		; Attempting to Appear
		DelayedAppear()
		CrossFadeOnUpdate()
	elseif SoulStealInternalState == 1
		DelayedDisappear()
	endif

EndEvent

Function CrossFadeOnUpdate()
;	debug.trace(self + "CrossFadeOnUpdate()")
	if CrossFadeUpdating || LastUseIMOD == false
		return
	endif

	debug.trace(self + "CrossFadeOnUpdate()")
	bool IMOD = false

	int distance = 1500

	While Appeared
		CrossFadeUpdating = true
		if GetDistance(Game.GetPlayer()) <= distance && IMOD == false
			IMOD = true
			DLC2MiraakTeleportIMODStatic.ApplyCrossFade(3)
		endif
		
		if GetDistance(Game.GetPlayer()) > distance && IMOD == true
			IMOD = false
			ImageSpaceModifier.RemoveCrossFade(3)
		endif
	endWhile
	CrossFadeUpdating = false
EndFunction

Function OnLoad()
;	debug.trace(self + "OnLoad")
	if AppearOnLoad && Appeared == false
		Appeared = true
		Appear(MoveToAppearAtRef = false)
	else
		;Stay invisible damn you Miraak!
		setAlpha(0)
	endif

EndFunction

Function Appear(bool MoveToAppearAtRef = true, bool UseIMOD = true)
;	debug.trace(self + "Appear()")

	SoulStealInternalState = 0;
	LastMoveToAppearAtRef = MoveToAppearAtRef
	LastUseIMOD = UseIMOD
	Appeared = true
	
	if IsDisabled()
		debug.trace(self + "Appear() - Reenabling")
		Enable()
	endif
	
; 	debug.trace(self + "setAlpha(0)")
	setAlpha(0)
	
	RegisterForSingleUpdate(0.001)
EndFunction

Function DelayedAppear()
;	debug.trace(self + "DelayedAppear()")

	if SoulStealInternalState != 0
		return
	endif
	debug.trace(self + "DelayedAppear()")
	
	;Stay invisible damn you Miraak!
	setAlpha(0)

	if LastMoveToAppearAtRef && AppearAtRef
		MoveTo(AppearAtRef, 200)
	endif

; 	debug.trace(self + "Placing Explosion.")	
	PlaceAtMe(DLC2MiraakTeleportExp)

; 	debug.trace(self + "Waiting...")	
	SoulStealInternalState = -1 ; Unfortunatly, got to do this before the utility.wait call.
	
	utility.wait(2)
	
	debug.trace(self + "DelayedAppear() - setAlpha (1, true)")
	setAlpha(1, true)

	DLC2MiraakTeleportStartFXS.play(self)
	SoulStealInternalState = -1
EndFunction

Function Disappear()
	if Appeared == false
		return
	endif

	debug.trace(self + "Disappear()")

	Appeared = false
	SoulStealInternalState = 1;
	
	RegisterForSingleUpdate(0.001)
EndFunction

Function DelayedDisappear()
;	debug.trace(self + "DelayedDisappear()")

	HandleReturnTeleportExplodeExp()
	DLC2MiraakTeleportReturnFXS.play(self)
	
	utility.wait(0.5)
	
	StartMiraakFadeOut()
EndFunction

Function HandleReturnTeleportExplodeExp()
	; Separating this out so it hopefully stops hanging the rest of the fade out functionality.
	Debug.Trace(self + "HandleTeleportExplode()")

	if DLC2MiraakTeleportReturnExp != None
		placeAtMe(DLC2MiraakTeleportReturnExp)
	else
		debug.trace(self + "HandleTeleportExplode() - Failed to load DLC2MiraakTeleportReturnExp")
	endif
EndFunction

Function StartMiraakFadeOut()
;	debug.trace(self + "StartMiraakFadeOut()")

	ImageSpaceModifier.RemoveCrossFade(3)

	setAlpha(0.1, true) ; On the wiki, it says (0, true) should not work. So this set up is the next best thing.

	SoulStealInternalState = -1
	
	utility.wait(0.3)
	AfterMiraakFadeOut()
EndFunction

Function AfterMiraakFadeOut()
;	debug.trace(self + "AfterMiraakFadeOut()")
	setAlpha(0)
	
	if DisappearToRef
		MoveTo(DisappearToRef)
	endif
	
	utility.wait (0.001)
	setAlpha(0)
	Disable()
EndFunction