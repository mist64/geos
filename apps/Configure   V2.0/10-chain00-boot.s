
.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc" 
.include "jumptab.inc"

.import __STARTUP_RUN__
.import __STARTUP_SIZE__
.import __OVERLAY1_SIZE__
.global APP_START

chain1LoadAddr = __STARTUP_RUN__+__STARTUP_SIZE__	; $1162
chain1RunAddr  = chain1LoadAddr+$a3			; $1205
chain1EndAddr  = chain1LoadAddr+__OVERLAY1_SIZE__	; $1da5 ($1162+$0c43)

; NOTE:
; as long as GUI (chain1) is in binary form
; *NOTHING* can be changed in this code as parts here are called from GUI as click actions
; clearly CONFIGURE chain #0 (boot code) contains too much code not used during boot process

; inside GUI code
L15A6	= $15A6			; a byte that is decremented
L1AD1	= $1AD1			; a function

; outsize GUI
L1DA5	= chain1EndAddr		; buffer for 1(+1?) for found filenames ; 1da5

RamCheckBufCheck = $1DB6	; 8 bytes for RamCheckString
RamCheckBufBuffer = RamCheckBufCheck+8 ; 8 bytes for RamCheckString ; $1DBE
L1DC6   = RamCheckBufBuffer+8	; next byte after RamCheckBufBuffer ; $1DC7
L1DC7   = $1DC7
bootDriveNumber   = $1DC8
bootDriveType   = $1DC9
L1DCA   = $1DCA
L1DCB   = $1DCB
L1DCC   = $1DCC
L1DCD   = $1DCD
L1DCE   = $1DCE			; buffer for $20 bytes ; $1DCE
L1DEF   = L1DCE+$21		; $1DEF
L1DF0   = $1DF0
L1DF3   = $1DF3
L1DF4   = $1DF4
;RunREU  = $6000
L6216   = $6216

L88C7   = ramBase
_ramBase = ramBase-8

DRIVER_BASE_REU	= $3C80		; space for 4*$0d80 = $3600 disk drivers in REU bank 0

; GEOS Kernal fixed locations
version		= $C00F		; GEOS version, $20 = 2.0, $13 = 1.3
sysFlgCopy	= $C012
c128Flag	= $C013		; bit 7==1 -> GEOS 128

; CBM Kernal jumptable
kernal_LSTNSA	= $FF93
kernal_TALKSA	= $FF96
kernal_IECIN	= $FFA5
kernal_IECOUT	= $FFA8
kernal_UNTALK	= $FFAB
kernal_UNLSTN	= $FFAE
kernal_LISTEN	= $FFB1
kernal_TALK	= $FFB4
 

	.segment "STARTUP"

_confDriveType = *-8
confDriveType:			; this is indexed by drive device number
	; 0406 == __STARTUP__RUN__
	.byte    $02,$01	; drive 8 type 1571, drive 9 type 1541
	; 0408
confDriveType10:
        .byte    $00,$00	; drive 10 none, drive 11 unused (placeholder only)
	; 040a
_confSysRamFlg:
        .byte    $00	; sysRAMFlg / sysFlgCopy shadow


	; 040b
APP_START:
        JSR     patchKernal

	CmpBI	firstBoot, $ff	; is this run during boot?
        BNE     :+		; yes
        JMP     StartGUI	; no, it's application run, load GUI from chain #1

:	bbsf	7, c128Flag, exitApp	; are we on GEOS 128?

	MoveB	curDrive, bootDriveNumber	; .. no
        TAY
        LDA     _driveType,Y
        STA     bootDriveType
        JSR     disoverRamExpSize

        JSR     i_MoveData	; preserve booter code ($5000-$5400), why?
        .word	$5000 ; source
	.word	$1DFC ; dest (behind chain0+chain1+$0d80?)
	.word	$0400 ; length

	LoadB	NUMDRV, 1
        JSR     L0558

        LDA     bootDriveNumber
        JSR     L073D
        JSR     L0E32
        JSR     L0D6F

        LDA     ramExpSize
        BNE     :++

	CmpBI	NUMDRV, 2
        BCC     :++

        LDA     driveType
        CMP     driveType+1
        BNE     :+
        CMP     #DRV_1581
        BNE     :++

:	JSR     L0738
        JSR     PurgeTurbo
        JSR     L0738
	LoadB	NUMDRV, 1

:	JSR     i_MoveData	; restore booter code ($5000-$5400), why?
        .word	$1DFC ; source (see above)
	.word	$5000 ; dest
	.word	$0400 ; length

exitApp:
	JMP     EnterDeskTop

patchKernal:
	bbsf	7, c128Flag, :+	; skip if we're on GEOS 128
	CmpBI	version, $14	; skip if GEOS 64 version higher than 1.4
        BCS     :+
        JSR     PatchGEOS1_3
        JSR     L048F
:	RTS

L048F:
        LoadW	r0, $C310	; XXX $c310 - arbitrary address less than 255 bytes before L04C2 values are matched
        LDY     #$00
        STY     r1L
        JSR     L04A2

	LoadB	r1L, 5
