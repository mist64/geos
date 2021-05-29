
; to make config.inc happy - GEOS 64 with 1541
bsw=1
drv1541=1

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc" 
.include "jumptab.inc"

.import __STARTUP_RUN__
.global APP_START

L1DB6   = $1DB6
L1DC6   = $1DC6
L1DC7   = $1DC7
L1DC8   = $1DC8
L1DC9   = $1DC9
L1DCA   = $1DCA
L1DCB   = $1DCB
L1DCC   = $1DCC
L1DCD   = $1DCD
L1DCE   = $1DCE
L1DEF   = $1DEF
L1DF0   = $1DF0
L1DF3   = $1DF3
L1DF4   = $1DF4
L522D   = $522D
;RunREU  = $6000
L6216   = $6216
L8001   = $8001
L848F   = $848F
L8490   = $8490
LDC08   = $DC08

L88C7   = ramBase
_ramBase = ramBase-8

LC00F	= $C00F
LC012	= $C012
LC013	= $C013

LC2B1	= SetDevice+1
LC2B2	= SetDevice+2

;EXP_BASE = $DF00
LDF01   = $DF01
LDF02   = $DF02
LDF03   = $DF03
LDF04   = $DF04
LDF05   = $DF05
LDF06   = $DF06
LDF07   = $DF07
LDF08   = $DF08
LDF09   = $DF09
LDF0A   = $DF0A
LFF93   = $FF93
LFF96   = $FF96
LFFA5   = $FFA5
LFFA8   = $FFA8
LFFAB   = $FFAB
LFFAE   = $FFAE
LFFB1   = $FFB1
LFFB4   = $FFB4
 

	.segment "STARTUP"
APP_START = __STARTUP_RUN__+5

L03FE = __STARTUP_RUN__-8

       
	.byte    $02,$01

L0408:
        .byte    $00,$00

L040A:
        .byte    $00

L040B:
        JSR     L047C

        LDA     firstBoot
        CMP     #$FF
        BNE     L0418

        JMP     L04EC

L0418:
        BIT     LC013
        BMI     L0479

        LDA     curDrive
        STA     L1DC8
        TAY
        LDA     _driveType,Y
        STA     L1DC9
        JSR     L0D82

        JSR     i_MoveData

        .word    $5000,$1DFC,$0400

L0436:
        LDA     #$01
        STA     NUMDRV
        JSR     L0558

        LDA     L1DC8
        JSR     L073D

        JSR     L0E32

        JSR     L0D6F

        LDA     ramExpSize
        BNE     L0470

        LDA     NUMDRV
        CMP     #$02
        BCC     L0470

        LDA     driveType
        CMP     L848F
        BNE     L0462

        CMP     #$03
        BNE     L0470

L0462:
        JSR     L0738

        JSR     PurgeTurbo

        JSR     L0738

        LDA     #$01
        STA     NUMDRV
L0470:
        JSR     i_MoveData

        .word    $1DFC,$5000,$0400

L0479:
        JMP     EnterDeskTop

L047C:
        BIT     LC013
        BMI     L048E

        LDA     LC00F
        CMP     #$14
        BCS     L048E

        JSR     L04CC

        JSR     L048F

L048E:
        RTS

L048F:
        LDA     #$C3
        STA     r0H
        LDA     #$10
        STA     r0L
        LDY     #$00
        STY     r1L
        JSR     L04A2

        LDA     #$05
        STA     r1L
L04A2:
        LDX     r1L
L04A4:
        LDA     (r0L),Y
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

        LDA     #$34
        STA     (r0L),Y
        RTS

L04C2:
        .byte    $AD,$5C,$81,$C9,$00

        .byte    " V1.",$00

L04CC:
        LDA     LC00F
        CMP     #$13
        BNE     L04EB

        LDA     LC2B2
        STA     r0H
        LDA     LC2B1
        STA     r0L
        LDY     #$00
        LDA     (r0L),Y
        CMP     #$EA
        BEQ     L04EB

        LDY     #$03
        LDA     #$3D
        STA     (r0L),Y
L04EB:
        RTS

