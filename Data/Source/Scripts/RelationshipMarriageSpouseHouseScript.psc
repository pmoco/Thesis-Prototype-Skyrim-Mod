ScriptName RelationshipMarriageSpouseHouseScript extends Quest Conditional

Quest Property BYOHRelationshipAdoption Auto

ReferenceAlias Property SolitudeHouse  Auto  
ReferenceAlias Property WindhelmHouse  Auto  
ReferenceAlias Property MarkarthHouse  Auto  
ReferenceAlias Property RiftenHouse  Auto  
ReferenceAlias Property WhiterunHouse  Auto  
ReferenceAlias Property FalkreathHouse Auto
ReferenceAlias Property HjaalmarchHouse Auto
ReferenceAlias Property PaleHouse Auto
ReferenceAlias Property SpouseHouse Auto

ReferenceAlias property CCHouse01 auto
ReferenceAlias property CCHouse02 auto
ReferenceAlias property CCHouse03 auto
ReferenceAlias property CCHouse04 auto
ReferenceAlias property CCHouse05 auto
ReferenceAlias property CCHouse06 auto
ReferenceAlias property CCHouse07 auto
ReferenceAlias property CCHouse08 auto
ReferenceAlias property CCHouse09 auto
ReferenceAlias property CCHouse10 auto
ReferenceAlias property CCHouse11 auto
ReferenceAlias property CCHouse12 auto
ReferenceAlias property CCHouse13 auto
ReferenceAlias property CCHouse14 auto
ReferenceAlias property CCHouse15 auto
ReferenceAlias property CCHouse16 auto
ReferenceAlias property CCHouse17 auto
ReferenceAlias property CCHouse18 auto
ReferenceAlias property CCHouse19 auto
ReferenceAlias property CCHouse20 auto

Faction Property JobBlacksmithFaction Auto
Faction Property JobSpellFaction Auto
Faction Property JobApothecaryFaction Auto
Faction Property JobInnkeeperFaction Auto
Faction Property JobMiscFaction Auto

int property SpouseCurrentHome Auto Conditional Hidden


Function MoveSpouseAdoption (Actor Spouse, int NewHouse)
; 	Debug.Trace("MoveSpouseAdoption called.")
	MoveSpouse(Spouse, TranslateHouseIntToAlias(NewHouse))
EndFunction

Function MoveSpouse (Actor Spouse, ReferenceAlias NewHouse)
	;If Adoption is running, and we haven't moved the spouse yet, queue up a move to make sure the family stays together. Let the spouse start walking, though.
	If (BYOHRelationshipAdoption.IsRunning() && (BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).FirstMoveWithSpouse)
; 		Debug.Trace("MoveSpouse is queuing an Initial Move to:" + TranslateHouseAliasToInt(NewHouse))
		(BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).QueueMoveFamily(TranslateHouseAliasToInt(NewHouse), True)
	EndIf
	
	;If the Adoption system is running, RelationshipMarriage just queues a move.
	;The actual move occurs when RelationshipAdoption calls MoveSpouseAdoption with AllowSpouseToMove=True, triggering the actual move.
	If (BYOHRelationshipAdoption.IsRunning() && !(BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).AllowSpouseToMove)
; 		Debug.Trace("MoveSpouse is queuing a Standard Move to:" + TranslateHouseAliasToInt(NewHouse))
		(BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).QueueMoveFamily(TranslateHouseAliasToInt(NewHouse))
	EndIf
	
	;Allow the spouse to walk away if Adoption isn't running (as in the base game), or if Adoption has had its input.
	If (!BYOHRelationshipAdoption.IsRunning() || (BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).AllowSpouseToMove)
		;Function puts the player spouse in the correct alias to sandbox in the appropriate house
		;Clear all the other house aliases before setting the new one
		
