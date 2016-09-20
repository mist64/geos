; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Machine initialization: FirstInit syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import InitMsePic
.import _EnterDeskTop
.import _InitMachine
.import UNK_6
.import _SetMsePic

.import i_FillRam
.import EnterDeskTop
.ifdef wheels
.import i_ColorRectangle
.import InitMachine
.endif

.global _FirstInit

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
.ifdef bsw128
	LoadB screencolors, $BF
	sta @1
	LoadB scr80polar, $40
	LoadB scr80colors, $E0
.endif
.ifdef wheels
	jsr InitMachine
.else
	jsr _InitMachine
.endif
	LoadW EnterDeskTop+1, _EnterDeskTop
	LoadB maxMouseSpeed, iniMaxMouseSpeed
.ifdef wheels_size_and_speed
	.assert iniMouseAccel = iniMaxMouseSpeed, error, "iniMouseAccel != iniMaxMouseSpeed!"
	sta mouseAccel
.endif
	LoadB minMouseSpeed, iniMinMouseSpeed
.ifndef wheels_size_and_speed
	LoadB mouseAccel, iniMouseAccel
.endif

.ifdef wheels
.import sysScrnColors
	MoveB sysScrnColors, screencolors
.else
.ifndef bsw128
	LoadB screencolors, (DKGREY << 4)+LTGREY
	sta @1
.endif
	jsr i_FillRam
	.word 1000
	.word COLOR_MATRIX
@1:	.byte (DKGREY << 4)+LTGREY
	START_IO_X
	LoadB mob0clr, BLUE
	sta mob1clr
	LoadB extclr, BLACK
	END_IO_X
.endif
	ldy #62
@2:	lda #0
	sta mousePicData,Y
	dey
	bpl @2
.ifdef bsw128
	sta r0L
	sta r0H
.endif
	ldx #24
@3:	lda InitMsePic-1,x
	sta mousePicData-1,x
	dex
	bne @3
.ifdef wheels
.import sysMob0Clr
.import sysExtClr
.import DrawCheckeredScreen
.global _FirstInit2
.global _FirstInit3
_FirstInit2:
	jsr DrawCheckeredScreen
	lda screencolors
	sta LC54D
	jsr i_ColorRectangle
	.byte 0, 0                 ; origin
	.byte 40, 25               ; size
LC54D:  .byte (DKGREY << 4)+LTGREY ; value
; ----------------------------------------------------------------------------
_FirstInit3:
	START_IO_X
	lda sysExtClr
	sta extclr
	MoveB sysMob0Clr, mob0clr
	sta mob1clr
	END_IO_X
        rts
.elseif .defined(bsw128)
	jmp _SetMsePic
.else
	jmp UNK_6
.endif
