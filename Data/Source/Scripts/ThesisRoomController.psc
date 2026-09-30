Scriptname ThesisRoomController extends Quest  


;========================
; Room arrays
;========================
ObjectReference[] Property PrefixRooms Auto
ObjectReference[] Property RandomRooms Auto
ObjectReference[] Property SuffixRooms Auto

String[] Property PrefixLabel Auto
String[] Property RandomLabel  Auto
String[] Property SuffixLabel  Auto

ThesisLoggerScript Property Logger Auto


;========================
; Final sequence
;========================
ObjectReference[] FinalSequence 
string [] LabelFinal
int FinalLength = 0

int CurrentIndex = -1

;========================
; INIT
;========================
Event OnInit()

	

  	FinalSequence =  new ObjectReference[50] ; or safe upper bound
	LabelFinal=  new String [50] ; or safe upper bound


    	BuildSequence()


EndEvent

;========================
; Build Final Sequence
;========================
Function BuildSequence()

    	ShuffleArray(RandomRooms,  RandomLabel)

   	 int i = 0

    ; Prefix
   	int p = 0
    	while (p < PrefixRooms.Length)
        	FinalSequence[i] = PrefixRooms[p]
	 	LabelFinal[i] =PrefixLabel[p]
        	i += 1
        	p += 1
    	endwhile
	


    ; Random
    	int r = 0
    	while (r < RandomRooms.Length)
       	FinalSequence[i] = RandomRooms[r]
	 	LabelFinal[i] = RandomLabel[r]
        	i += 1
        	r += 1
    	endwhile

    ; Suffix
   	 int s = 0
   	 while (s < SuffixRooms.Length)
        	FinalSequence[i] = SuffixRooms[s]
		LabelFinal[i] = SuffixLabel[s]
       	 i += 1
       	 s += 1
    	endwhile
    	FinalLength = i


EndFunction
;========================
; Fisher-Yates Shuffle
;========================
Function ShuffleArray(ObjectReference[] arr,  string[] arrLabel)

	
	if (arr.Length !=  arrLabel.Length)
		Logger.Notify ("Array lenght Error in Random and Lasbel ")

	endif
	int x = 0
    int n = arr.Length
    int i = n - 1

    while (i > 0)
        int j = Utility.RandomInt(0, i)

        ; swap arr[i] and arr[j]
       ObjectReference temp = arr[i]
	String strTemp =  arrLabel[i]
       arr[ i ] = arr[ j ]
       arr[ j ] = temp
	arrLabel[i] = arrLabel[ j ] 
	arrLabel[ j ] =  strTemp

        i -= 1
    endwhile

EndFunction


;========================
; Get next room
;========================
ObjectReference Function GetNextRoom()
    	CurrentIndex += 1
   	if (CurrentIndex >= FinalLength)
       	 CurrentIndex = 0
    	endif
    	ObjectReference nextRoom = FinalSequence[CurrentIndex]
    	return nextRoom

EndFunction

ObjectReference Function GetPrevRoom()
	CurrentIndex -= 1
   	if (CurrentIndex <= 0 )
       	 CurrentIndex = FinalLength + -1 
    	endif
    	ObjectReference prevRoom = FinalSequence[CurrentIndex]

    	return prevRoom 

EndFunction


string Function FinalArraytoString () 
	
	string text = "Cell Order ["+ FinalLength+ "]  = ["
	
	 int i = 0
    	while (i < FinalLength)
		ObjectReference ref = FinalSequence[i]

        	if (ref)
       		Text = text + LabelFinal[ i ]  + ", "      
	   	else
           		text = text + "NONE "

        	endif

       	i += 1
    	endwhile

	text = text + "]"
	
	return text
	
EndFunction




 int Function GetCurrentIndex() 
	return CurrentIndex 
EndFunction 

String Function GetCurrentRoom()
	return LabelFinal[CurrentIndex]
EndFunction 

;========================
; Reset sequence (optional)
;========================
Function ResetSequence()
    CurrentIndex = 0
    BuildSequence()
EndFunction