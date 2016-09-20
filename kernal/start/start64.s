; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak; Michael Steil
;
; Purgeable start code; first entry

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "inputdrv.inc"
.include "c64.inc"

; main.s
.import InitGEOEnv
.import _DoFirstInitIO
.import _EnterDeskTop

; header.s
.import dateCopy

; irq.s
.import _IRQHandler
.import _NMIHandler

.import LdApplic
.import GetBlock
.import EnterDeskTop
.import GetDirHead
.import FirstInit
.import i_FillRam

; used by header.s
.global _ResetHandle

.ifdef usePlus60K
.import DetectPlus60K
.endif
.if .defined(useRamCart64) || .defined(useRamCart128)
.import DetectRamCart
.endif
.ifdef useRamExp
.import LoadDeskTop
.endif


.segment "start"

; The original version of GEOS 2.0 has purgeable init code
; at $5000 that is run once. It does some initialization
; and handles application auto-start.
;
; The cbmfiles version of GEOS does some init inside
; "BOOTGEOS" right after copying the components to their
; respective locations, then jumps to $500D, which contains
; a different version of the code, and skipping the first
; five instructions.
;
; This version is based on the cbmfiles version.
; "OrigResetHandle" below is the original cbmfiles code at
; $5000, and the code here at _ResetHandle is some additional
; initialization derived from the code in BOOTGEOS to make
; everything work.
;
; TODO: * REU detection seems to be currently missing.
;       * It would be best to put the original GEOS 2.0 code
;         here.
;

_ResetHandle:
	sei
	cld
	ldx #$FF
	txs

ASSERT_NOT_BELOW_IO
	lda #IO_IN
	sta CPU_DATA

	LoadW NMI_VECTOR, _NMIHandler
	LoadW IRQ_VECTOR, _IRQHandler

	; draw background pattern
	LoadW r0, SCREEN_BASE
	ldx #$7D
@2:	ldy #$3F
@3:	lda #$55
	sta (r0),y
	dey
	lda #$AA
	sta (r0),y
	dey
	bpl @3
	lda #$40
	clc
	adc r0L
	sta r0L
	bcc @4
	inc r0H
@4:	dex
	bne @2

	; set clock in CIA1
	lda cia1base+15
	and #$7F
	sta cia1base+15 ; prepare for setting time
	lda #$81
	sta cia1base+11 ; hour: 1 + PM
	lda #0
	sta cia1base+10 ; minute: 0
	sta cia1base+9 ; seconds: 0
	sta cia1base+8 ; 10ths: 0

	lda #RAM_64K
	sta CPU_DATA
ASSERT_NOT_BELOW_IO

	jsr i_FillRam
	.word $0500
	.word dirEntryBuf
	.byte 0

	; set date
	ldy #2
@6:	lda dateCopy,y
	sta year,y
	dey
	bpl @6

	;
	jsr FirstInit
	jsr MouseInit
	lda #currentInterleave
	sta interleave

	lda #1
	sta NUMDRV
	ldy $BA
	sty curDrive
	lda #DRV_TYPE ; see config.inc
	sta curType
	sta _driveType,y

; This is the original code the cbmfiles version
; has at $5000.
OrigResetHandle:
	sei
	cld
	ldx #$ff
	jsr _DoFirstInitIO
	jsr InitGEOEnv
.ifdef usePlus60K
	jsr DetectPlus60K
.endif
.if .defined(useRamCart64) || .defined(useRamCart128)
	jsr DetectRamCart
.endif
	jsr GetDirHead
	MoveB bootSec, r1H
	MoveB bootTr, r1L
	AddVB 32, bootOffs
	bne @3
@1:	MoveB bootSec2, r1H
	MoveB bootTr2, r1L
	bne @3
	lda NUMDRV
	bne @2
	inc NUMDRV
@2:	LoadW EnterDeskTop+1, _EnterDeskTop
.ifdef useRamExp
	jsr LoadDeskTop
.endif
	jmp EnterDeskTop

@3:	MoveB r1H, bootSec
	MoveB r1L, bootTr
	LoadW r4, diskBlkBuf
	jsr GetBlock
	bnex @2
	MoveB diskBlkBuf+1, bootSec2
	MoveB diskBlkBuf, bootTr2
@4:	ldy bootOffs
	lda diskBlkBuf+2,y
	beq @5
	lda diskBlkBuf+$18,y
	cmp #AUTO_EXEC
	beq @6
@5:	AddVB 32, bootOffs
	bne @4
	beq @1
@6:	ldx #0
@7:	lda diskBlkBuf+2,y
	sta dirEntryBuf,x
	iny
	inx
	cpx #30
	bne @7
	LoadW r9, dirEntryBuf
	LoadW EnterDeskTop+1, _ResetHandle
	LoadB r0L, 0
	jsr LdApplic
bootTr:
	.byte DIR_TRACK
bootSec:
	.byte 1
bootTr2:
	.byte 0
bootSec2:
	.byte 0
bootOffs:
	.byte 0
