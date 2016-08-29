; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Generic initialization

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

; filesys.s
.import _EnterDeskTop

; graph.s
.import _RecoverRectangle

; hw.s
.import _DoFirstInitIO

; icons.s
.import InitMsePic

; main.s
.import _InterruptMain

; memory.s
.import _InitRam

; panic.s
.import _Panic

; var.s
.import NumTimers
.import clkBoxTemp

.global InitGEOEnv
.global InitGEOS
.global _FirstInit

.segment "init1"

.if !wheels
InitGEOS:
	jsr _DoFirstInitIO
InitGEOEnv:
	LoadW r0, InitRamTab
	jmp _InitRam
.endif

.segment "init2"

;---------------------------------------------------------------
; FirstInit                                               $C271
;
; Function:  Initialize GEOS
;
; Pass:      nothing
; Destroyed: a, y, r0 - r2l
;---------------------------------------------------------------
_FirstInit:
	sei
	cld
	jsr $C2FE;xxxInitGEOS
	LoadW EnterDeskTop+1, $C326;xxx_EnterDeskTop
	LoadB maxMouseSpeed, iniMaxMouseSpeed
.if wheels
	sta mouseAccel
.endif
	LoadB minMouseSpeed, iniMinMouseSpeed
.if !wheels
	LoadB mouseAccel, iniMouseAccel
.endif

.if wheels
L9FDA = $9FDA
L9FDC = $9fdc
L9FDD = $9fdd
LC499 = $C499
LBF3F = $bf3f
.import WheelsSyscall9
	MoveB L9FDA, screencolors
        ldy     #$3E                            ; C528 A0 3E                    .>
LC52A:  lda     #$00                            ; C52A A9 00                    ..
        sta     $84C1,y                         ; C52C 99 C1 84                 ...
        dey                                     ; C52F 88                       .
        bpl     LC52A                           ; C530 10 F8                    ..
        ldx     #$18                            ; C532 A2 18                    ..
LC534:  lda     LBF3F,x                         ; C534 BD 3F BF                 .?.
        sta     $84C0,x                         ; C537 9D C0 84                 ...
        dex                                     ; C53A CA                       .
        bne     LC534                           ; C53B D0 F7                    ..
LC53D:  jsr     LC499                           ; C53D 20 99 C4                  ..
        lda     $851E                           ; C540 AD 1E 85                 ...
        sta     LC54D                           ; C543 8D 4D C5                 .M.
        jsr     WheelsSyscall9                           ; C546 20 16 C3                  ..
        .byte   $00,$00,$28,$19                 ; C549 00 00 28 19              ..(.
LC54D:  .byte   $BF                             ; C54D BF                       .
; ----------------------------------------------------------------------------
LC54E:  ldx     $01                             ; C54E A6 01                    ..
        lda     #$35                            ; C550 A9 35                    .5
        sta     $01                             ; C552 85 01                    ..
        lda     L9FDD                           ; C554 AD DD 9F                 ...
        sta     $D020                           ; C557 8D 20 D0                 . .
        lda     L9FDC                           ; C55A AD DC 9F                 ...
        sta     $D027                           ; C55D 8D 27 D0                 .'.
        sta     $D028                           ; C560 8D 28 D0                 .(.
        stx     $01                             ; C563 86 01                    ..
        rts                                     ; C565 60                       `
.else
	LoadB screencolors, (DKGREY << 4)+LTGREY
	sta @1
	jsr i_FillRam
	.word 1000
	.word COLOR_MATRIX
@1:	.byte (DKGREY << 4)+LTGREY
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	LoadB mob0clr, BLUE
	sta mob1clr
	LoadB extclr, BLACK
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	ldy #62
@2:	lda #0
	sta mousePicData,Y
	dey
	bpl @2
	ldx #24
@3:	lda InitMsePic-1,x
	sta mousePicData-1,x
	dex
	bne @3
	jmp UNK_6
.endif

.segment "init3"

.if !wheels
UNK_6:
	lda #$bf
	sta A8FF0
	ldx #7
	lda #$bb
@1:	sta A8FE8,x
	dex
	bpl @1
	rts
.endif

.segment "init4"

.if wheels
.global InitRamTab
.endif

InitRamTab:
	.word currentMode
	.byte 12
	.byte 0                       ; currentMode
	.byte ST_WR_FORE | ST_WR_BACK ; dispBufferOn
	.byte 0                       ; mouseOn
	.word mousePicData            ; msePicPtr
	.byte 0                       ; windowTop
	.byte SC_PIX_HEIGHT-1         ; windowBottom
	.word 0                       ; leftMargin
	.word SC_PIX_WIDTH-1          ; rightMargin
	.byte 0                       ; pressFlag

	.word appMain
	.byte 28
	.word 0                       ; appMain
	.word _InterruptMain          ; intTopVector
	.word 0                       ; intBotVector
	.word 0                       ; mouseVector
	.word 0                       ; keyVector
	.word 0                       ; inputVector
	.word 0                       ; mouseFaultVec
	.word 0                       ; otherPressVec
	.word 0                       ; StringFaultVec
	.word 0                       ; alarmTmtVector
	.word _Panic                  ; BRKVector
	.word _RecoverRectangle       ; RecoverVector
	.byte SelectFlashDelay        ; selectionFlash
	.byte 0                       ; alphaFlag
	.byte ST_FLASH                ; iconSelFlg
	.byte 0                       ; faultData

	.word NumTimers
	.byte 2
	.byte 0                       ; NumTimers
	.byte 0                       ; menuNumber

	.word clkBoxTemp
	.byte 1
	.byte 0                       ; clkBoxTemp

	.word IconDescVecH
	.byte 1
	.byte 0                       ; IconDescVecH

.if wheels ; ???
	.word   A88A7
	.byte   1
	.byte   5
.endif
	.word obj0Pointer
	.byte 8
	.byte $28, $29, $2a, $2b
	.byte $2c, $2d, $2e, $2f

	.word 0