L04EC:
        JSR     L0522

        TXA
        BNE     L050E

        LDA     #$01
        JSR     PointRecord

        LDA     #$11 ; chain 1 load address
        STA     r7H
        LDA     #$62
        STA     r7L
        LDA     #$FF
        STA     r2L
        STA     r2H
        JSR     ReadRecord

        TXA
        BNE     L050E

	L1205 = $1205 ; chain 1 start address
        JMP     L1205

L050E:
        JMP     EnterDeskTop

        .byte    "Configure   V2.0",$00

L0522:
        LDX     #$00
        LDA     L06AC
        BNE     L0557

        LDA     #$1D
        STA     r6H
        LDA     #$A5
        STA     r6L
        LDA     #$0E
        STA     r7L
        LDA     #$01
        STA     r7H
        LDA     #$05
        STA     r10H
        LDA     #$11
        STA     r10L
        JSR     FindFTypes

        TXA
        BNE     L0557

        LDA     #$1D
        STA     r0H
        LDA     #$A5
        STA     r0L
        JSR     OpenRecordFile

        LDA     #$FF
        STA     L06AC
L0557:
        RTS

L0558:
        JSR     ExitTurbo

        LDA     ramExpSize
        BEQ     L0563

        LDA     L040A
L0563:
        AND     #$A0
        STA     sysRAMFlg
        STA     LC012
        LDA     L1DC9
        CMP     #$02
        BCS     L057B

        JSR     L0C33

        CMP     #$FF
        BNE     L057B

        LDA     #$01
L057B:
        STA     L1DCA
        LDA     curDrive
        EOR     #$01
        JSR     SetDevice

        JSR     L0C33

        CMP     #$FF
        BNE     L058F

        LDA     #$00
L058F:
        STA     L1DCB
        LDA     ramExpSize
        BEQ     L05A3

        LDA     #$0A
        JSR     SetDevice

        JSR     L0C33

        CMP     #$FF
        BNE     L05A5

L05A3:
        LDA     #$00
L05A5:
        STA     L1DCC
        LDA     L1DC8
        JSR     SetDevice

        JSR     L06B1

        JSR     L064A

        TXA
        BNE     L05F7

        JSR     PurgeTurbo

        LDY     #$03
        LDA     #$00
        STA     NUMDRV
L05C1:
        STA     driveType,Y
        STA     turboFlags,Y
        STA     _ramBase,Y
        STA     L88C7,Y
        DEY
        BPL     L05C1

        JSR     L05F8

        LDA     L1DCA
        JSR     L0768

        LDA     L1DCB
        BEQ     L05E7

        JSR     L0738

        LDA     L1DCB
        JSR     L0768

L05E7:
        LDA     L1DCC
        BEQ     L05F7

        LDA     #$0A
        JSR     L073D

        LDA     L1DCC
        JSR     L0768

L05F7:
        RTS

L05F8:
        LDA     ramExpSize
        BEQ     L0615

        LDA     #$08
        STA     L1DEF
        LDA     L1DCA
        STA     L1DF3
L0608:
        JSR     L0986

        INC     L1DEF
        LDA     L1DEF
        CMP     #$0C
        BNE     L0608

L0615:
        RTS

        LDY     curDrive
        LDA     _driveType,Y
        BEQ     L0649

        TAY
        JSR     L0A32

        LDA     L06AD,Y
        BNE     L0649

        LDA     #$FF
        STA     L06AD,Y
        LDA     L0A22,Y
        STA     r1L
        LDA     L0A26,Y
        STA     r1H
        LDA     #$90
        STA     r0H
        LDA     #$00
        STA     r0L
        LDA     #$0D
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     MoveData

L0649:
        RTS

L064A:
        LDA     L1DCA
        JSR     L0672

        BNE     L0671

        LDA     L1DCB
        JSR     L0672

        BNE     L0671

        LDA     L1DCC
        JSR     L0672

        BNE     L0671

        LDX     #$00
        LDA     L06AC
        BEQ     L0671

        JSR     CloseRecordFile

        LDA     #$00
        STA     L06AC
L0671:
        RTS