L04A2:
        LDX     r1L
L04A4:
        LDA     (r0),Y
        CMP     L04C2,X
        BEQ     L04B3

        CPX     r1L
        BNE     L04A2

        INY
        BNE     L04A2

        RTS

L04B3:
        INY
        BNE     L04B7

        RTS

L04B7:
        INX
        LDA     L04C2,X
        BNE     L04A4

        LDA     #$34		; patch GEOS Kernal to use CMP #"4" instead of CMP "5" in _EnterDeskTop at fileHeader+O_GHFNAME+15; DeskTop minor version number???
        STA     (r0),Y
        RTS

L04C2:
        .byte    $AD,$5C,$81,$C9,$00 ; 4 bytes compared against _EnterDeskTop content at $c38d:
		;LDA fileHeader+O_GHFNAME+15
		;CMP #"5" ; <- without the final '5' value

        .byte    " V1.",$00	; what/s that for? $04c7

PatchGEOS1_3:
	CmpBI	version, $13	; GEOS 1.3?
        BNE     :+

	MoveW	SetDevice+1, r0
        LDY     #0
        LDA     (r0),Y
        CMP     #$EA		; opcode NOP
        BEQ     :+

        LDY     #$03
        LDA     #$3D		; opcode AND $xxxx,X or address?
        STA     (r0),Y
:	RTS

StartGUI:
        JSR     OpenConfigureFile
	bnex	:+

        LDA	#1			; chain 1
        JSR	PointRecord

	LoadW	r7, chain1LoadAddr 		; chain 1 load address
	LoadW_	r2, $ffff 		; length
        JSR	ReadRecord
        bnex	:+
        JMP     chain1RunAddr			; chain 1 start address
:	JMP     EnterDeskTop 		; error

ConfigureClass:
        .byte    "Configure   V2.0",$00

OpenConfigureFile:
        LDX     #$00
        LDA     ConfigureFileOpenedFlag	; are we open?
        BNE     :+			; yes, skip this procedure

	LoadW	r6, L1DA5
	LoadB	r7L, AUTO_EXEC
	LoadB	r7H, 1 ; number of files found
	LoadW	r10, ConfigureClass
        JSR     FindFTypes
	bnex	:+

	LoadW	r0, L1DA5
        JSR     OpenRecordFile

        LoadB	ConfigureFileOpenedFlag, $ff	; mark that this file (CONFIGURE) is open
:	RTS

L0558:
        JSR     ExitTurbo

        LDA     ramExpSize
        BEQ     :+

        LDA     _confSysRamFlg
:	AND     #%10100000
        STA     sysRAMFlg
        STA     sysFlgCopy
	CmpBI	bootDriveType, DRV_1571
        BCS     :+

        JSR     discoverDriveType
        CMP     #$FF
        BNE     :+
        LDA     #$01
:	STA     L1DCA

        LDA     curDrive
        EOR     #$01
        JSR     SetDevice
        JSR     discoverDriveType
        CMP     #$FF
        BNE     :+
        LDA     #$00
:	STA     L1DCB

        LDA     ramExpSize
        BEQ     :+

        LDA     #10
        JSR     SetDevice
        JSR     discoverDriveType
        CMP     #$FF
        BNE     :++
:	LDA     #$00
:	STA     L1DCC

        LDA     bootDriveNumber
        JSR     SetDevice

        JSR     L06B1

        JSR     CloseConfigure
	bnex	:+++

        JSR     PurgeTurbo

        LDY     #$03
	LoadB	NUMDRV, 0
:	STA     driveType,Y
        STA     turboFlags,Y
        STA     _ramBase,Y
        STA     L88C7,Y
        DEY
        BPL	:-

        JSR     L05F8

        LDA     L1DCA
        JSR     L0768

        LDA     L1DCB
        BEQ     :+

        JSR     L0738

        LDA     L1DCB
        JSR     L0768

:	LDA     L1DCC
        BEQ     :+

        LDA     #$0A
        JSR     L073D

        LDA     L1DCC
        JSR     L0768

:	RTS


L05F8:
        LDA     ramExpSize
        BEQ     :++			; skip if no ram expansion

	LoadB	L1DEF, 8
	MoveB	L1DCA, L1DF3
:	JSR     L0986			; do this for every drive
        INC     L1DEF
	CmpBI	L1DEF, 8+4
        BNE	:-
:	RTS

;0616, no jump to here? only from GUI?
.assert *=$0616, error, "Function at $0616"
InstDrvr: 				; Install driver at DISK_BASE
        LDY     curDrive
        LDA     _driveType,Y
        BEQ     :+

        TAY
        JSR     L0A32

        LDA     L06AD,Y
        BNE     :+

        LDA     #$FF
        STA     L06AD,Y
        LDA     DriverOffsetsL,Y
        STA     r1L			; dest
        LDA     DriverOffsetsH,Y
        STA     r1H
	LoadW	r0, DISK_BASE		; source
	LoadW	r2, DISK_DRV_LGH	; length
        JSR     MoveData
