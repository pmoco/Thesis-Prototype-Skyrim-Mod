Scriptname RPDefault_Math

Float Function GetPi() global
	return 3.1415926
EndFunction

Float Function Min(Float aNum01, Float aNum02) global
	if(aNum01 < aNum02)
		return aNum01
	else
		return aNum02
	endif
EndFunction

Float Function Max(Float aNum01, Float aNum02) global
	if(aNum01 > aNum02)
		return aNum01
	else
		return aNum02
	endif
EndFunction

Float Function Clamp(Float aNum, Float afMin, Float afMax) global
	return Max(afMin, Min(afMax, aNum))
EndFunction



Float Function Atan2(Float afA, Float afB) global
	Float fValue = 0.0
    if(afB > 0)
        fValue = Math.Atan(afA/afB);
    elseif(afB < 0)
		if(afA >= 0)
			fValue = Math.Atan(afA/afB) + 180.0
		else
			fValue = Math.Atan(afA/afB) - 180.0
		endif
    elseif(afA > 0)
		fValue = 90.0
	elseif(afA < 0)
        fValue = -90.0
    endif
	
    return fValue
EndFunction


Float Function Atan2Rad(Float afA, Float afB) global
	Float fValue = 0.0
    if(afB > 0)
        fValue = Math.Atan(afA/afB);
    elseif(afB < 0)
		if(afA >= 0)
			fValue = Math.Atan(afA/afB) + GetPi()
		else
			fValue = Math.Atan(afA/afB) - GetPi()
		endif
    elseif(afA > 0)
		fValue = GetPi() / 2
	elseif(afA < 0)
        fValue = 0 - (GetPi() / 2 )
	; else both equal 0, which we can't calculate
    endif
	
    return fValue
EndFunction

	

Int Function Log2n(Int aiNum) global
	int iLog = 0
	int iCalc = aiNum
	while(iCalc > 1)
		iCalc = iCalc/2
		iLog += 1
	endWhile
	
	return iLog
EndFunction


Float[] Function GetOffset3dData(Float[] afStartPosition, Float[] afStartAngle, Float[] afOffsetPosition, Float[] afOffsetAngle) global
	;Debug.Trace("GetOffset3dData >>>>>>> ")
	;Debug.Trace("     Position: " + afStartPosition)
	;Debug.Trace("     Angle: " + afStartAngle)
	;Debug.Trace("     Offset Pos: " + afOffsetPosition)
	;Debug.Trace("     Offset Angle: " + afOffsetAngle)
	
	Float[] fNew3dData = new Float[6]
	; Calculate new position - matrix multiply starting angle by the offset, then add to start position
	Float[] fStartAngleMatrix = CreateMatrixFromEuler(afStartAngle[0], afStartAngle[1], afStartAngle[2])
	;Debug.Trace("     Start Angle Matrix: " + fStartAngleMatrix)
	fNew3dData[0] = (fStartAngleMatrix[0] * afOffsetPosition[0]) + (fStartAngleMatrix[1] * afOffsetPosition[1]) + (fStartAngleMatrix[2] * afOffsetPosition[2]) + afStartPosition[0]
	fNew3dData[1] = (fStartAngleMatrix[3] * afOffsetPosition[0]) + (fStartAngleMatrix[4] * afOffsetPosition[1]) + (fStartAngleMatrix[5] * afOffsetPosition[2]) + afStartPosition[1]
	fNew3dData[2] = (fStartAngleMatrix[6] * afOffsetPosition[0]) + (fStartAngleMatrix[7] * afOffsetPosition[1]) + (fStartAngleMatrix[8] * afOffsetPosition[2]) + afStartPosition[2]
	
	; Calculate new angle with quaternions
	Float[] fStartQuat = CreateQuaternionFromEuler(afStartAngle[0], afStartAngle[1], afStartAngle[2])
	;Debug.Trace("     Start Angle as Quaternion: " + fStartQuat)
	Float[] fNewQuat = CreateQuaternionFromEuler(afOffsetAngle[0], afOffsetAngle[1], afOffsetAngle[2])
	;Debug.Trace("     Offset Angle as Quaternion: " + fNewQuat)
	fNewQuat = MultiplyQuaternions(fStartQuat, fNewQuat)
	;Debug.Trace("     New Angle as Quaternion: " + fNewQuat)
	Float[] fEuler = CreateEulerFromQuaternion(fNewQuat)
	;Debug.Trace("     New Angle as Euler: " + fEuler)
		
	fEuler[0] = NormalizeAngle(fEuler[0])
	fEuler[1] = NormalizeAngle(fEuler[1])
	fEuler[2] = NormalizeAngle(fEuler[2])
	
	;Debug.Trace("     New Angle Normalized: " + fEuler)
	
	fNew3dData[3] = fEuler[0]
	fNew3dData[4] = fEuler[1]
	fNew3dData[5] = fEuler[2]
	
	return fNew3dData
EndFunction