L0672:
        LDX     #$00
        TAY
        BEQ     L06AA

        JSR     L0A32

        LDA     L06AD,Y
        BNE     L06AA

        TYA
        PHA
        JSR     L0522

        PLA
        TAY
        TXA
        BNE     L06AA

        LDA     #$FF
        STA     L06AD,Y
        LDA     L0A22,Y
        STA     r7L
        LDA     L0A26,Y
        STA     r7H
        TYA
        CLC
        ADC     #$02
        JSR     PointRecord

        LDA     #$0D
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     ReadRecord

L06AA:
        TXA
        RTS

L06AC:
        .byte    $00

L06AD:
        .byte    $00,$00,$00,$00

L06B1:
        LDA     #$01
        STA     r0L
        LDA     L1DC8
        EOR     #$01
        TAY
        LDA     L03FE,Y
        LDX     L1DCB
        JSR     L06EA

        STA     L1DCB
        LDY     L1DC8
        LDA     L03FE,Y
        AND     #$7F
        LDX     L1DCA
        JSR     L06EA

        STA     L1DCA
        LDA     ramExpSize
        BEQ     L06E6

        LDA     L0408
        LDX     L1DCC
        JSR     L06EA

L06E6:
        STA     L1DCC
        RTS

L06EA:
        STX     r2L
        STA     r2H
        JSR     L0973

        CLC
        ADC     r0L
        CMP     ramExpSize
        BCC     L0703

        BEQ     L0703

        LDA     r2H
        AND     #$3F
        STA     r2H
        LDA     r0L
L0703:
        STA     r0H
        LDA     r2H
        BPL     L0710

        LDA     r0H
        STA     r0L
        LDA     r2H
        RTS

L0710:
        AND     #$0F
        CMP     #$01
        BNE     L0720

        LDA     r2L
        CMP     #$02
        BNE     L0720

        LDA     #$01
        STA     r2L
L0720:
        LDA     r2H
        AND     #$40
        BEQ     L0735

        LDA     r2H
        AND     #$0F
        CMP     r2L
        BNE     L0735

        LDA     r0H
        STA     r0L
        LDA     r2H
        RTS

L0735:
        LDA     r2L
        RTS

L0738:
        LDA     curDrive
        EOR     #$01
L073D:
        JSR     SetDevice

        TXA
        BNE     L0767

        LDA     ramExpSize
        BNE     L075E

        LDA     L1DF3
        PHA
        LDY     curDrive
        LDA     _driveType,Y
        BEQ     L075A

        STA     L1DF3
        JSR     L0986

L075A:
        PLA
        STA     L1DF3
L075E:
        LDY     curDrive
        LDA     _driveType,Y
        STA     curType
L0767:
        RTS

L0768:
        PHA
        LDA     #$00
        STA     L1DF0
        LDA     curDrive
        STA     L1DEF
        PLA
        BEQ     L07AE

        CMP     #$01
        BNE     L077E

        JMP     L07AF

L077E:
        CMP     #$02
        BNE     L0785

        JMP     L07D7

L0785:
        CMP     #$03
        BNE     L078C

        JMP     L07E7

L078C:
        CMP     #$41
        BNE     L0796

        JSR     L07AF

        JMP     L07F7

L0796:
        CMP     #$43
        BNE     L07A0

        JSR     L07E7

        JMP     L0818

L07A0:
        CMP     #$81
        BNE     L07A7

        JMP     L0839

L07A7:
        CMP     #$82
        BNE     L07AE

        JMP     L086B

L07AE:
        RTS

L07AF:
        LDA     L1DF0
        CMP     #$01
        BEQ     L07D6

        CMP     #$41
        BNE     L07CE

        LDY     L1DEF
        LDA     #$01
        STA     _driveType,Y
        STA     L03FE,Y
        LDA     #$00
        STA     _ramBase,Y
	L15A6 = $15A6
        DEC     L15A6
        RTS

L07CE:
        LDA     #$01
        STA     L1DF3
        JMP     L089D

L07D6:
        RTS

L07D7:
        LDA     L1DF0
        CMP     #$02
        BEQ     L07E6

        LDA     #$02
        STA     L1DF3
        JMP     L089D

L07E6:
        RTS