:	RTS


CloseConfigure:
        LDA     L1DCA
        JSR     LoadDrvr
        BNE	:+

        LDA     L1DCB
        JSR     LoadDrvr
        BNE	:+

        LDA     L1DCC
        JSR     LoadDrvr
        BNE	:+

        LDX     #0
        LDA     ConfigureFileOpenedFlag		; is CONFIGURE closed?
        BEQ     :+				; yes, skip

        JSR     CloseRecordFile			; close it now
        LoadB	ConfigureFileOpenedFlag, 0	; and flag that it's closed
:	RTS

LoadDrvr:					; Load Driver into buffer	
	; input A = number of driver or driver type or drive number (0-3)
        LDX     #$00
        TAY
        BEQ     :+

        JSR     L0A32

        LDA     L06AD,Y				; was it already loaded?
        BNE	:+

        TYA
        PHA
        JSR     OpenConfigureFile
        PLA
        TAY
	bnex	:+

        LDA     #$FF
        STA     L06AD,Y				; mark that this chain was loaded?
        LDA     DriverOffsetsL,Y
        STA     r7L				; buffer for ReadRecord
        LDA     DriverOffsetsH,Y
        STA     r7H
        TYA
	addv	2				; skip over first two chains (boot, gui)
        JSR     PointRecord

	LoadW	r2, DISK_DRV_LGH		; length
        JSR     ReadRecord

:	TXA
        RTS

ConfigureFileOpenedFlag:
        .byte    $00	; 0 = file closed, 1 = CONFIGURE file open (for chain reading)

L06AD:
        .byte    $00,$00,$00,$00		; marks that these chains (disk drivers from CONFIGURE) were loaded?

L06B1:
	LoadB	r0L, 1
        LDA     bootDriveNumber
        EOR     #$01
        TAY
        LDA     _confDriveType,Y
        LDX     L1DCB
        JSR     L06EA

        STA     L1DCB
        LDY     bootDriveNumber
        LDA     _confDriveType,Y
        AND     #%01111111
        LDX     L1DCA
        JSR     L06EA

        STA     L1DCA
        LDA     ramExpSize
        BEQ     :+

        LDA     confDriveType10
        LDX     L1DCC
        JSR     L06EA

:	STA     L1DCC
        RTS

L06EA:
        STX     r2L
        STA     r2H
        JSR     L0973

        CLC
        ADC     r0L
        CMP     ramExpSize
        BCC     :+
        BEQ     :+

        LDA     r2H
        AND     #%00111111
        STA     r2H
        LDA     r0L
:	STA     r0H
        LDA     r2H
        BPL     :+
	MoveB	r0H, r0L
        LDA     r2H
        RTS

:	AND     #%00001111
        CMP     #1
        BNE     :+
	CmpBI	r2L, 2
        BNE     :+
	LoadB	r2L, 1

:	LDA     r2H
        AND     #%01000000
        BEQ     :+
        LDA     r2H
        AND     #%00001111
        CMP     r2L
        BNE     :+
	MoveB	r0H, r0L
        LDA     r2H
        RTS

:	LDA     r2L
        RTS

L0738:
        LDA     curDrive
        EOR     #$01
L073D:
        JSR     SetDevice
	bnex	:+++

        LDA     ramExpSize
        BNE     :++


        PushB	L1DF3
        LDY     curDrive
        LDA     _driveType,Y
        BEQ     :+
        STA     L1DF3
        JSR     L0986

:	PopB	L1DF3
:	LDY     curDrive
        LDA     _driveType,Y
        STA     curType
:	RTS

L0768:
        PHA
	LoadB	L1DF0, 0
	MoveB	curDrive, L1DEF
        PLA
        BEQ     L07AE

        CMP     #DRV_1541
        BNE     L077E
        JMP     L07AF

L077E:
        CMP     #DRV_1571
        BNE     L0785
        JMP     L07D7

L0785:
        CMP     #DRV_1581
        BNE     L078C
        JMP     L07E7

L078C:
        CMP     #$40+DRV_1541		; 1541 with RAM shadow
        BNE     L0796
        JSR     L07AF
        JMP     L07F7

L0796:
        CMP     #$40+DRV_1581		; 1581 with RAM shadow
        BNE     L07A0
        JSR     L07E7
        JMP     L0818

L07A0:
        CMP     #$80+DRV_1541		; RAM 1541
        BNE     L07A7
        JMP     L0839

L07A7:
        CMP     #$80+DRV_1571		; RAM 1571
        BNE     L07AE
        JMP     L086B

L07AE:
        RTS

L07AF:	CmpBI	L1DF0, DRV_1541
        BEQ     :++

        CMP     #$40+DRV_1541
        BNE     :+

        LDY     L1DEF
        LDA     #$01
        STA     _driveType,Y
        STA     _confDriveType,Y
        LDA     #$00
        STA     _ramBase,Y
        DEC     L15A6
        RTS

:	LoadB	L1DF3, DRV_1541
        JMP     L089D