; 		Debug.Trace("MoveSpouse has updated the Spouse's packages.")
	
		If SolitudeHouse
			SolitudeHouse.Clear()
		EndIf

		If WindhelmHouse
			WindhelmHouse.Clear()
		EndIf

		If MarkarthHouse
			MarkarthHouse.Clear()
		EndIf

		If RiftenHouse	
			RiftenHouse.Clear()
		EndIf

		If WhiterunHouse
			WhiterunHouse.Clear()
		EndIf

		If FalkreathHouse
			FalkreathHouse.Clear()
		EndIf

		If HjaalmarchHouse
			HjaalmarchHouse.Clear()
		EndIf

		If PaleHouse
			PaleHouse.Clear()
		EndIf

		If SpouseHouse
			SpouseHouse.Clear()
		EndIf

		; Creation Club houses
		if CCHouse01
			CCHouse01.Clear()
		endif

		if CCHouse02
			CCHouse02.Clear()
		endif

		if CCHouse03
			CCHouse03.Clear()
		endif

		if CCHouse04
			CCHouse04.Clear()
		endif

		if CCHouse05
			CCHouse05.Clear()
		endif

		if CCHouse06
			CCHouse06.Clear()
		endif

		if CCHouse07
			CCHouse07.Clear()
		endif

		if CCHouse08
			CCHouse08.Clear()
		endif

		if CCHouse09
			CCHouse09.Clear()
		endif

		if CCHouse10
			CCHouse10.Clear()
		endif

		if CCHouse11
			CCHouse11.Clear()
		endif

		if CCHouse12
			CCHouse12.Clear()
		endif

		if CCHouse13
			CCHouse13.Clear()
		endif

		if CCHouse14
			CCHouse14.Clear()
		endif

		if CCHouse15
			CCHouse15.Clear()
		endif

		if CCHouse16
			CCHouse16.Clear()
		endif

		if CCHouse17
			CCHouse17.Clear()
		endif

		if CCHouse18
			CCHouse18.Clear()
		endif

		if CCHouse19
			CCHouse19.Clear()
		endif

		if CCHouse20
			CCHouse20.Clear()
		endif

		NewHouse.ForceRefTo(Spouse)
		SpouseCurrentHome = TranslateHouseAliasToInt(NewHouse)
	EndIf	
EndFunction

Function SpouseShop (Actor Spouse)

	;Function checks to see if the player was a vendor before, if not, make them a MiscVendor
	If (Spouse.IsInFaction(JobBlacksmithFaction) == 0) && (Spouse.IsInFaction(JobSpellFaction) == 0) && (Spouse.IsInFaction(JobInnkeeperFaction) ==0) && (Spouse.IsInFaction(JobApothecaryFaction) == 0) && (Spouse.IsInFaction(JobMiscFaction) == 0)
		Spouse.AddtoFaction(JobMiscFaction)
		Spouse.AddtoFaction(JobMerchantFaction)
	EndIf

EndFunction

Faction Property JobMerchantFaction  Auto  


int Function TranslateHouseAliasToInt(ReferenceAlias NewHouse)
	if (newHouse == SolitudeHouse)
		return 1
	ElseIf (newHouse == WindhelmHouse)
		return 2
	ElseIf (newHouse == MarkarthHouse)
		return 3
	ElseIf (newHouse == RiftenHouse)
		return 4
	ElseIf (newHouse == WhiterunHouse)
		return 5
	ElseIf (newHouse == FalkreathHouse)
		return 6
	ElseIf (newHouse == HjaalmarchHouse)
		return 7
	ElseIf (newHouse == PaleHouse)
		return 8

	; Check CC Houses
	ElseIf (newHouse == CCHouse01)
		return 101
	ElseIf (newHouse == CCHouse02)
		return 102
	ElseIf (newHouse == CCHouse03)
		return 103
	ElseIf (newHouse == CCHouse04)
		return 104
	ElseIf (newHouse == CCHouse05)
		return 105
	ElseIf (newHouse == CCHouse06)
		return 106
	ElseIf (newHouse == CCHouse07)
		return 107
	ElseIf (newHouse == CCHouse08)
		return 108
	ElseIf (newHouse == CCHouse09)
		return 109
	ElseIf (newHouse == CCHouse10)
		return 110
	ElseIf (newHouse == CCHouse11)
		return 111
	ElseIf (newHouse == CCHouse12)
		return 112
	ElseIf (newHouse == CCHouse13)
		return 113
	ElseIf (newHouse == CCHouse14)
		return 114
	ElseIf (newHouse == CCHouse15)
		return 115
	ElseIf (newHouse == CCHouse16)
		return 116
	ElseIf (newHouse == CCHouse17)
		return 117
	ElseIf (newHouse == CCHouse18)
		return 118
	ElseIf (newHouse == CCHouse19)
		return 119
	ElseIf (newHouse == CCHouse20)
		return 120
	EndIf

; 	Debug.Trace("RelationshipMarriageSpouseHouseScript Alias Translation Error!")
	return -1
EndFunction