Float[] Function CreateQuaternionFromEuler(Float afAngleX, Float afAngleY, Float afAngleZ) global
	Float[] fQuat = new Float[4]
		
    Float _x = afAngleX * 0.5
    Float _y = afAngleY * 0.5
    Float _z = afAngleZ * 0.5

    Float cX = Math.cos(_x)
    Float cY = Math.cos(_y)
    Float cZ = Math.cos(_z)

    Float sX = Math.sin(_x)
    Float sY = Math.sin(_y)
    Float sZ = Math.sin(_z)
	
	; Based on XYZ rotation order
	fQuat[0] = cX * cY * cZ - sX * sY * sZ
    fQuat[1] = sX * cY * cZ + cX * sY * sZ
    fQuat[2] = cX * sY * cZ - sX * cY * sZ
	fQuat[3] = cX * cY * sZ + sX * sY * cZ
	
	return fQuat
EndFunction

Float[] Function CreateEulerFromQuaternion(Float[] afQuat) global
	Float[] fMatrix = CreateMatrixFromQuaternion(afQuat)
	Float[] fEuler = CreateEulerFromMatrix(fMatrix)
	
	return fEuler
EndFunction

Float[] Function CreateEulerFromMatrix(Float[] afMatrix) global
	Float m11 = afMatrix[0]
	Float m12 = afMatrix[4]
	Float m13 = afMatrix[8]
	Float m21 = afMatrix[1]
	Float m22 = afMatrix[5]
	Float m23 = afMatrix[9]
	Float m31 = afMatrix[2]
	Float m32 = afMatrix[6]
	Float m33 = afMatrix[10]
	
	Float[] fEuler = new Float[3]
	
	fEuler[1] = Math.Asin(Clamp(m13, -1, 1))
	if(Math.Abs(m13) < 0.9999999)
		fEuler[0] = Atan2(-m23, m33)
		
		;Debug.Trace("      m13 is < 0.9999999. Calculating Z from: Atan2(-1 * " + m12 + ", " + m11 + ")")
		fEuler[2] = Atan2(-m12, m11)
	else
		fEuler[0] = Atan2(m32, m22)
		fEuler[2] = 0
	endif
			
	return fEuler
EndFunction



Float Function NormalizeAngle(Float afAngle) global
	; Get an angle between 0 and 360
	
	Int iFloored = Math.Floor(afAngle)
	Int iMod = iFloored % 360
	Float fAfterDecimal = (Math.Abs(afAngle) - Math.Abs(iFloored) as Float)
	Int iModPositive = (iMod+360) % 360
	Float fNormalized = (iModPositive as Float) + Math.Abs(fAfterDecimal)
	
	;Debug.Trace("   NormalizeAngle(" + afAngle + "), iMod = " + iMod + ", iModPositive = " + iModPositive + ",  fAfterDecimal = " + fAfterDecimal + ", fNormalized = " + fNormalized)
	
	return fNormalized
EndFunction


; ------------------------------
; MultiplyQuaternions
;
; Description: Multiplies two quaternions and returns the result
;
; Params:
; afQA: Float array with 4 entries representing a quaternion, 
; afQB: Float array with 4 entries representing a quaternion
;
; Returns: Float array with 4 entries representing a quaternion
;
; ------------------------------
Float[] Function MultiplyQuaternions(Float[] afQA, Float[] afQB) global
	Float[] fQuat = new Float[4]
	
	fQuat[0] = (afQA[0] * afQB[0]) - (afQA[1] * afQB[1]) - (afQA[2] * afQB[2]) - (afQA[3] * afQB[3])
	fQuat[1] = (afQA[0] * afQB[1]) + (afQA[1] * afQB[0]) + (afQA[2] * afQB[3]) - (afQA[3] * afQB[2])
	fQuat[2] = (afQA[0] * afQB[2]) + (afQA[2] * afQB[0]) + (afQA[3] * afQB[1]) - (afQA[1] * afQB[3])
	fQuat[3] = (afQA[0] * afQB[3]) + (afQA[3] * afQB[0]) + (afQA[1] * afQB[2]) - (afQA[2] * afQB[1])
				;/ Hamilton equation
				w1 * w2 			- x1 * x2 			- y1 * y2 				- z1 * z2
				w1 * x2 			+ x1 * w2  			+ y1 * z2 				- z1 * y2
				w1 * y2 			+ y1 * w2 			+ z1 * x2 				- x1 * z2
				w1 * z2 			+ z1 * w2 			+ x1 * y2 				- y1 * x2
				/;
				
	return fQuat
EndFunction

; ------------------------------
; AddQuaternions
;
; Description: Adds two quaternions and returns the result
;
; Params:
; afQA: Float array with 4 entries representing a quaternion, 
; afQB: Float array with 4 entries representing a quaternion
;
; Returns: Float array with 4 entries representing a quaternion
;
; ------------------------------
Float[] Function AddQuaternions(Float[] afQA, Float[] afQB) global
	Float[] fQuat = new Float[4]
	fQuat[0] = afQA[0] + afQB[0]
	fQuat[1] = afQA[1] + afQB[1]
	fQuat[2] = afQA[2] + afQB[2]
	fQuat[3] = afQA[3] + afQB[3]
	
	return fQuat
