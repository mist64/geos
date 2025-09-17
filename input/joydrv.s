; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Joystick input driver
;
; This driver reads a standard joystick and translates its input into
; smooth, accelerated mouse pointer motion.

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "jumptab.inc"
.include "c64.inc"

.segment "inputdrv"

; --- GEOS KERNAL Entry Points ---

MouseInit:
	jmp _MouseInit ; initialize the driver state
SlowMouse:
	jmp _SlowMouse ; reset mouse speed and acceleration
UpdateMouse:
	jmp _UpdateMouse ; main routine to read input and update pointer
.ifdef bsw128
SetMouse:
	rts ; Unused
.endif

; --- Driver State ---

fracX:
	.byte 0 ; fractional part of the X-axis position
fracY:
	.byte 0 ; fractional part of the Y-axis position
accelAcc:
	.byte 0 ; accumulator for acceleration
deltaX:
	.byte 0 ; calculated integer delta for X-axis movement this frame
deltaY:
	.byte 0 ; calculated integer delta for Y-axis movement this frame
lastFire:
	.byte 0 ; previous state of the fire button
lastDir:
	.byte 0 ; previous state of the direction bits
lastRaw:
	.byte 0 ; previous state of the entire joystick port

; --- Internal Routines ---

; _MouseInit: Initializes all driver variables to a default state
_MouseInit:
	jsr _SlowMouse        ; set speed and acceleration to zero
	sta accelAcc          ; clear acceleration accumulator
	sta mouseXPos         ; clear mouse X/Y coordinates
	sta mouseXPos+1
	sta mouseYPos
	LoadB inputData, $ff  ; initial input state: centered
	jmp CalculateDeltas

; _SlowMouse: Resets the mouse speed to zero
_SlowMouse:
	LoadB mouseSpeed, NULL
rts0:
	rts

; _UpdateMouse: The main routine, called every frame to update the pointer
_UpdateMouse:
	jsr ReadInput
	bbrf MOUSEON_BIT, mouseOn, rts0 ; mouse driver disabled
	jsr UpdateSpeed
	jsr UpdatePosX

 ; Apply the Y-axis delta using fixed-point math for smoothness
	ldy #0
	lda deltaY            ; Y delta for this frame
	bpl :+                ; not negative -> skip
	dey                   ; Y = -1
:	sty r1H               ; sign/high-byte
	asl                   ; multiply Y delta by 16
	rol r1H
	asl
	rol r1H
	asl
	rol r1H
	add fracY             ; add fractional part from previous frames
	sta fracY
	lda r1H               ; integer part of movement
	adc mouseYPos         ; add to main Y coordinate
	sta mouseYPos
	rts

;---------------------------------------------------------------
; UpdateSpeed
;
; Function:  Manages mouse acceleration and deceleration based on
;            joystick input, then calls CalculateDeltas
;
; Pass:      inputData   Current 8-direction code
;            mouseSpeed  Current speed
;            accelAcc    Current acceleration accumulator value
;
; Return:    mouseSpeed and accelAcc are updated; ultimately causes
;            deltaX and deltaY to be set by CalculateDeltas
;---------------------------------------------------------------
UpdateSpeed:
	ldx inputData
	bmi @2                ; centered -> handle deceleration
 ; Acceleration logic
	CmpB maxMouseSpeed, mouseSpeed
	bcc @1                ; max speed -> don't accelerate further
	AddB mouseAccel, accelAcc
	bcc CalculateDeltas   ; acceleration overflow
	inc mouseSpeed
	bra CalculateDeltas

@1:	sta mouseSpeed        ; cap speed at max

@2:	; deceleration logic (joystick is centered)
	CmpB minMouseSpeed, mouseSpeed
	bcs @3                ; already at min speed
	SubB mouseAccel, accelAcc
	bcs CalculateDeltas   ; deceleration underflow
	dec mouseSpeed
	bra CalculateDeltas

@3:	sta mouseSpeed        ; cap speed at min

;---------------------------------------------------------------
; CalculateDeltas
;
; Function:  Calls CalcVector to compute the final X/Y movement
;            deltas based on the current speed and direction
;
; Pass:      inputData   Current 8-direction code
;            mouseSpeed  Current, finalized mouse speed
;
; Return:    deltaX  Calculated X-axis delta for the frame
;            deltaY  Calculated Y-axis delta for the frame
;---------------------------------------------------------------
CalculateDeltas:
	ldx inputData
	bmi @1                ; centered -> deltas are zero
	ldy mouseSpeed
	sty r0L               ; pass speed to the multiplication routine
	jsr CalcVector        ; calculate scaled X and Y vector components
	MoveB r1H, deltaX
	MoveB r2H, deltaY
	rts
@1:	; Joystick is centered, so there is no movement
	LoadB deltaX, 0
	sta deltaY
	rts