L07E7:
        LDA     L1DF0
        CMP     #$03
        BEQ     L07F6

        LDA     #$03
        STA     L1DF3
        JMP     L089D

L07F6:
        RTS

L07F7:
        LDA     L1DF0
        CMP     #$41
        BEQ     L0817

        LDA     #$41
        JSR     L08D7

        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$41
        STA     _driveType,Y
        STA     L03FE,Y
        JSR     NewDisk

        DEC     L15A6
L0817:
        RTS

L0818:
        LDA     L1DF0
        CMP     #$43
        BEQ     L0838

        LDA     #$43
        JSR     L08D7

        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$43
        STA     _driveType,Y
        STA     L03FE,Y
        JSR     NewDisk

        DEC     L15A6
L0838:
        RTS

L0839:
        LDA     L1DF0
        CMP     #$81
        BEQ     L086A

        LDA     #$81
        STA     L1DF3
        JSR     L0986

        INC     NUMDRV
        LDA     #$81
        JSR     L08D7

        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$81
        STA     _driveType,Y
        STA     L03FE,Y
        LDA     L1DEF
        JSR     L073D

        JSR     L0A3E

        DEC     L15A6
L086A:
        RTS

L086B:
        LDA     L1DF0
        CMP     #$82
        BEQ     L089C

        LDA     #$82
        STA     L1DF3
        JSR     L0986

        INC     NUMDRV
        LDA     #$82
        JSR     L08D7

        LDY     L1DEF
        STA     _ramBase,Y
        LDA     #$82
        STA     _driveType,Y
        STA     L03FE,Y
        LDA     L1DEF
        JSR     L073D

        JSR     L0A3E

        DEC     L15A6
L089C:
        RTS

L089D:
        JSR     L0986

        LDA     L1DEF
        JSR     L073D

        LDA     firstBoot
        CMP     #$FF
        BEQ     L08BC

        LDY     L1DEF
        LDA     L1DF3
        STA     _driveType,Y
        INC     NUMDRV
        CLV
        BVC     L08C5

L08BC:
	L1AD1 = $1ad1
        JSR     L1AD1

        LDA     L1DEF
        JSR     L073D

L08C5:
        DEC     L15A6
        LDY     L1DEF
        LDA     _driveType,Y
        STA     L03FE,Y
        LDA     #$00
        STA     _ramBase,Y
        RTS

L08D7:
        PHA
        JSR     L093D

        PLA
        STA     r0L
        LDA     L1DF0
        AND     #$C0
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
L090F:
        LDA     r0L
        STA     r0H
L0913:
        STY     r1L
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

        LDA     #$FF
        STA     L1DF4
        LDA     #$08
        STA     r0L
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
        LDA     r0L
        CMP     #$0C
        BCC     L0950

        RTS

L0973:
        STA     r0H
        AND     #$C0
        BEQ     L0981

        LDA     r0H
        AND     #$0F
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
        AND     #$BF
        STA     sysRAMFlg
        STA     LC012
        STA     L040A
        LDY     L1DF3
        LDA     L1DEF
        JSR     L09FB

        LDA     #$90
        STA     r1H
        LDA     #$00
        STA     r1L
        JSR     MoveData

        RTS

L09AE:
        LDA     sysRAMFlg
        ORA     #$40
        STA     sysRAMFlg
        STA     LC012
        STA     L040A
        LDY     driveType
        BEQ     L09C9

        LDA     #$08
        JSR     L09FB

        JSR     StashRAM

L09C9:
        LDY     L848F
        BEQ     L09D6

        LDA     #$09
        JSR     L09FB

        JSR     StashRAM

L09D6:
        LDY     L8490
        BEQ     L09E3

        LDA     #$0A
        JSR     L09FB

        JSR     StashRAM

L09E3:
        LDY     L1DF3
        LDA     L1DEF
        JSR     L09FB

        JSR     StashRAM

        LDA     #$90
        STA     r1H
        LDA     #$00
        STA     r1L
        JSR     MoveData

        RTS

