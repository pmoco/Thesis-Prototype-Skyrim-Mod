Scriptname ccBGSSSE001_CrabMQ4BodyCleanup extends Quest  
{ A first-in, first-out dead body clean-up system for the crabs and guards in Crab MQ4. }

GlobalVariable property ccBGSSSE001_CrabMQ4AllowedDeadCrabs auto
GlobalVariable property ccBGSSSE001_CrabMQ4AllowedDeadGuards auto

ObjectReference[] deadCrabs
ObjectReference[] deadGuards

int currentCrabIndex = 0
int currentGuardIndex = 0

bool workingCrabs = false
bool workingGuards = false

Event OnInit()
	; These array lengths are the upper limit values,
	; globals are used to adjust the total downward if necessary.
	deadCrabs = new ObjectReference[20]
	deadGuards = new ObjectReference[8]
endEvent

function CrabDied(ObjectReference akActorRef)
	while workingCrabs
		Utility.Wait(0.25)
	endWhile
	workingCrabs = true
	if deadCrabs[currentCrabIndex] != None
		deadCrabs[currentCrabIndex].DisableNoWait()
		deadCrabs[currentCrabIndex].Delete()
	endif

	deadCrabs[currentCrabIndex] = akActorRef
	if (currentCrabIndex >= ccBGSSSE001_CrabMQ4AllowedDeadCrabs.GetValueInt() - 1 || currentCrabIndex >= deadCrabs.Length - 1)
		currentCrabIndex = 0
	else
		currentCrabIndex += 1
	endif

	workingCrabs = false 
endFunction

function GuardDied(ObjectReference akActorRef)
	while workingGuards
		Utility.Wait(0.25)
	endWhile
	workingGuards = true
	if deadGuards[currentGuardIndex] != None
		deadGuards[currentGuardIndex].DisableNoWait()
		deadGuards[currentGuardIndex].Delete()
	endif

	deadGuards[currentGuardIndex] = akActorRef
	if (currentGuardIndex >= ccBGSSSE001_CrabMQ4AllowedDeadGuards.GetValueInt() - 1 || currentGuardIndex >= deadGuards.Length - 1)
		currentGuardIndex = 0
	else
		currentGuardIndex += 1
	endif

	workingGuards = false 
endFunction