:	RTS

L07D7:	CmpBI	L1DF0, DRV_1571
        BEQ     :+
	LoadB	L1DF3, DRV_1571
        JMP     L089D
:	RTS

L07E7:	CmpBI	L1DF0, DRV_1581
        BEQ     :+
	LoadB	L1DF3, DRV_1581
        JMP     L089D
:	RTS

L07F7:	CmpBI	L1DF0, $40+DRV_1541
        BEQ     :+
        LDA     #$40+DRV_1541
        JSR     L08D7
        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$40+DRV_1541
        STA     _driveType,Y
        STA     _confDriveType,Y
        JSR     NewDisk
        DEC     L15A6
:	RTS

L0818:	CmpBI	L1DF0, $40+DRV_1581
        BEQ     :+
        LDA     #$40+DRV_1581
        JSR     L08D7
        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$40+DRV_1581
        STA     _driveType,Y
        STA     _confDriveType,Y
        JSR     NewDisk
        DEC     L15A6
:	RTS

L0839:	CmpBI	L1DF0, $80+DRV_1541
        BEQ     :+
	LoadB	L1DF3, $80+DRV_1541
        JSR     L0986
        INC     NUMDRV
        LDA     #$80+DRV_1541
        JSR     L08D7
        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$80+DRV_1541
        STA     _driveType,Y
        STA     _confDriveType,Y
        LDA     L1DEF
        JSR     L073D
        JSR     L0A3E
        DEC     L15A6
:	RTS

L086B:	CmpBI	L1DF0, $80+DRV_1571
        BEQ     :+
	LoadB	L1DF3, $80+DRV_1571
        JSR     L0986
        INC     NUMDRV
        LDA     #$80+DRV_1571
        JSR     L08D7
        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$80+DRV_1571
        STA     _driveType,Y
        STA     _confDriveType,Y
        LDA     L1DEF
        JSR     L073D
        JSR     L0A3E
        DEC     L15A6
:	RTS

L089D:
        JSR     L0986

        LDA     L1DEF
        JSR     L073D

	CmpBI	firstBoot, $ff
        BEQ     :+

        LDY     L1DEF
        LDA     L1DF3
        STA     _driveType,Y
        INC     NUMDRV
	bra	:++

:	JSR     L1AD1
        LDA     L1DEF
        JSR     L073D

:	DEC     L15A6
        LDY     L1DEF
        LDA     _driveType,Y
        STA     _confDriveType,Y
        LDA     #$00
        STA     _ramBase,Y
        RTS

L08D7:
        PHA
        JSR     L093D

	PopB	r0L
        LDA     L1DF0
        AND     #%11000000
        BNE     L08F0

        LDA     r0L
        JSR     L0973

        CMP     #$01
        BEQ     L08F9
        BNE     L090B

L08F0:
        LDY     L1DEF
        LDA     _ramBase,Y
        LDX     #$00
        RTS

L08F9:
        LDY     ramExpSize
L08FC:
        DEY
        BMI     L0908

        LDA     L1DF4,Y
        BNE     L08FC

        TYA
        LDX     #$00
        RTS

L0908:
        LDX     #$FF
        RTS

L090B:
        STA     r0L
        LDY     #$00
L090F:	MoveB	r0L, r0H
L0913:	STY     r1L
        CPY     ramExpSize
        BCS     L093A

        LDA     L1DF4,Y
        INY
        CMP     #$00
        BNE     L0913

L0922:
        DEC     r0H
        BEQ     L0935

        CPY     ramExpSize
        BCS     L093A

        LDA     L1DF4,Y
        INY
        CMP     #$00
        BNE     L090F
        BEQ     L0922

L0935:
        LDA     r1L
        LDX     #$00
        RTS

L093A:
        LDX     #$FF
        RTS

L093D:
        LDY     #$07
        LDA     #$00
L0941:
        STA     L1DF4,Y
        DEY
        BPL     L0941

	LoadB	L1DF4, $ff
	LoadB	r0L, 8
L0950:
        LDY     r0L
        LDA     _driveType,Y
        JSR     L0973

        TAX
        BEQ     L096A

        LDY     r0L
        LDA     _ramBase,Y
        TAY
L0961:
        LDA     #$FF
        STA     L1DF4,Y
        INY
        DEX
        BNE     L0961

L096A:
        INC     r0L
	CmpBI	r0L, 12
        BCC     L0950

        RTS

L0973:
        STA     r0H
        AND     #%11000000
        BEQ     L0981

        LDA     r0H
        AND     #%00001111
        TAY
        LDA     L0982,Y
L0981:
        RTS

L0982:
        .byte    $03,$03

        .byte    $06,$01

L0986:
        LDA     ramExpSize
        BNE     L09AE

        LDA     sysRAMFlg
        AND     #%10111111
        STA     sysRAMFlg
        STA     sysFlgCopy
        STA     _confSysRamFlg
        LDY     L1DF3
        LDA     L1DEF
        JSR     L09FB

	LoadW	r1, DISK_BASE	; dest = disk driver
        JSR     MoveData
        RTS