L09FB:
        PHA
        JSR     L0A32

        LDA     L0A22,Y
        STA     r0L
        LDA     L0A26,Y
        STA     r0H
        PLA
        TAY
        LDA     L0A22,Y
        STA     r1L
        LDA     L0A26,Y
        STA     r1H
        LDA     #$0D
        STA     r2H
        LDA     #$80
        STA     r2L
        LDA     #$00
        STA     r3L
        RTS

L0A22:
        .byte    $80,$00,$80,$00

L0A26:
        .byte    $3C,$4A,$57,$65

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

        LDA     #$34
        STA     L0B60
        LDA     #$00
        STA     L0ACD
        LDY     curDrive
        LDA     _driveType,Y
        AND     #$0F
        LDY     #$BD
        CMP     #$01
        BEQ     L0A6B

        LDY     #$00
        LDA     #$37
        STA     L0B60
        LDA     #$80
        STA     L0ACD
L0A6B:
        DEY
        LDA     L0ACA,Y
        STA     curDirHead,Y
        TYA
        BNE     L0A6B

        LDY     curDrive
        LDA     _driveType,Y
        AND     #$0F
        CMP     #$01
        BEQ     L0A96

        LDY     #$00
        TYA
L0A84:
        STA     dir2Head,Y
        INY
        BNE     L0A84

        LDY     #$69
L0A8C:
        DEY
        LDA     L0BCA,Y
        STA     dir2Head,Y
        TYA
        BNE     L0A8C

L0A96:
        JSR     PutDirHead

        JSR     L0AC0

        LDA     #$FF
        STA     L8001
        LDA     #$80
        STA     r4H
        LDA     #$00
        STA     r4L
        LDA     #$12
        STA     r1L
        LDA     #$01
        STA     r1H
        JSR     PutBlock

        INC     r1L
        LDA     #$08
        STA     r1H
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

L0ACA:
        .byte    $12,$01,$41

L0ACD:
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
        .byte    $01,$11,$FF,$FF,$01,$52,$41,$4D
        .byte    $20,$31,$35

L0B60:
        .byte    $37,$31,$A0,$A0,$A0,$A0,$A0,$A0
        .byte    $A0,$A0,$A0,$A0,$52,$44,$A0,$32
        .byte    $41,$A0,$A0,$A0,$A0,$13,$08,$47
        .byte    $45,$4F,$53,$20,$66,$6F,$72,$6D
        .byte    $61,$74,$20,$56,$31,$2E,$30,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$00
        .byte    $00,$00,$00,$00,$00,$00,$00,$15
        .byte    $15,$15,$15,$15,$15,$15,$15,$15
        .byte    $15,$15,$15,$15,$15,$15,$15,$15
        .byte    $00,$13,$13,$13,$13,$13,$13,$12
        .byte    $12,$12,$12,$12,$12,$11,$11,$11
        .byte    $11,$11

L0BCA:
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

L0C33:
        LDA     #$E5
        STA     r0H
        LDA     #$80
        STA     r0L
        JSR     L0C6F

        CPX     #$00
        BNE     L0C51

        CMP     #$00
        BNE     L0C51

        LDA     #$A6
        STA     r0H
        LDA     #$C0
        STA     r0L
        JSR     L0C6F

L0C51:
        CPX     #$00
        BNE     L0C6C

        TAX
        LDA     #$01
        CPX     #$41
        BEQ     L0C6E

        LDA     #$02
        CPX     #$71
        BEQ     L0C6E

        LDA     #$03
        CPX     #$81
        BEQ     L0C6E

        LDA     #$FF
        BNE     L0C6E

L0C6C:
        LDA     #$00
L0C6E:
        RTS

L0C6F:
        JSR     L0CC4

        LDA     #$01
        STA     r2H
        LDA     #$00
        STA     r2L
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
        BNE     L0CB9

        DEC     r2H
L0CB9:
        DEC     r2L
        LDA     r2L
        ORA     r2H
        BNE     L0C7A

        LDX     #$00
L0CC3:
        RTS

L0CC4:
        LDA     r0H
        STA     L0D41
        LDA     r0L
        STA     L0D40
        LDA     #$20
        STA     L1DCD
        RTS