ReferenceAlias Function TranslateHouseIntToAlias(int NewHouse)
	if (newHouse == 1)
		return SolitudeHouse
	ElseIf (newHouse == 2)
		return WindhelmHouse
	ElseIf (newHouse == 3)
		return MarkarthHouse
	ElseIf (newHouse == 4)
		return RiftenHouse
	ElseIf (newHouse == 5)
		return WhiterunHouse
	ElseIf (newHouse == 6)
		return FalkreathHouse
	ElseIf (newHouse == 7)
		return HjaalmarchHouse
	ElseIf (newHouse == 8)
		return PaleHouse

	; Check CC Houses
	ElseIf (newHouse == 101)
		return CCHouse01
	ElseIf (newHouse == 102)
		return CCHouse02
	ElseIf (newHouse == 103)
		return CCHouse03
	ElseIf (newHouse == 104)
		return CCHouse04
	ElseIf (newHouse == 105)
		return CCHouse05
	ElseIf (newHouse == 106)
		return CCHouse06
	ElseIf (newHouse == 107)
		return CCHouse07
	ElseIf (newHouse == 108)
		return CCHouse08
	ElseIf (newHouse == 109)
		return CCHouse09
	ElseIf (newHouse == 110)
		return CCHouse10
	ElseIf (newHouse == 111)
		return CCHouse11
	ElseIf (newHouse == 112)
		return CCHouse12
	ElseIf (newHouse == 113)
		return CCHouse13
	ElseIf (newHouse == 114)
		return CCHouse14
	ElseIf (newHouse == 115)
		return CCHouse15
	ElseIf (newHouse == 116)
		return CCHouse16
	ElseIf (newHouse == 117)
		return CCHouse17
	ElseIf (newHouse == 118)
		return CCHouse18
	ElseIf (newHouse == 119)
		return CCHouse19
	ElseIf (newHouse == 120)
		return CCHouse20
	EndIf
	
; 	Debug.Trace("RelationshipMarriageSpouseHouseScript Int Translation Error!")
	return None
EndFunction

Function UpdateSpouseHouseInt()
	if (SolitudeHouse.GetActorRef() != None)
		SpouseCurrentHome = 1
	ElseIf (WindhelmHouse.GetActorRef() != None)
		SpouseCurrentHome = 2
	ElseIf (MarkarthHouse.GetActorRef() != None)
		SpouseCurrentHome = 3
	ElseIf (RiftenHouse.GetActorRef() != None)
		SpouseCurrentHome = 4
	ElseIf (WhiterunHouse.GetActorRef() != None)
		SpouseCurrentHome = 5
	ElseIf (FalkreathHouse.GetActorRef() != None)
		SpouseCurrentHome = 6
	ElseIf (HjaalmarchHouse.GetActorRef() != None)
		SpouseCurrentHome = 7
	ElseIf (PaleHouse.GetActorRef() != None)
		SpouseCurrentHome = 8

	; Check CC Houses
	ElseIf (CCHouse01.GetActorRef() != None)
		SpouseCurrentHome = 101
	ElseIf (CCHouse02.GetActorRef() != None)
		SpouseCurrentHome = 102
	ElseIf (CCHouse03.GetActorRef() != None)
		SpouseCurrentHome = 103
	ElseIf (CCHouse04.GetActorRef() != None)
		SpouseCurrentHome = 104
	ElseIf (CCHouse05.GetActorRef() != None)
		SpouseCurrentHome = 105
	ElseIf (CCHouse06.GetActorRef() != None)
		SpouseCurrentHome = 106
	ElseIf (CCHouse07.GetActorRef() != None)
		SpouseCurrentHome = 107
	ElseIf (CCHouse08.GetActorRef() != None)
		SpouseCurrentHome = 108
	ElseIf (CCHouse09.GetActorRef() != None)
		SpouseCurrentHome = 109
	ElseIf (CCHouse10.GetActorRef() != None)
		SpouseCurrentHome = 110
	ElseIf (CCHouse11.GetActorRef() != None)
		SpouseCurrentHome = 111
	ElseIf (CCHouse12.GetActorRef() != None)
		SpouseCurrentHome = 112
	ElseIf (CCHouse13.GetActorRef() != None)
		SpouseCurrentHome = 113
	ElseIf (CCHouse14.GetActorRef() != None)
		SpouseCurrentHome = 114
	ElseIf (CCHouse15.GetActorRef() != None)
		SpouseCurrentHome = 115
	ElseIf (CCHouse16.GetActorRef() != None)
		SpouseCurrentHome = 116
	ElseIf (CCHouse17.GetActorRef() != None)
		SpouseCurrentHome = 117
	ElseIf (CCHouse18.GetActorRef() != None)
		SpouseCurrentHome = 118
	ElseIf (CCHouse19.GetActorRef() != None)
		SpouseCurrentHome = 119
	ElseIf (CCHouse20.GetActorRef() != None)
		SpouseCurrentHome = 120
	EndIf
EndFunction
