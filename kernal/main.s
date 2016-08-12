; GEOS Kernal
; system core - all address-aligned data (for compatibility), core (EnterDeskTop) and init stuff
; reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; applications.s
.import _EnterDeskTop

; conio.s
.import ProcessCursor

; graph.s
.import _RecoverRectangle

; hw.s
.import _DoFirstInitIO

; icons.s
.import InitMsePic

; math.s
.import _GetRandom

; memory.s
.import _InitRam

; mouseio.s
.import _DoCheckButtons
.import ProcessMouse

; process.s
.import _DoCheckDelays
.import _ExecuteProcesses
.import _ProcessDelays
.import _ProcessTimers

; time.s
.import _DoUpdateTime

.global BitMask1
.global BitMask2
.global BitMask3
.global BitMask4
.global InitGEOEnv
.global InitGEOS
.global _CallRoutine
.global _DoInlineReturn
.global _FirstInit
.global _InterruptMain
.global _MNLP
.global _MainLoop
.global _Panic
.global dateCopy
.global sysFlgCopy

.segment "kernalhdr"
	jmp BootKernal
	jmp InitKernal

bootName:
	.byte "GEOS BOOT"
version:
	.byte $20
nationality:
	.byte $00,$00
sysFlgCopy:
	.byte $00
c128Flag:
	.byte $00
	.byte $05,$00,$00,$00
dateCopy:
.ifdef maurice
	.byte 92,3,23
.else
	.byte 88,4,20
.endif

BootKernal:
	bbsf 5, sysFlgCopy, BootREU
	jsr $FF90
	lda #version-bootName
	ldx #<bootName
	ldy #>bootName
	jsr $FFBD
	lda #$50
	ldx #8
	ldy #1
	jsr $FFBA
	lda #0
	jsr $FFD5
	bcc _RunREU
	jmp ($0302)
BootREU:
	ldy #8
BootREU1:
	lda BootREUTab,Y
	sta EXP_BASE+1,Y
	dey
	bpl BootREU1
BootREU2:
	dey
	bne BootREU2
_RunREU:
	jmp RunREU
BootREUTab:
	.word $0091
	.word $0060
	.word $007e
	.word $0500
	.word $0000

.segment "mainloop1"

_MainLoop:
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:
	jsr CallRoutine
	cli
	jmp _MainLoop2

.segment "mainloop2"
_MainLoop2:
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
	jmp _MainLoop

.segment "main1b"

_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom

;--------------------------------------------

BitMask1:
	.byte $80, $40, $20, $10, $08, $04, $02
BitMask2:
	.byte $01, $02, $04, $08, $10, $20, $40, $80
BitMask3:
	.byte $00, $80, $c0, $e0, $f0, $f8, $fc, $fe
BitMask4:
	.byte $7f, $3f, $1f, $0f, $07, $03, $01, $00

.segment "main3b"

InitGEOS:
	jsr _DoFirstInitIO
InitGEOEnv:
	LoadW r0, InitRamTab
	jmp _InitRam

.segment "initramtab"

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

.segment "main4b"

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

.segment "unk6"

UNK_6:
	lda #$bf
	sta A8FF0
	ldx #7
	lda #$bb
:	sta A8FE8,x
	dex
	bpl :-
	rts

.segment "main5"
_CallRoutine:
	cmp #0
	bne CRou1
	cpx #0
	beq CRou2
CRou1:
	sta CallRLo
	stx CallRHi
	jmp (CallRLo)
CRou2:
	rts

_DoInlineReturn:
	add returnAddress
	sta returnAddress
	bcc DILR1
	inc returnAddress+1
DILR1:
	plp
	jmp (returnAddress)

.segment "X"

.if (useRamExp)
DeskTopOpen:
	.byte 0 ;these two bytes are here just
DeskTopRecord:
	.byte 0 ;to keep OS_JUMPTAB at $c100
	.byte 0,0,0 ;three really unused

DeskTopStart:
	.word 0 ;these are for ensuring compatibility with
DeskTopExec:
	.word 0 ;DeskTop replacements - filename of desktop
DeskTopLgh:
	.byte 0 ;have to be at $c3cf .IDLE
.endif

.segment "main6"

_Panic:
	PopW r0
	SubVW 2, r0
	lda r0H
	ldx #0
	jsr Panil0
	lda r0L
	jsr Panil0
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
Panil0:
	pha
	lsr
	lsr
	lsr
	lsr
	jsr Panil1
	inx
	pla
	and #%00001111
	jsr Panil1
	inx
	rts
Panil1:
	cmp #10
	bcs Panil2
	addv ('0')
	bne Panil3
Panil2:
	addv ('0'+7)
Panil3:
	sta _PanicAddy,X
	rts

_PanicDB_DT:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
	.byte NULL

_PanicDB_Str:
	.byte BOLDON
	.byte "System error near $"
_PanicAddy:
	.byte "xxxx"
	.byte NULL