L09AE:
        LDA     sysRAMFlg
        ORA     #%01000000
        STA     sysRAMFlg
        STA     sysFlgCopy
        STA     _confSysRamFlg

        LDY     driveType
        BEQ     :+
        LDA     #$08
        JSR     L09FB
        JSR     StashRAM

:	LDY     driveType+1
        BEQ     :+
        LDA     #$09
        JSR     L09FB
        JSR     StashRAM

:	LDY     driveType+2
        BEQ     :+
        LDA     #$0A
        JSR     L09FB
        JSR     StashRAM

:	LDY     L1DF3
        LDA     L1DEF
        JSR     L09FB
        JSR     StashRAM

	LoadW	r1, DISK_BASE	; dest = disk driver
        JSR     MoveData
        RTS

L09FB:
        PHA
        JSR     L0A32

        LDA     DriverOffsetsL,Y
        STA     r0L			; source
        LDA     DriverOffsetsH,Y
        STA     r0H
        PLA
        TAY
        LDA     DriverOffsetsL,Y
        STA     r1L			; dest
        LDA     DriverOffsetsH,Y
        STA     r1H
	LoadW	r2, DISK_DRV_LGH	; length
	LoadB	r3L, 0			; bank
        RTS

.define DriverOffsets DRIVER_BASE_REU, DRIVER_BASE_REU + 1 * DISK_DRV_LGH, DRIVER_BASE_REU + 2 * DISK_DRV_LGH, DRIVER_BASE_REU + 3 * DISK_DRV_LGH

DriverOffsetsL:
	.lobytes DriverOffsets
DriverOffsetsH:
	.hibytes DriverOffsets

	; 0A2A = DriverOffsetsL+8
        .byte    $00,$80,$00,$80,$83,$90,$9E,$AB

L0A32:
        TYA
        BPL     L0A39

        LDY     #$03
        BNE     L0A3D

L0A39:
        AND     #$0F
        TAY
        DEY
L0A3D:
        RTS

L0A3E:
        LDY     #$00
        TYA
L0A41:
        STA     curDirHead,Y
        INY
        BNE     L0A41

	LoadB	ramDiskName, '4'			; '4' as 'RAM1541'
	LoadB	doubleSidedFlag, $00		; single sided
        LDY     curDrive
        LDA     _driveType,Y
        AND     #%00001111
        LDY     #$BD
        CMP     #DRV_1541
        BEQ     :+
        LDY     #$00
	LoadB	ramDiskName, '7'			; '7' as 'RAM1571'
	LoadB	doubleSidedFlag, $80		; double sided
:	DEY
        LDA     dirHeadTemplate,Y
        STA     curDirHead,Y
        TYA
        BNE     :-

        LDY     curDrive
        LDA     _driveType,Y
        AND     #%00001111
        CMP     #DRV_1541
        BEQ	@SaveDirHead			; RAM1541, skip over dir2Head preparations

        LDY     #0
        TYA
:	STA     dir2Head,Y
        INY
        BNE     :-

        LDY     #$69
:	DEY
        LDA     dir2HeadTemplate,Y
        STA     dir2Head,Y
        TYA
        BNE     :-

@SaveDirHead:				; 0a96
        JSR     PutDirHead

        JSR     L0AC0

	LoadB	diskBlkBuf+1, $ff	; clear link to next sector
	LoadW	r4, diskBlkBuf		; buffer
	LoadB	r1L, 18			; dir track
	LoadB	r1H, 1			; 1st dir entry sector
        JSR     PutBlock

        INC     r1L			; off-page directory track = 19 (see below in template)
	LoadB	r1H, 8			; off-page directory sector = 8 (see below in template)
        JSR     PutBlock

        LDA     #$00
        RTS

L0AC0:
        LDY     #$00
        TYA
L0AC3:
        STA     OS_VARS,Y
        DEY
        BNE     L0AC3

        RTS

dirHeadTemplate:					; 0aca
        .byte    $12,$01,$41

doubleSidedFlag:					; 0acd
        .byte    $00,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$15,$FF,$FF
        .byte    $1F,$15,$FF,$FF,$1F,$11,$FC,$FF
        .byte    $07,$12,$FF,$FE,$07,$13,$FF,$FF
        .byte    $07,$13,$FF,$FF,$07,$13,$FF,$FF
        .byte    $07,$13,$FF,$FF,$07,$13,$FF,$FF
        .byte    $07,$12,$FF,$FF,$03,$12,$FF,$FF
        .byte    $03,$12,$FF,$FF,$03,$12,$FF,$FF
        .byte    $03,$12,$FF,$FF,$03,$12,$FF,$FF
        .byte    $03,$11,$FF,$FF,$01,$11,$FF,$FF
        .byte    $01,$11,$FF,$FF,$01,$11,$FF,$FF
        .byte    $01,$11,$FF,$FF,$01