L0CD4:
        LDY     L1DCD
        CPY     #$20
        BCS     L0CE4

        LDA     L1DCE,Y
        INC     L1DCD
        LDX     #$00
        RTS

L0CE4:
        JSR     InitForIO

        LDA     #$0D
        STA     r0H
        LDA     #$3D
        STA     r0L
        JSR     L0D43

        BEQ     L0CF8

        JSR     DoneWithIO

        RTS

L0CF8:
        JSR     LFFAE

        LDA     curDrive
        JSR     LFFB4

        LDA     #$FF
        JSR     LFF96

        LDY     #$00
L0D08:
        JSR     LFFA5

        STA     L1DCE,Y
        INY
        CPY     #$20
        BCC     L0D08

        JSR     LFFAB

        LDA     curDrive
        JSR     LFFB1

        LDA     #$EF
        JSR     LFF93

        JSR     LFFAE

        JSR     DoneWithIO

        LDA     #$00
        STA     L1DCD
        CLC
        LDA     #$20
        ADC     L0D40
        STA     L0D40
        BCC     L0D3A

        INC     L0D41
L0D3A:
        CLV
        BVC     L0CD4

        EOR     L522D
L0D40:
        BRK
L0D41:
        .byte    $00

L0D42:
	L00A9 = $00a9
        JSR     L00A9

L0D43 = L0D42+1
        STA     STATUS
        LDA     curDrive
        JSR     LFFB1

        BIT     STATUS
        BMI     L0D69

        LDA     #$FF
        JSR     LFF93

        BIT     STATUS
        BMI     L0D69

        LDY     #$00
L0D5C:
        LDA     (r0L),Y
        JSR     LFFA8

        INY
        CPY     #$06
        BCC     L0D5C

        LDX     #$00
        RTS

L0D69:
        JSR     LFFAE

        LDX     #$0D
        RTS

L0D6F:
        LDA     #$00
        STA     NUMDRV
        LDY     #$01
L0D76:
        LDA     driveType,Y
        BEQ     L0D7E

        INC     NUMDRV
L0D7E:
        DEY
        BPL     L0D76

        RTS

L0D82:
        JSR     InitForIO

        LDA     #$00
        STA     ramExpSize
        LDA     #$02
        STA     L1DC6
        LDA     EXP_BASE
        AND     #$10
        BEQ     L0D9B

        LDA     #$08
        STA     L1DC6
L0D9B:
        LDA     EXP_BASE
        AND     #$E0
        BNE     L0DDC

        LDA     #$55
        STA     LDF02
        CMP     LDF02
        BNE     L0DDC

        LDA     #$AA
        STA     LDF02
        LDY     #$00
L0DB3:
        DEY
        BNE     L0DB3

        CMP     LDF02
        BNE     L0DDC

        LDA     #$01
        STA     ramExpSize
        LDA     #$00
        STA     r3L
L0DC4:
        JSR     L0DDF

        BCC     L0DD9

        LDA     ramExpSize
        CMP     L1DC6
        BEQ     L0DDC

        INC     ramExpSize
        INC     r3L
        CLV
        BVC     L0DC4

L0DD9:
        DEC     ramExpSize
L0DDC:
        JMP     DoneWithIO

L0DDF:
        LDA     #$1D
        STA     r0H
        LDA     #$BE
        STA     r0L
        LDA     #$00
        STA     r1L
        STA     r1H
        LDA     #$00
        STA     r2H
        LDA     #$08
        STA     r2L
        JSR     FetchRAM

        LDA     #$0E
        STA     r0H
        LDA     #$2A
        STA     r0L
        JSR     StashRAM

        LDA     #$1D
        STA     r0H
        LDA     #$B6
        STA     r0L
        JSR     FetchRAM

        LDA     #$1D
        STA     r0H
        LDA     #$BE
        STA     r0L
        JSR     StashRAM

        LDY     #$07
L0E1B:
        LDA     L0E2A,Y
        CMP     L1DB6,Y
        BNE     L0E28

        DEY
        BPL     L0E1B

        SEC
        RTS

L0E28:
        CLC
        RTS

L0E2A:
        .byte    "RAMCheck"