;---------------------------------------------------------------
; UpdatePosX
;
; Function:  Apply the horizontal delta to the pointer's
;            X coordinate
;
; Pass:      deltaX     X delta to apply
;            fracX      current fractional part of X pos
;            mouseXPos  current integer X pos
;
; Return:    mouseXPos  updated with the integer part of movement
;            fracX      updated with the new fractional part
;---------------------------------------------------------------
UpdatePosX:
	ldy #$ff              ; -1
	lda deltaX
	bmi :+                ; negative -> skip
	iny                   ; Y = 0
:	sty r11H              ; sign/high-byte
	sty r12L              ; (Used for 16-bit addition to mouseXPos)
	asl                   ; multiply X delta by 16
	rol r11H
	asl
	rol r11H
	asl
	rol r11H
	add fracX             ; add fractional part from previous frames
	sta fracX
	lda r11H              ; integer part of movement
	adc mouseXPos         ; add to main X coordinate (low byte)
	sta mouseXPos
	lda r12L
	adc mouseXPos+1
	sta mouseXPos+1
	rts

;---------------------------------------------------------------
; ReadInput
;
; Function:  Reads the physical joystick port, detects changes in
;            state, and updates corresponding system variables
;
; Pass:      lastFire, lastDir, lastRaw  Contain previous input state
;
; Return:    inputData  Updated if direction changed
;            mouseData  Updated if fire button state changed
;            pressFlag  Bits set to notify GEOS of new input
;---------------------------------------------------------------
ReadInput:
	LoadB cia1base, $ff   ; disable the keyboard
	lda cia1base+1        ; read joystick port 1
	eor #$ff              ; invert bits (so pressed = 1)
	cmp lastRaw
	sta lastRaw
	bne @2                ; branch if there are changes
 ; Process joystick direction
	and #%00001111        ; direction bits
	cmp lastDir
	beq @1                ; no change
	sta lastDir
	tay                   ; use as index
	lda JoyDirectionTab,y ; convert 4-bit hardware state to 8-bit direction code
	sta inputData
	smbf INPUT_BIT, pressFlag ; signal move event to GEOS
	jsr CalculateDeltas
@1:	; process fire button
	lda lastRaw
	and #%00010000        ; button bit
	cmp lastFire
	beq @2                ; unchanged
	sta lastFire
	asl                   ; convert into mouseData format
	asl
	asl
	eor #%10000000
	sta mouseData
	smbf MOUSE_BIT, pressFlag ; signal button event to GEOS
@2:	rts

; --- Data Tables ---

; JoyDirectionTab: Maps the 4-bit hardware direction value to an inputData code.
;   3    2    1
;    *  +  *
;  4  -- * --  0
;     *  +  *
;   5    6    7
JoyDirectionTab:
	.byte $ff ;  0 centered
	.byte 2   ;  1 up
	.byte 6   ;  2 down
	.byte $ff ;  3 (illegal)
	.byte 4   ;  4 left
	.byte 3   ;  5 left+up
	.byte 5   ;  6 left+down
	.byte $ff ;  7 (illegal)
	.byte 0   ;  8 right
	.byte 1   ;  9 right+up
	.byte 7   ; 10 right+down
	.byte $ff ; 11 (illegal)
	.byte $ff ; 12 (illegal)
	.byte $ff ; 13 (illegal)
	.byte $ff ; 14 (illegal)
	.byte $ff ; 15 (illegal)

;---------------------------------------------------------------
; CalcVector
;
; Function:  Compute the scaled X and Y movement vector
;            components from a direction and speed
;
; Pass:      x   direction code (0-7) (inputData)
;            r0L current mouse speed.
;
; Return:    r1H calculated X-axis delta
;            r2H calculated Y-axis delta
;---------------------------------------------------------------
CalcVector:
	lda VectorMagnitude,x ; X component for current direction
	sta r1L
	lda VectorMagnitude+2,x ; Y component
	sta r2L
	lda VectorSign,x      ; sign bits for X and Y components
	pha
	ldx #r1
	ldy #r0               ; contains mouseSpeed from UpdateSpeed
	jsr BBMult            ; 8x8 multiply: speed * X-component
	ldx #r2
	jsr BBMult            ; 8x8 multiply: speed * Y-component
	pla                   ; sign bits
	pha
	bpl @1                ; not negative, skip
	ldx #r1
	jsr Dnegate           ; negate 16-bit result for X
@1:	pla
	and #%01000000        ; sign bit for Y component
	beq @2                ; not negative, skip
	ldx #r2
	jsr Dnegate           ; negate 16-bit result for Y
@2:	rts

; Magnitude values for X and Y vector components for each of the 8 directions.
; Diagonal components (181 = round(255 * sqrt(2))) are smaller than cardinal ones
; (255, which acts as 1.0) to ensure consistent speed.
VectorMagnitude:
	.byte 255
	.byte 181
	.byte 0
	.byte 181
	.byte 255
	.byte 181
	.byte 0
	.byte 181
	.byte 255
	.byte 181

; Flags (in bits 6 and 7) indicating whether the X and Y components
; from VectorMagnitude should be negated for a given direction
VectorSign:
	.byte %00000000
	.byte %01000000
	.byte %01000000
	.byte %11000000
	.byte %10000000
	.byte %10000000
	.byte %00000000
	.byte %00000000