ramDiskName = * + 6
	.byte	"RAM 1571"

        .byte    $A0,$A0,$A0,$A0,$A0,$A0
        .byte    $A0,$A0,$A0,$A0
	.byte	"RD",$A0,"2A"
        .byte    $A0,$A0,$A0,$A0
	.byte	19, 8					; off-page directory OFF_OP_TR_SC t&s
	.byte	"GEOS format V1.0"
        .byte    $00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$15
        .byte    $15,$15,$15,$15,$15,$15,$15,$15
        .byte    $15,$15,$15,$15,$15,$15,$15,$15
        .byte    $00,$13,$13,$13,$13,$13,$13,$12
        .byte    $12,$12,$12,$12,$12,$11,$11,$11
        .byte    $11,$11

dir2HeadTemplate:
        .byte    $FF,$FF,$1F,$FF,$FF,$1F,$FF,$FF
        .byte    $1F,$FF,$FF,$1F,$FF,$FF,$1F,$FF
        .byte    $FF,$1F,$FF,$FF,$1F,$FF,$FF,$1F
        .byte    $FF,$FF,$1F,$FF,$FF,$1F,$FF,$FF
        .byte    $1F,$FF,$FF,$1F,$FF,$FF,$1F,$FF
        .byte    $FF,$1F,$FF,$FF,$1F,$FF,$FF,$1F
        .byte    $FF,$FF,$1F,$00,$00,$00,$FF,$FF
        .byte    $07,$FF,$FF,$07,$FF,$FF,$07,$FF
        .byte    $FF,$07,$FF,$FF,$07,$FF,$FF,$07
        .byte    $FF,$FF,$03,$FF,$FF,$03,$FF,$FF
        .byte    $03,$FF,$FF,$03,$FF,$FF,$03,$FF
        .byte    $FF,$03,$FF,$FF,$01,$FF,$FF,$01
        .byte    $FF,$FF,$01,$FF,$FF,$01,$FF,$FF
        .byte    $01

discoverDriveType:				; 0c33
	LoadW	r0, $e580	; magic value in drive ROM at this address ???
        JSR     L0C6F

        CPX     #$00
        BNE     :+
        CMP     #$00
        BNE     :+

	LoadW	r0, $a6c0	; magic value in drive ROM at this address ???
        JSR     L0C6F

:	CPX     #$00
        BNE     @nodev

        TAX
        LDA     #DRV_1541
        CPX     #$41
        BEQ     :+

        LDA     #DRV_1571
        CPX     #$71
        BEQ     :+

        LDA     #DRV_1581
        CPX     #$81
        BEQ     :+

        LDA     #$FF		; unknown?
        BNE     :+

@nodev:	LDA     #$00		; none
:	RTS

L0C6F:
        JSR     L0CC4
	LoadW	r2, $0100
L0C7A:
        JSR     L0CD4

        CPX     #$00
        BNE     L0CC3

        CMP     #$31
        BNE     L0CB3

        JSR     L0CD4

        CMP     #$35
        BNE     L0CB3

        JSR     L0CD4

        STA     r1L
        AND     #$70
        CMP     #$30
        BNE     L0CB3

        LDA     r1L
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        STA     r1L
        JSR     L0CD4

        STA     r1H
        AND     #$70
        CMP     #$30
        BNE     L0CB3

        LDA     r1H
        AND     #$0F
        ORA     r1L
        LDX     #$00
        RTS

L0CB3:
        LDA     r2L
        BNE     :+
        DEC     r2H
:	DEC     r2L
        LDA     r2L
        ORA     r2H
        BNE     L0C7A

        LDX     #$00
L0CC3:
        RTS

L0CC4:
	MoveW	r0, driveMemoryReadAddr
	LoadB	L1DCD, $20
        RTS

L0CD4:
        LDY     L1DCD
        CPY     #$20
        BCS     :+

        LDA     L1DCE,Y
        INC     L1DCD
        LDX     #$00
        RTS

:	JSR     InitForIO
	LoadW	r0, driveMemoryReadCmd		; M-R command
        JSR     SendDOSCmd
        BEQ     :+
        JSR     DoneWithIO
        RTS

:	JSR     kernal_UNLSTN

        LDA     curDrive
        JSR     kernal_TALK

        LDA     #$FF
        JSR     kernal_TALKSA

        LDY     #$00
:	JSR     kernal_IECIN
        STA     L1DCE,Y
        INY
        CPY     #$20
        BCC	:-

        JSR     kernal_UNTALK

        LDA     curDrive
        JSR     kernal_LISTEN

        LDA     #$EF
        JSR     kernal_LSTNSA

        JSR     kernal_UNLSTN

        JSR     DoneWithIO

	LoadB	L1DCD, 0
	AddVW	$20, driveMemoryReadAddr
	bra	L0CD4

driveMemoryReadCmd:
	.byte	"M-R"
driveMemoryReadAddr:	
	.word	0
	.byte	$20	; length

SendDOSCmd:			; direct copy from disk driver
	LoadB	STATUS, 0
        LDA     curDrive
        JSR     kernal_LISTEN
	bbsf	7, STATUS, :++
        LDA     #$FF
        JSR     kernal_LSTNSA
	bbsf	7, STATUS, :++
        LDY     #0