L0E32:
        LDA     sysRAMFlg
        AND     #$20
        BEQ     L0E45

        LDA     L1DC8
        JSR     L073D

        JSR     L0E46

        JSR     L0EF6

L0E45:
        RTS

L0E46:
        JSR     L0EEB

        LDA     #$84
        STA     r0H
        LDA     #$79
        STA     r1H
        LDA     #$05
        STA     r2H
        JSR     StashRAM

        BIT     sysRAMFlg
        BVS     L0E73

        JSR     L0EEB

        LDA     #$90
        STA     r0H
        LDA     #$83
        STA     r1H
        LDA     #$0D
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     StashRAM

L0E73:
        JSR     L0EEB

        LDA     #$80
        STA     r0L
        STA     r2L
        LDA     #$9D
        STA     r0H
        LDA     #$B9
        STA     r1H
        LDA     #$00
        STA     r3L
        LDA     #$02
        STA     r2H
        JSR     StashRAM

        JSR     L0EEB

        LDA     #$BF
        STA     r0H
        LDA     #$40
        STA     r0L
        LDA     #$BB
        STA     r1H
        LDA     #$80
        STA     r1L
        LDA     #$10
        STA     r2H
        LDA     #$C0
        STA     r2L
        JSR     StashRAM

        LDA     #$30
        STA     r4L
        LDA     #$D0
        STA     r5H
        LDA     #$00
        STA     r5L
        LDA     #$80
        STA     r0H
        LDA     #$00
        STA     r0L
        LDA     #$CC
        STA     r1H
        LDA     #$40
        STA     r1L
        LDA     #$01
        STA     r2H
        LDA     #$00
        STA     r2L
        LDA     #$00
        STA     r3L
L0ED5:
        LDY     #$00
L0ED7:
        LDA     (r5L),Y
        STA     OS_VARS,Y
        INY
        BNE     L0ED7

        JSR     StashRAM

        INC     r5H
        INC     r1H
        DEC     r4L
        BNE     L0ED5

        RTS

L0EEB:
        LDA     #$00
        STA     r0L
        STA     r1L
        STA     r2L
        STA     r3L
        RTS

L0EF6:
        JSR     L0EEB

        LDA     #$7E
        STA     r1H
        LDA     #$05
        STA     r2H
        LDA     #$0F
        STA     r0H
        LDA     #$0C
        STA     r0L
        JMP     StashRAM

        SEI
        CLD
        LDX     #$FF
        TXS
        LDA     #$30
        STA     CPU_DATA
        LDA     #$90
        STA     r0H
        LDA     #$00
        STA     r0L
        LDA     #$83
        STA     r1H
        LDA     #$00
        STA     r1L
        LDA     #$0D
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     L6216

        LDA     #$9D
        STA     r0H
        LDA     #$80
        STA     r0L
        LDA     #$B9
        STA     r1H
        LDA     #$00
        STA     r1L
        LDA     #$02
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     L6216

        LDA     #$BF
        STA     r0H
        LDA     #$40
        STA     r0L
        LDA     #$BB
        STA     r1H
        LDA     #$80
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$C0
        STA     r2L
        JSR     L6216

        LDA     #$C0
        STA     r0H
        LDA     #$80
        STA     r0L
        LDA     #$BC
        STA     r1H
        LDA     #$C0
        STA     r1L
        LDA     #$0F
        STA     r2H
        LDA     #$80
        STA     r2L
        JSR     L6216

        LDA     #$30
        STA     r4L
        LDA     #$D0
        STA     r5H
        LDA     #$00
        STA     r5L
        LDA     #$80
        STA     r0H
        LDA     #$00
        STA     r0L
        LDA     #$CC
        STA     r1H
        LDA     #$40
        STA     r1L
        LDA     #$01
        STA     r2H
        LDA     #$00
        STA     r2L
L0FA5:
        JSR     L6216

        LDY     #$00
L0FAA:
        LDA     OS_VARS,Y
        STA     (r5L),Y
        INY
        BNE     L0FAA

        INC     r5H
        INC     r1H
        DEC     r4L
        BNE     L0FA5

        JSR     i_FillRam

        .byte    $00,$05,$00,$84,$00

