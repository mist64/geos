; GEOS KERNAL
;
; Generic initialization

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; files.s
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

.global InitGEOEnv
.global InitGEOS
.global _FirstInit

.segment "init1"

InitGEOS:
	jsr _DoFirstInitIO
InitGEOEnv:
	LoadW r0, InitRamTab
	jmp _InitRam

.segment "init2"

_FirstInit:
	sei
	cld
	jsr InitGEOS
	LoadW EnterDeskTop+1, _EnterDeskTop
	LoadB maxMouseSpeed, iniMaxMouseSpeed
	LoadB minMouseSpeed, iniMinMouseSpeed
	LoadB mouseAccel, iniMouseAccel
	LoadB screencolors, (DKGREY << 4)+LTGREY
	sta FItempColor
	jsr i_FillRam
	.word 1000
	.word COLOR_MATRIX
FItempColor:
	.byte (DKGREY << 4)+LTGREY
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadB mob0clr, BLUE
	sta mob1clr
	LoadB extclr, BLACK
	stx CPU_DATA
	ldy #62
:	lda #0
	sta mousePicData,Y
	dey
	bpl :-
	ldx #24
:	lda InitMsePic-1,X
	sta mousePicData-1,X
	dex
	bne :-
	jmp UNK_6

.segment "init3"

UNK_6:
	lda #$bf
	sta A8FF0
	ldx #7
	lda #$bb
:	sta A8FE8,x
	dex
	bpl :-
	rts

.segment "init4"

InitRamTab:
	.word currentMode
	.byte 12
	.byte NULL
	.byte ST_WR_FORE | ST_WR_BACK
	.byte NULL
	.word mousePicData
	.byte NULL, SC_PIX_HEIGHT-1
	.word NULL, SC_PIX_WIDTH-1
	.byte NULL
	.word appMain
	.byte 28
	.word NULL, _InterruptMain
	.word NULL, NULL, NULL, NULL
	.word NULL, NULL, NULL, NULL
	.word _Panic, _RecoverRectangle
	.byte SelectFlashDelay, NULL
	.byte ST_FLASH, NULL
	.word NumTimers
	.byte 2
	.byte NULL, NULL
	.word clkBoxTemp
	.byte 1
	.byte NULL
	.word IconDescVecH
	.byte 1
	.byte NULL
	.word obj0Pointer
	.byte 8
	.byte $28, $29, $2a, $2b
	.byte $2c, $2d, $2e, $2f
	.word NULL