:	LDA     (r0),Y
        JSR     kernal_IECOUT
        INY
        CPY     #6
        BCC	:-
        LDX     #$00
        RTS
:	JSR     kernal_UNLSTN
        LDX     #DEV_NOT_FOUND
        RTS

L0D6F:	LoadB	NUMDRV, 0
        LDY     #1
:	LDA     driveType,Y
        BEQ     :+
        INC     NUMDRV
:	DEY
        BPL     :--
        RTS

disoverRamExpSize:					; 0d82
        JSR     InitForIO

	LoadB	ramExpSize, 0
	LoadB	L1DC6, 2
	bbrf	4, EXP_BASE, L0D9B

	LoadB	L1DC6, 8	; max ram size = 8 banks?
L0D9B:
        LDA     EXP_BASE
        AND     #%11100000
        BNE     @nodev

	LoadB	EXP_BASE+2, $55
        CMP     EXP_BASE+2
        BNE     @nodev

	LoadB	EXP_BASE+2, $aa
        LDY     #$00
:	DEY
        BNE	:-		; wait a bit

        CMP     EXP_BASE+2
        BNE     @nodev

	LoadB	ramExpSize, 1
	LoadB	r3L, 0		; start with RAM bank 0

:	JSR     L0DDF
        BCC     @1

	CmpB	ramExpSize, L1DC6
        BEQ     @nodev		; max ram size = 8 banks?

        INC     ramExpSize
        INC     r3L		; next RAM bank
	bra	:-

@1:	DEC     ramExpSize
@nodev:
        JMP     DoneWithIO

L0DDF:
	LoadW	r0, RamCheckBufBuffer
	LoadW_	r1, 0
	LoadW	r2, RamCheckStringLen
        JSR     FetchRAM

	LoadW	r0, RamCheckString
        JSR     StashRAM

	LoadW	r0, RamCheckBufCheck
        JSR     FetchRAM

	LoadW	r0, RamCheckBufBuffer
        JSR     StashRAM

        LDY     #RamCheckStringLen-1
:	LDA     RamCheckString,Y
        CMP     RamCheckBufCheck,Y
        BNE	:+ 
        DEY
        BPL	:-
        SEC				; same here and there
        RTS
:	CLC				; different here and there
        RTS

RamCheckString:
        .byte    "RAMCheck"
RamCheckStringLen = *-RamCheckString


L0E32:	bbrf	5, sysRAMFlg, :+
        LDA     bootDriveNumber
        JSR     L073D
        JSR     L0E46
        JSR     L0EF6
:	RTS

L0E46:
        JSR     ClearRegistersLBytes
	LoadB	r0H, $84
	LoadB	r1H, $79
	LoadB	r2H, $05
        JSR     StashRAM

	bbsf	6, sysRAMFlg, :+

        JSR     ClearRegistersLBytes
	LoadB	r0H, $90
	LoadB	r1H, $83
	LoadW	r2, DISK_DRV_LGH
        JSR     StashRAM

:	JSR     ClearRegistersLBytes
	LoadB	r0L, $80			; stash $9d80-9fff
        STA     r2L
	LoadB	r0H, $9D
	LoadB	r1H, $B9			; to REU $0B900
	LoadB	r3L, 0
	LoadB	r2H, 2
        JSR     StashRAM

        JSR     ClearRegistersLBytes
	LoadW	r0, $BF40
        LoadW	r1, $BB80
	LoadW	r2, $10c0
        JSR     StashRAM

	LoadB	r4L, $30
	LoadW	r5, $d000
        LoadW	r0, $8000
        LoadW	r1, $cc40
        LoadW	r2, $0100
	LoadB	r3L, 0

:	LDY     #0
:	LDA     (r5),Y
        STA     OS_VARS,Y
        INY
        BNE     :-
        JSR     StashRAM
        INC     r5H
        INC     r1H
        DEC     r4L
        BNE     :--
        RTS

ClearRegistersLBytes:
        LDA     #0
        STA     r0L
        STA     r1L
        STA     r2L
        STA     r3L
        RTS

L0EF6:
        JSR     ClearRegistersLBytes
	LoadB	r1H, $7e
	LoadB	r2H, $05
	LoadW	r0, $0f0c
        JMP     StashRAM

;Rboot Fetch Sequence
;RE0_8300	0D80	K_9000	Boot Disk Driver (Always Drive 8)
;RE0_B900	$280	K_9D80	JmpIndx
;RE0_BB80	C0	K_BF40	Start of GEOS Kernal
;RE0_BCC0	$0F80	K_C080	Kernal
;RE0_CC40	$3000	K_D000	Kernal
;
;RE0_798E	4	Drive Types
;RE0_7A16	3	Year/Month/Day
;RE0_7DC3	2	Ram Exp Size
;RE0_7DC7	4	RamBanks for each Drive
;RE0_7E00	$500
;RE0_8300

	;The Remaining blocks are Stashed into the REU at 7E00
	;When a Ram Reboot starts this code is fetched to $6000.
	;This code cannot be changed without manualy recalculating the jsr address to
	;RBFetchRAM; Next version of geoProgrammer will be able to set psect address's
	;so inset blocks like this will work like any other.
	;Best way to changes here with
	;geoProgrammer as is, would be to start this with a single bra entry then RBStashRam
	;then the remainder of the code. That would make the entire reboot code relocatable
	;with no recompile/relink needed.


