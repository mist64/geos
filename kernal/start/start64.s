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
.ifdef drv1541parallel
	jsr detect_1541s
.endif
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
.ifdef drv1541parallel
	LoadB NUMDRV, 0
	ldy #8
:	lda drives,y
	cmp #DRV_1541
	bne :+
	sta _driveType,y
	inc NUMDRV
:	iny
	cpy #12
	bne :--
	LoadB curType, DRV_1541
	MoveB curDevice, curDrive
.else
	lda #currentInterleave
	sta interleave

	lda #1
	sta NUMDRV
	ldy $BA
	sty curDrive
	lda #DRV_TYPE ; see config.inc
	sta curType
	sta _driveType,y
.endif

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

.ifdef drv1541parallel

; ------------------------------------------

k_second	= $ff93
k_unlstn	= $ffae
k_listen	= $ffb1
k_setlfs	= $ffba
k_setnam	= $ffbd
k_open		= $ffc0
k_close		= $ffc3
k_chkin		= $ffc6
k_clrchn	= $ffcc
k_chrin		= $ffcf
k_chrout	= $ffd2
k_getin		= $ffe4 

drives = *-8
	.byte 0, 0, 0, 0

; multiple daisy-chained parallel port connections work with 1541 (see DualDriveBurstBackup)
; but 1541 ROM will set port A to output upon boot ($FF10) - not clear why
; so we have to scan for all attached 1541s and run M-W,$1803,1,0 to set port A as input

detect_1541s:
	PushB CPU_DATA
	PushB curDevice
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, KRNL_IO_IN
	jsr drive_poll
	; copy discovered drive types
	ldy #8
:	lda drives,y
	cmp #DRV_1541
	bne :+
	jsr set1541PortAInput
:	iny
	cpy #12
	bne :--
	PopB curDevice
	sta curDrive
	PopB CPU_DATA
	rts

set1541PortAInput:
	tya
	pha
	tax
	lda #15
	tay
	jsr k_setlfs
	lda #7
	ldx #<@write1803
	ldy #>@write1803
	jsr k_setnam
	jsr k_open
	lda #15
	jsr k_close
	pla
	tay
	rts

@write1803:
	.byte "M-W"
	.word $1803
	.byte 1
	.byte 0

; drive detection code based on codebase64 solution https://codebase64.org/doku.php?id=base:detect_drives_on_iec_bus
; by Todd S. Elliott

drive_poll:

	LoadB curDevice, 8	; start at #8
	tay
	lda #DRV_NULL		; that is actually 0
:	sta drives,y		; zero out the drive buffer
	iny
	cpy #12
	bne :-

	; scan IEC bus, if devices exist
@iecloop:
	ldy #0
	sty STATUS		; clear status
	lda curDevice
	jsr k_listen		; opens the device for listening
	lda #$ff		; Secondary address - $0f OR'ed with $f0 to open
	jsr k_second		; opens the channel with sa of 15


	bbsf 7, STATUS, @close	; branch if there is no device present	

	ldy curDevice
	tya
	sta drives,y		; store non-zero in successful device number

@close:	jsr k_unlstn		; severs the serial bus control

	LoadB STATUS, 0		; clear status
	lda curDevice
	jsr k_listen
	lda #$ef		; sa - $0f and OR'ed with $e0 to close file
	jsr k_second		; closes the channel with sa of 15
	jsr k_unlstn		; finally closes it

	inc curDevice		; next device
	CmpBI curDevice, 12	; last device to check?
	bne @iecloop

	ldy #8
	sty curDevice		; restart at #8

@scanloop:
	lda drives,y
	bne @scandevice
	iny
	cpy #12			; are we done? (acceptable range of 8 to 30)
	bne @scanloop
	rts			; exits the whole drive polling routine

@scandevice:
	sty curDevice

	jsr @open_cmd_channel
	ldx #<cbminfo		; check to see if it is a 1541/1571 drive
	ldy #>cbminfo
	jsr @open_cmd_two

	jsr k_chrin		; gets the drive info
	cmp #'5'		; is it '5' for the 15xx drives?
	bne @not4171
	jsr k_chrin		; gets the next number
	cmp #'4'		; is it '4' for the 1541?
	bne @not41

	lda #DRV_1541		; indicates a 1541 at that device number
	bne @get_next_drive

@not41:	cmp #'7'		; is it '7' for the 1571?
	bne @not4171

	lda #DRV_1571		; indicates a 1571 at that device number
	bne @get_next_drive

@not4171:			; check for 1581
	jsr @close_cmd_channel
	jsr @open_cmd_channel
	ldx #<info1581		; check to see if it is a 1581 drive
	ldy #>info1581
	jsr @open_cmd_two

	jsr k_chrin		; gets the drive info
	cmp #'5'		; is it a '5' for a 15xx drive?
	bne @not81
	jsr k_chrin		; gets the next drive number
	cmp #'8'		; is it a '8' for a 1581?
	bne @not81

	lda #DRV_1581		; indicates a 1581 at that device number
	bne @get_next_drive

@not81:	; foreign drive exists, but mark it as a missing device (no built-in drivers)
	lda #DRV_NULL

@get_next_drive:
	ldy curDevice
	sta drives,y
	jsr @close_cmd_channel
	ldy curDevice
	iny			; increment table offset
	jmp @scanloop

@close_cmd_channel:
	jsr k_clrchn
	lda #15			; lfn
	jmp k_close

@open_cmd_channel:
	lda #15			; lfn
	tay			; sa for command channel
	ldx curDevice
	jsr k_setlfs		; set up the open sequence
	lda #6			; length of command (m-r command)
	rts

@open_cmd_two:
	jsr k_setnam		; sends the command
	jsr k_open		; opens the file
	ldx #15			; lfn
	jmp k_chkin		; redirect input

cbminfo:	; gets CBM drive info at $e5c5 in drive ROM
	.byte "M-R"
	.word $e5c5
	.byte 2

info1581:	; gets 1581 drive info at $a6e8 in drive ROM
	.byte "M-R"
	.word $a6e8
	.byte 2

.endif