L0FC2:
        LDA     #$00
        STA     r0L
        LDA     #$A0
        STA     r0H
        LDX     #$7D
L0FCC:
        LDY     #$3F
L0FCE:
        LDA     #$55
        STA     (r0L),Y
        DEY
        LDA     #$AA
        STA     (r0L),Y
        DEY
        BPL     L0FCE

        LDA     r0L
        CLC
        ADC     #$40
        STA     r0L
        BCC     L0FE5

        INC     r0H
L0FE5:
        DEX
        BNE     L0FCC

        JSR     FirstInit

        LDA     #$FF
        STA     firstBoot
        JSR     END_MOUSE_128

        LDA     #$88
        STA     r0H
        LDA     #$C3
        STA     r0L
        LDA     #$7D
        STA     r1H
        LDA     #$C3
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$02
        STA     r2L
        JSR     L6216

        LDA     LC012
        STA     sysRAMFlg
        LDA     #$85
        STA     r0H
        LDA     #$16
        STA     r0L
        LDA     #$7A
        STA     r1H
        LDA     #$16
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$03
        STA     r2L
        LDA     #$00
        STA     r3L
        JSR     FetchRAM

        LDA     LDC08
        STA     LDC08
        LDA     #$84
        STA     r0H
        LDA     #$8E
        STA     r0L
        LDA     #$79
        STA     r1H
        LDA     #$8E
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$04
        STA     r2L
        JSR     FetchRAM

        LDA     #$88
        STA     r0H
        LDA     #$C7
        STA     r0L
        LDA     #$7D
        STA     r1H
        LDA     #$C7
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$04
        STA     r2L
        JSR     FetchRAM

        LDA     #$84
        STA     r0H
        LDA     #$65
        STA     r0L
        LDA     #$79
        STA     r1H
        LDA     #$65
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$11
        STA     r2L
        JSR     FetchRAM

        LDA     #$88
        STA     r0H
        LDA     #$CB
        STA     r0L
        LDA     #$7D
        STA     r1H
        LDA     #$CB
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$11
        STA     r2L
        JSR     FetchRAM

        LDA     #$84
        STA     r0H
        LDA     #$89
        STA     r0L
        LDA     #$79
        STA     r1H
        LDA     #$89
        STA     r1L
        LDA     #$00
        STA     r2H
        LDA     #$01
        STA     r2L
        JSR     FetchRAM

        JSR     InitForIO

        LDA     #$04
        STA     r0L
L10C7:
        LDY     #$00
        LDX     #$00
L10CB:
        DEY
        BNE     L10CB

        DEX
        BNE     L10CB

        DEC     r0L
        BNE     L10C7

        JSR     DoneWithIO

        LDA     curDrive
        PHA
        LDA     #$0B
        STA     curDrive
        STA     curDevice
        LDA     #$00
        STA     NUMDRV
        STA     curDevice
        LDA     #$08
        STA     interleave
        JSR     SetDevice

        LDA     #$08
        STA     L1DC7
L10F7:
        LDY     L1DC7
        LDA     _driveType,Y
        BEQ     L110F

        CPY     #$0A
        BCS     L1106

        INC     NUMDRV
L1106:
        LDA     L1DC7
        JSR     SetDevice

        JSR     NewDisk

L110F:
        INC     L1DC7
        LDA     L1DC7
        CMP     #$0C
        BCC     L10F7

        BEQ     L10F7

        PLA
        JSR     SetDevice

        JMP     EnterDeskTop

        LDY     #$91
        LDX     CPU_DATA
        LDA     #$35
        STA     CPU_DATA
        LDA     r0H
        STA     LDF03
        LDA     r0L
        STA     LDF02
        LDA     r1H
        STA     LDF05
        LDA     r1L
        STA     LDF04
        LDA     #$00
        STA     LDF06
        LDA     r2H
        STA     LDF08
        LDA     r2L
        STA     LDF07
        LDA     #$00
        STA     LDF09
        STA     LDF0A
        STY     LDF01
L1158:
        LDA     EXP_BASE
        AND     #$60
        BEQ     L1158

        STX     CPU_DATA
        RTS

