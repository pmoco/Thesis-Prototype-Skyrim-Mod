Scriptname ccBGSSSE001_CrabMQ4CrabCtrlr extends ObjectReference  
{ Controller script for the Giant Crab. }

Actor property PlayerRef auto
Message property InvulnerableMsg auto
Sound property ccBGSSSE001_NPCGiantMudcrabInjuredSM auto
Explosion property GroundImpactExplosion auto
Explosion property WaterImpactExplosion auto
EffectShader property ghostEffect auto

bool attacksAllowed = false
bool firstAttack = true
bool attacking = false
int deathState = 0
int lastRoll = -1

ObjectReference property RightImpactMarker auto
ObjectReference property RightFarImpactMarker auto
ObjectReference property LeftImpactMarker auto
ObjectReference property LeftFarImpactMarker auto
ObjectReference property LeftNearImpactMarker auto

float property DEATH_FAILSAFE_DURATION = 5.0 AutoReadOnly
float property ATTACK_FAILSAFE_DURATION = 10.0 AutoReadOnly
float property ATTACK_TIME_OFFSET = 2.0 AutoReadOnly

int property ATTACK_ID_LEFT = 0 AutoReadOnly
int property ATTACK_ID_LEFTFAR = 1 AutoReadOnly
int property ATTACK_ID_LEFTNEAR = 2 AutoReadOnly
int property ATTACK_ID_RIGHT = 3 AutoReadOnly
int property ATTACK_ID_RIGHTFAR = 4 AutoReadOnly
; int property ATTACK_ID_RIGHTNEAR AutoReadOnly ; This attack would clip with the fishing shack, so, don't allow.

; Animations
string property ANIM_IDLE = "ForceIdle" AutoReadOnly
string property ANIM_ATTACKLEFT = "AttackLeft" AutoReadOnly
string property ANIM_ATTACKLEFTFAR = "AttackLeftFar" AutoReadOnly
string property ANIM_ATTACKLEFTNEAR = "AttackLeftNear" AutoReadOnly
string property ANIM_ATTACKRIGHT = "AttackRight" AutoReadOnly
string property ANIM_ATTACKRIGHTFAR = "AttackRightFar" AutoReadOnly
; string property ANIM_ATTACKRIGHTNEAR = "AttackRightNear" AutoReadOnly  ; This attack would clip with the fishing shack, so, don't allow.
string property ANIM_DIE = "Die" AutoReadOnly


int property DEATH_STATE_DYING = 1 AutoReadOnly
int property DEATH_STATE_DEAD = 2 AutoReadOnly

; Animation Events
string property ANIM_EVENT_CLAWIMPACT = "ClawImpact" AutoReadOnly
string property ANIM_EVENT_TRANSITIONCOMPLETE = "TransitionComplete" AutoReadOnly

Projectile property CatapultProjectile auto

Auto State ReadyForHit
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; Since it would be possible for this script to ignore a quest-critical hit from the catapults, this purely handles VFX and SFX on hit, for
		; responsiveness. Quest progression happens at the catapults, approximating the time-to-hit.
		GoToState("Busy")
		if akProjectile && akProjectile == CatapultProjectile
			CatapultHit()
		elseif akAggressor == PlayerRef
			InvulnerableMsg.Show()
		endif
		GoToState("ReadyForHit")
	endEvent
endState

State Busy
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; Do nothing
	endEvent
endState

function CatapultHit()
	int id = ccBGSSSE001_NPCGiantMudcrabInjuredSM.Play(self)
endFunction

Event OnLoad()
	ghostEffect.Play(self)
	attacksAllowed = true
	RegisterForAnimationEvent(self, ANIM_EVENT_CLAWIMPACT)
	RegisterForAnimationEvent(self, ANIM_EVENT_TRANSITIONCOMPLETE)

	Utility.Wait(1.0)

	RegisterForNextAttack()
endEvent

Event OnUnload()
	ghostEffect.Stop(self)
	attacksAllowed = false
	UnregisterForAnimationEvent(self, ANIM_EVENT_CLAWIMPACT)
	UnregisterForAnimationEvent(self, ANIM_EVENT_TRANSITIONCOMPLETE)
	UnregisterForUpdate()
endEvent

Event OnUpdate()
	if attacksAllowed
		if attacking
			; Attack failsafe - we shouldn't have received an update while
			; still attacking. Force idle and kick off another one.
			PlayAnimation(ANIM_IDLE)
		endif
		PerformRandomAttack()
	elseif deathState == DEATH_STATE_DEAD
		self.DisableNoWait(true)
	endif
endEvent

function KillEmperorCrabGuardian()
	deathState = DEATH_STATE_DYING
	attacksAllowed = false

	deathState = DEATH_STATE_DEAD
	self.PlayAnimation(ANIM_DIE)

	; Force the crab to disappear after a duration in case something goes wrong with waiting for the
	; animation transition to complete.
	RegisterForSingleUpdate(DEATH_FAILSAFE_DURATION)
endFunction

function RegisterForNextAttack()
	RegisterForSingleUpdate(ATTACK_TIME_OFFSET)
endFunction

function PerformRandomAttack()
	attacking = true
	if firstAttack
		firstAttack = false
		lastRoll = ATTACK_ID_LEFT
	else
		lastRoll = Utility.RandomInt(0, 4)
	endif

	if lastRoll == ATTACK_ID_LEFT
		PlayAnimation(ANIM_ATTACKLEFT)
	elseif lastRoll == ATTACK_ID_LEFTFAR
		PlayAnimation(ANIM_ATTACKLEFTFAR)
	elseif lastRoll == ATTACK_ID_LEFTNEAR
		PlayAnimation(ANIM_ATTACKLEFTNEAR)
	elseif lastRoll == ATTACK_ID_RIGHT
		PlayAnimation(ANIM_ATTACKRIGHT)
	elseif lastRoll == ATTACK_ID_RIGHTFAR
		PlayAnimation(ANIM_ATTACKRIGHTFAR)
	endif

	RegisterForSingleUpdate(ATTACK_FAILSAFE_DURATION)
endFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if asEventName == ANIM_EVENT_CLAWIMPACT
		PlayImpactExplosion()
	elseif asEventName == ANIM_EVENT_TRANSITIONCOMPLETE
		if attacking
			attacking = false
			if deathState < DEATH_STATE_DYING
				RegisterForSingleUpdate(ATTACK_TIME_OFFSET)
			endif
		elseif deathState == DEATH_STATE_DEAD
			self.DisableNoWait()
		endif
	endif
endEvent

function PlayImpactExplosion()
	if lastRoll == 0
		LeftImpactMarker.PlaceAtMe(GroundImpactExplosion)
	elseif lastRoll == 1
		LeftFarImpactMarker.PlaceAtMe(GroundImpactExplosion)
	elseif lastRoll == 2
		LeftNearImpactMarker.PlaceAtMe(GroundImpactExplosion)
	elseif lastRoll == 3
		RightImpactMarker.PlaceAtMe(GroundImpactExplosion)
	elseif lastRoll == 4
		RightFarImpactMarker.PlaceAtMe(WaterImpactExplosion)
	endif
endFunction