EndFunction


; ------------------------------
; SubtractQuaternions
;
; Description: Subtracts quaternion afQB from afQA
;
; Params:
; afQA: Float array with 4 entries representing a quaternion, 
; afQB: Float array with 4 entries representing a quaternion
;
; Returns: Float array with 4 entries representing a quaternion
;
; ------------------------------
Float[] Function SubtractQuaternions(Float[] afQA, Float[] afQB) global
	Float[] fQuat = new Float[4]
	fQuat[0] = afQA[0] - afQB[0]
	fQuat[1] = afQA[1] - afQB[1]
	fQuat[2] = afQA[2] - afQB[2]
	fQuat[3] = afQA[3] - afQB[3]
	
	return fQuat
EndFunction

; ------------------------------
; InverseQuaternion
;
; Description: Inverts a quaternion
;
; Params:
; afQ: Float array with 4 entries representing a quaternion
;
; Returns: Float array with 4 entries representing a quaternion
;
; ------------------------------
Function InverseQuaternion(Float[] afQ) global
	afQ[0] = -afQ[0]
	afQ[1] = -afQ[1]
	afQ[2] = -afQ[2]
	afQ[3] = -afQ[3]
EndFunction
	
; ------------------------------
; CreateMatrixFromEuler
;
; Description: Accepts a euler angle and return an equivalent matrix
;
; Params:
; afAngleX, afAngleY, afAngle: Angles in degrees
;
; Returns: Float array with 9 entries representing a row-major matrix
;
; ------------------------------
Float[] Function CreateMatrixFromEuler(Float afAngleX, Float afAngleY, Float afAngleZ) global
	Float[] fMatrix = new Float[9]
	
	Float fCosB = Math.Cos(afAngleX)
	Float fSinB = Math.Sin(afAngleX)
	Float fCosH = Math.Cos(afAngleY)
	Float fSinH = Math.Sin(afAngleY)
	Float fCosA = Math.Cos(afAngleZ)
	Float fSinA = Math.Sin(afAngleZ)

	; XYZ order - right
	fMatrix[0] = fCosH * fCosA
	fMatrix[1] = -fCosH * fSinA
	fMatrix[2] = fSinH
	fMatrix[3] = (fCosB * fSinA) + (fCosA * fSinB * fSinH)
	fMatrix[4] = (fCosB*fCosA) - (fSinB * fSinH * fSinA)
	fMatrix[5] = -fCosH * fSinB
	fMatrix[6] = (fSinB * fSinA) - (fCosB * fCosA * fSinH)
	fMatrix[7] = (fCosA * fSinB) + (fCosB * fSinH * fSinA)
	fMatrix[8] = fCosB * fCosH

	return fMatrix
EndFunction

; ------------------------------
; CreateMatrixFromQuaternion
;
; Description: Accepts a quaternion and returns the equivalent row-major matrix
;
; Params:
; afQuat: Float array with 4 entries representing a quaternion
;
; Returns: Float array with 9 entries representing a row-major matrix
;
; ------------------------------
Float[] Function CreateMatrixFromQuaternion(Float[] afQuat) global
	Float w = afQuat[0]
	Float x = afQuat[1]
	Float y = afQuat[2]
	Float z = afQuat[3]
	
	Float x2 = x + x
	Float y2 = y + y
	Float z2 = z + z
	
	Float xx = x * x2
	Float xy = x * y2
	Float xz = x * z2
	
	Float yy = y * y2
	Float yz = y * z2
	Float zz = z * z2
	
	Float wx = w * x2
	Float wy = w * y2
	Float wz = w * z2
	
		; Setting up position and scale as vars in case we need them later
	Float px = 0.0
	Float py = 0.0
	Float pz = 0.0
	Float sx = 1.0
	Float sy = 1.0
	Float sz = 1.0
	
	Float[] Matrix4x4 = new Float[16]
	Matrix4x4[0] = ( 1 - ( yy + zz ) ) * sx
	Matrix4x4[1] = ( xy + wz ) * sx
	Matrix4x4[2] = ( xz - wy ) * sx
	Matrix4x4[3] = 0
	Matrix4x4[4] = ( xy - wz ) * sy
	Matrix4x4[5] = ( 1 - ( xx + zz ) ) * sy
	Matrix4x4[6] = ( yz + wx ) * sy
	Matrix4x4[7] = 0
	Matrix4x4[8] = ( xz + wy ) * sz
	Matrix4x4[9] = ( yz - wx ) * sz
	Matrix4x4[10] = ( 1 - ( xx + yy ) ) * sz
	Matrix4x4[11] = 0
	Matrix4x4[12] = px
	Matrix4x4[13] = py
	Matrix4x4[14] = pz
	Matrix4x4[15] = 1
	
	return Matrix4x4
EndFunction