; XXX ??? no entry here
;REU RAM Reboot *= $6000
        SEI
        CLD
        LDX     #$FF
        TXS
	LoadB	CPU_DATA, RAM_64K
	LoadW	r0, $9000
        LoadW	r1, $8300
	LoadW	r2, DISK_DRV_LGH
        JSR     L6216

	LoadW	r0, $9D80
	LoadW	r1, $B900
	LoadW	r2, $0280
        JSR     L6216

	LoadW	r0, $BF40
	LoadW	r1, $BB80
	LoadW	r2, $00c0
        JSR     L6216

	LoadW	r0, $c080
	LoadW	r1, $BCC0
	LoadW	r2, $0F80
        JSR     L6216

	LoadB	r4L, $30
	LoadW	r5, $d000
	LoadW	r0, $8000
	LoadW	r1, $CC40
	LoadW	r2, $0100
:	JSR     L6216

        LDY     #0
:	LDA     OS_VARS,Y
        STA     (r5L),Y
        INY
        BNE     :-

        INC     r5H
        INC     r1H
        DEC     r4L
        BNE     :--

        JSR     i_FillRam
	.word	OS_VARS_LGH	; count
	.word	dirEntryBuf	; address
	.byte	$00		; value

L0FC2:
	LoadW_	r0, $A000	; clear screen with pattern
        LDX     #$7D
:	LDY     #$3F
:	LDA     #$55
        STA     (r0),Y
        DEY
        LDA     #$AA
        STA     (r0),Y
        DEY
        BPL     :-
	AddVW_	$40, r0
	DEX
        BNE     :--

        JSR     FirstInit

	LoadB	firstBoot, $ff
        JSR     END_MOUSE_128

	LoadW	r0, $88C3
	LoadW	r1, $7DC3
	LoadW	r2, $0002
        JSR     L6216

	MoveB	sysFlgCopy, sysRAMFlg
	LoadW	r0, $8516
	LoadW	r1, $7A16
	LoadW	r2, $0003
	LoadB	r3L, 0
        JSR     FetchRAM

	MoveB	cia1base+8, cia1base+8	; read+write TOD 1/10s seconds register, starts the clock
        LoadW	r0, $848e
	LoadW	r1, $798e
	LoadW	r2, $0004
        JSR     FetchRAM

	LoadW	r0, $88c7
	LoadW	r1, $7dc7
	LoadW	r2, $0004
        JSR     FetchRAM

	LoadW	r0, $8465
	LoadW	r1, $7965
	LoadW	r2, $0011
        JSR     FetchRAM

	LoadW	r0, $88CB
	LoadW	r1, $7DCB
	LoadW	r2, $0011
        JSR     FetchRAM

	LoadW	r0, $8489
	LoadW	r1, $7989
	LoadW	r2, $0001
        JSR     FetchRAM

        JSR     InitForIO
	LoadB	r0L, 4		; waiting loop
:	LDY     #0
        LDX     #0
:	DEY
        BNE     :-
        DEX
        BNE     :-
        DEC     r0L
        BNE     :--
        JSR     DoneWithIO

	PushB	curDrive
	LoadB	curDrive, 11
        STA     curDevice
	LoadB	NUMDRV, 0
        STA     curDevice
	LoadB	interleave, 8
        JSR     SetDevice

	LoadB	L1DC7, 8
L10F7:
        LDY     L1DC7
        LDA     _driveType,Y
        BEQ     L110F
        CPY     #$0A
        BCS     :+
        INC     NUMDRV
:	LDA     L1DC7
        JSR     SetDevice
        JSR     NewDisk

L110F:
        INC     L1DC7
	CmpBI	L1DC7, 12
        BCC     L10F7
        BEQ     L10F7

        PLA
        JSR     SetDevice
        JMP     EnterDeskTop

; XXX no entry point to this place?
        LDY     #$91
        LDX     CPU_DATA
	LoadB	CPU_DATA, IO_IN
	MoveW	r0, EXP_BASE+2
	MoveW	r1, EXP_BASE+4
	LoadB	EXP_BASE+6, 0
	MoveW	r2, EXP_BASE+7
        LDA     #0
        STA     EXP_BASE+9
        STA     EXP_BASE+10
        STY     EXP_BASE+1

:	LDA     EXP_BASE
        AND     #%01100000
        BEQ     :-

        STX     CPU_DATA
        RTS


; checks for binary data
.assert chain1LoadAddr=$1162, error, "Chain 1 (GUI) must start at $1162"
.assert chain1EndAddr=$1da5, error, "Chain 1 (GUI) must end at $1da5"


