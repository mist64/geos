
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
DC08   = $DC08
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

       
	.byte    $02,$01

L0408
        .byte    $00,$00

L040A
        .byte    $00

L040B
        JSR     L047C

        LDA     firstBoot
        CMP     #$FF
        BNE     L0418

        JMP     L04EC

L0418
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

L0436
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

L0462
        JSR     L0738

        JSR     PurgeTurbo

        JSR     L0738

        LDA     #$01
        STA     NUMDRV
L0470
        JSR     i_MoveData

        .word    $1DFC,$5000,$0400

L0479
        JMP     EnterDeskTop

L047C
        BIT     LC013
        BMI     L048E

        LDA     LC00F
        CMP     #$14
        BCS     L048E

        JSR     L04CC

        JSR     L048F

L048E
        RTS

L048F
        LDA     #$C3
        STA     r0H
        LDA     #$10
        STA     r0L
        LDY     #$00
        STY     r1L
        JSR     L04A2

        LDA     #$05
        STA     r1L
L04A2
        LDX     r1L
L04A4
        LDA     (r0L),Y
        CMP     L04C2,X
        BEQ     L04B3

        CPX     r1L
        BNE     L04A2

        INY
        BNE     L04A2

        RTS

L04B3
        INY
        BNE     L04B7

        RTS

L04B7
        INX
        LDA     L04C2,X
        BNE     L04A4

        LDA     #$34
        STA     (r0L),Y
        RTS

L04C2
        .byte    $AD,$5C,$81,$C9,$00

        .byte    " V1.",$00

L04CC
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
L04EB
        RTS

L04EC
        JSR     L0522

        TXA
        BNE     L050E

        LDA     #$01
        JSR     PointRecord

        LDA     #$11
        STA     r7H
        LDA     #$62
        STA     r7L
        LDA     #$FF
        STA     r2L
        STA     r2H
        JSR     ReadRecord

        TXA
        BNE     L050E

        JMP     L1205

L050E
        JMP     EnterDeskTop

        .byte    "Configure   V2.0",$00

L0522
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
L0557
        RTS

L0558
        JSR     ExitTurbo

        LDA     ramExpSize
        BEQ     L0563

        LDA     L040A
L0563
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
L057B
        STA     L1DCA
        LDA     curDrive
        EOR     #$01
        JSR     SetDevice

        JSR     L0C33

        CMP     #$FF
        BNE     L058F

        LDA     #$00
L058F
        STA     L1DCB
        LDA     ramExpSize
        BEQ     L05A3

        LDA     #$0A
        JSR     SetDevice

        JSR     L0C33

        CMP     #$FF
        BNE     L05A5

L05A3
        LDA     #$00
L05A5
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
L05C1
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

L05E7
        LDA     L1DCC
        BEQ     L05F7

        LDA     #$0A
        JSR     L073D

        LDA     L1DCC
        JSR     L0768

L05F7
        RTS

L05F8
        LDA     ramExpSize
        BEQ     L0615

        LDA     #$08
        STA     L1DEF
        LDA     L1DCA
        STA     L1DF3
L0608
        JSR     L0986

        INC     L1DEF
        LDA     L1DEF
        CMP     #$0C
        BNE     L0608

L0615
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

L0649
        RTS

L064A
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
L0671
        RTS

L0672
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

L06AA
        TXA
        RTS

L06AC
        .byte    $00

L06AD
        .byte    $00,$00,$00,$00

L06B1
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

L06E6
        STA     L1DCC
        RTS

L06EA
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
L0703
        STA     r0H
        LDA     r2H
        BPL     L0710

        LDA     r0H
        STA     r0L
        LDA     r2H
        RTS

L0710
        AND     #$0F
        CMP     #$01
        BNE     L0720

        LDA     r2L
        CMP     #$02
        BNE     L0720

        LDA     #$01
        STA     r2L
L0720
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

L0735
        LDA     r2L
        RTS

L0738
        LDA     curDrive
        EOR     #$01
L073D
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

L075A
        PLA
        STA     L1DF3
L075E
        LDY     curDrive
        LDA     _driveType,Y
        STA     curType
L0767
        RTS

L0768
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

L077E
        CMP     #$02
        BNE     L0785

        JMP     L07D7

L0785
        CMP     #$03
        BNE     L078C

        JMP     L07E7

L078C
        CMP     #$41
        BNE     L0796

        JSR     L07AF

        JMP     L07F7

L0796
        CMP     #$43
        BNE     L07A0

        JSR     L07E7

        JMP     L0818

L07A0
        CMP     #$81
        BNE     L07A7

        JMP     L0839

L07A7
        CMP     #$82
        BNE     L07AE

        JMP     L086B

L07AE
        RTS

L07AF
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
        DEC     L15A6
        RTS

L07CE
        LDA     #$01
        STA     L1DF3
        JMP     L089D

L07D6
        RTS

L07D7
        LDA     L1DF0
        CMP     #$02
        BEQ     L07E6

        LDA     #$02
        STA     L1DF3
        JMP     L089D

L07E6
        RTS

L07E7
        LDA     L1DF0
        CMP     #$03
        BEQ     L07F6

        LDA     #$03
        STA     L1DF3
        JMP     L089D

L07F6
        RTS

L07F7
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
L0817
        RTS

L0818
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
L0838
        RTS

L0839
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
L086A
        RTS

L086B
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
L089C
        RTS

L089D
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

L08BC
        JSR     L1AD1

        LDA     L1DEF
        JSR     L073D

L08C5
        DEC     L15A6
        LDY     L1DEF
        LDA     _driveType,Y
        STA     L03FE,Y
        LDA     #$00
        STA     _ramBase,Y
        RTS

L08D7
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

L08F0
        LDY     L1DEF
        LDA     _ramBase,Y
        LDX     #$00
        RTS

L08F9
        LDY     ramExpSize
L08FC
        DEY
        BMI     L0908

        LDA     L1DF4,Y
        BNE     L08FC

        TYA
        LDX     #$00
        RTS

L0908
        LDX     #$FF
        RTS

L090B
        STA     r0L
        LDY     #$00
L090F
        LDA     r0L
        STA     r0H
L0913
        STY     r1L
        CPY     ramExpSize
        BCS     L093A

        LDA     L1DF4,Y
        INY
        CMP     #$00
        BNE     L0913

L0922
        DEC     r0H
        BEQ     L0935

        CPY     ramExpSize
        BCS     L093A

        LDA     L1DF4,Y
        INY
        CMP     #$00
        BNE     L090F

        BEQ     L0922

L0935
        LDA     r1L
        LDX     #$00
        RTS

L093A
        LDX     #$FF
        RTS

L093D
        LDY     #$07
        LDA     #$00
L0941
        STA     L1DF4,Y
        DEY
        BPL     L0941

        LDA     #$FF
        STA     L1DF4
        LDA     #$08
        STA     r0L
L0950
        LDY     r0L
        LDA     _driveType,Y
        JSR     L0973

        TAX
        BEQ     L096A

        LDY     r0L
        LDA     _ramBase,Y
        TAY
L0961
        LDA     #$FF
        STA     L1DF4,Y
        INY
        DEX
        BNE     L0961

L096A
        INC     r0L
        LDA     r0L
        CMP     #$0C
        BCC     L0950

        RTS

L0973
        STA     r0H
        AND     #$C0
        BEQ     L0981

        LDA     r0H
        AND     #$0F
        TAY
        LDA     L0982,Y
L0981
        RTS

L0982
        .byte    $03,$03

        .byte    $06,$01

L0986
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

L09AE
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

L09C9
        LDY     L848F
        BEQ     L09D6

        LDA     #$09
        JSR     L09FB

        JSR     StashRAM

L09D6
        LDY     L8490
        BEQ     L09E3

        LDA     #$0A
        JSR     L09FB

        JSR     StashRAM

L09E3
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

L09FB
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

L0A22
        .byte    $80,$00,$80,$00

L0A26
        .byte    $3C,$4A,$57,$65

        .byte    $00,$80,$00,$80,$83,$90,$9E,$AB

L0A32
        TYA
        BPL     L0A39

        LDY     #$03
        BNE     L0A3D

L0A39
        AND     #$0F
        TAY
        DEY
L0A3D
        RTS

L0A3E
        LDY     #$00
        TYA
L0A41
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
L0A6B
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
L0A84
        STA     dir2Head,Y
        INY
        BNE     L0A84

        LDY     #$69
L0A8C
        DEY
        LDA     L0BCA,Y
        STA     dir2Head,Y
        TYA
        BNE     L0A8C

L0A96
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

L0AC0
        LDY     #$00
        TYA
L0AC3
        STA     OS_VARS,Y
        DEY
        BNE     L0AC3

        RTS

L0ACA
        .byte    $12,$01,$41

L0ACD
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

L0B60
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

L0BCA
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

L0C33
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

L0C51
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

L0C6C
        LDA     #$00
L0C6E
        RTS

L0C6F
        JSR     L0CC4

        LDA     #$01
        STA     r2H
        LDA     #$00
        STA     r2L
L0C7A
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

L0CB3
        LDA     r2L
        BNE     L0CB9

        DEC     r2H
L0CB9
        DEC     r2L
        LDA     r2L
        ORA     r2H
        BNE     L0C7A

        LDX     #$00
L0CC3
        RTS

L0CC4
        LDA     r0H
        STA     L0D41
        LDA     r0L
        STA     L0D40
        LDA     #$20
        STA     L1DCD
        RTS

L0CD4
        LDY     L1DCD
        CPY     #$20
        BCS     L0CE4

        LDA     L1DCE,Y
        INC     L1DCD
        LDX     #$00
        RTS

L0CE4
        JSR     InitForIO

        LDA     #$0D
        STA     r0H
        LDA     #$3D
        STA     r0L
        JSR     L0D43

        BEQ     L0CF8

        JSR     DoneWithIO

        RTS

L0CF8
        JSR     LFFAE

        LDA     curDrive
        JSR     LFFB4

        LDA     #$FF
        JSR     LFF96

        LDY     #$00
L0D08
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
L0D3A
        CLV
        BVC     L0CD4

        EOR     L522D
L0D40
        BRK
L0D41
        .byte    $00

L0D42
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
L0D5C
        LDA     (r0L),Y
        JSR     LFFA8

        INY
        CPY     #$06
        BCC     L0D5C

        LDX     #$00
        RTS

L0D69
        JSR     LFFAE

        LDX     #$0D
        RTS

L0D6F
        LDA     #$00
        STA     NUMDRV
        LDY     #$01
L0D76
        LDA     driveType,Y
        BEQ     L0D7E

        INC     NUMDRV
L0D7E
        DEY
        BPL     L0D76

        RTS

L0D82
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
L0D9B
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
L0DB3
        DEY
        BNE     L0DB3

        CMP     LDF02
        BNE     L0DDC

        LDA     #$01
        STA     ramExpSize
        LDA     #$00
        STA     r3L
L0DC4
        JSR     L0DDF

        BCC     L0DD9

        LDA     ramExpSize
        CMP     L1DC6
        BEQ     L0DDC

        INC     ramExpSize
        INC     r3L
        CLV
        BVC     L0DC4

L0DD9
        DEC     ramExpSize
L0DDC
        JMP     DoneWithIO

L0DDF
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
L0E1B
        LDA     L0E2A,Y
        CMP     L1DB6,Y
        BNE     L0E28

        DEY
        BPL     L0E1B

        SEC
        RTS

L0E28
        CLC
        RTS

L0E2A
        .byte    "RAMCheck"

L0E32
        LDA     sysRAMFlg
        AND     #$20
        BEQ     L0E45

        LDA     L1DC8
        JSR     L073D

        JSR     L0E46

        JSR     L0EF6

L0E45
        RTS

L0E46
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

L0E73
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
L0ED5
        LDY     #$00
L0ED7
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

L0EEB
        LDA     #$00
        STA     r0L
        STA     r1L
        STA     r2L
        STA     r3L
        RTS

L0EF6
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
L0FA5
        JSR     L6216

        LDY     #$00
L0FAA
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

L0FC2
        LDA     #$00
        STA     r0L
        LDA     #$A0
        STA     r0H
        LDX     #$7D
L0FCC
        LDY     #$3F
L0FCE
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
L0FE5
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
L10C7
        LDY     #$00
        LDX     #$00
L10CB
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
L10F7
        LDY     L1DC7
        LDA     _driveType,Y
        BEQ     L110F

        CPY     #$0A
        BCS     L1106

        INC     NUMDRV
L1106
        LDA     L1DC7
        JSR     SetDevice

        JSR     NewDisk

L110F
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
L1158
        LDA     EXP_BASE
        AND     #$60
        BEQ     L1158

        STX     CPU_DATA
        RTS

; 0406 02 01 00 00 00 20 7C 04 AD C5 88 C9 FF D0 03 4C ----- |--------L DDDDDOOOOOOOOOOO
; 0416 EC 04 2C 13 C0 30 5C AD 89 84 8D C8 1D A8 B9 86 --,--0\--------- OOOOOOOOOOOOOOOO
; 0426 84 8D C9 1D 20 82 0D 20 B7 C1 00 50 FC 1D 00 04 ---- -- ---P---- OOOOOOOOOODDDDDD
; 0436 A9 01 8D 8D 84 20 58 05 AD C8 1D 20 3D 07 20 32 ----- X---- =- 2 OOOOOOOOOOOOOOOO
; 0446 0E 20 6F 0D AD C3 88 D0 21 AD 8D 84 C9 02 90 1A - o-----!------- OOOOOOOOOOOOOOOO
; 0456 AD 8E 84 CD 8F 84 D0 04 C9 03 D0 0E 20 38 07 20 ------------ 8-  OOOOOOOOOOOOOOOO
; 0466 35 C2 20 38 07 A9 01 8D 8D 84 20 B7 C1 FC 1D 00 5- 8------ ----- OOOOOOOOOOOOODDD
; 0476 50 00 04 4C 2C C2 2C 13 C0 30 0D AD 0F C0 C9 14 P--L,-,--0------ DDDOOOOOOOOOOOOO
; 0486 B0 06 20 CC 04 20 8F 04 60 A9 C3 85 03 A9 10 85 -- -- --`------- OOOOOOOOOOOOOOOO
; 0496 02 A0 00 84 04 20 A2 04 A9 05 85 04 A6 04 B1 02 ----- ---------- OOOOOOOOOOOOOOOO
; 04A6 DD C2 04 F0 08 E4 04 D0 F3 C8 D0 F0 60 C8 D0 01 ------------`--- OOOOOOOOOOOOOOOO
; 04B6 60 E8 BD C2 04 D0 E7 A9 34 91 02 60 AD 5C 81 C9 `-------4--`-\-- OOOOOOOOOOOODDDD
; 04C6 00 20 56 31 2E 00 AD 0F C0 C9 13 D0 18 AD B2 C2 - V1.----------- DDDDDDOOOOOOOOOO
; 04D6 85 03 AD B1 C2 85 02 A0 00 B1 02 C9 EA F0 06 A0 ---------------- OOOOOOOOOOOOOOOO
; 04E6 03 A9 3D 91 02 60 20 22 05 8A D0 1C A9 01 20 80 --=--` "------ - OOOOOOOOOOOOOOOO
; 04F6 C2 A9 11 85 11 A9 62 85 10 A9 FF 85 06 85 07 20 ------b--------  OOOOOOOOOOOOOOOO
; 0506 8C C2 8A D0 03 4C 05 12 4C 2C C2 43 6F 6E 66 69 -----L--L,-Confi OOOOOOOOOOODDDDD
; 0516 67 75 72 65 20 20 20 56 32 2E 30 00 A2 00 AD AC gure   V2.0----- DDDDDDDDDDDDOOOO
; 0526 06 D0 2E A9 1D 85 0F A9 A5 85 0E A9 0E 85 10 A9 --.------------- OOOOOOOOOOOOOOOO
; 0536 01 85 11 A9 05 85 17 A9 11 85 16 20 3B C2 8A D0 ----------- ;--- OOOOOOOOOOOOOOOO
; 0546 10 A9 1D 85 03 A9 A5 85 02 20 74 C2 A9 FF 8D AC --------- t----- OOOOOOOOOOOOOOOO
; 0556 06 60 20 32 C2 AD C3 88 F0 03 AD 0A 04 29 A0 8D -` 2---------)-- OOOOOOOOOOOOOOOO
; 0566 C4 88 8D 12 C0 AD C9 1D C9 02 B0 09 20 33 0C C9 ------------ 3-- OOOOOOOOOOOOOOOO
; 0576 FF D0 02 A9 01 8D CA 1D AD 89 84 49 01 20 B0 C2 -----------I- -- OOOOOOOOOOOOOOOO
; 0586 20 33 0C C9 FF D0 02 A9 00 8D CB 1D AD C3 88 F0  3-------------- OOOOOOOOOOOOOOOO
; 0596 0C A9 0A 20 B0 C2 20 33 0C C9 FF D0 02 A9 00 8D --- -- 3-------- OOOOOOOOOOOOOOOO
; 05A6 CC 1D AD C8 1D 20 B0 C2 20 B1 06 20 4A 06 8A D0 ----- -- -- J--- OOOOOOOOOOOOOOOO
; 05B6 40 20 35 C2 A0 03 A9 00 8D 8D 84 99 8E 84 99 92 @ 5------------- OOOOOOOOOOOOOOOO
; 05C6 84 99 BF 88 99 C7 88 88 10 F1 20 F8 05 AD CA 1D ---------- ----- OOOOOOOOOOOOOOOO
; 05D6 20 68 07 AD CB 1D F0 09 20 38 07 AD CB 1D 20 68  h------ 8---- h OOOOOOOOOOOOOOOO
; 05E6 07 AD CC 1D F0 0B A9 0A 20 3D 07 AD CC 1D 20 68 -------- =---- h OOOOOOOOOOOOOOOO
; 05F6 07 60 AD C3 88 F0 18 A9 08 8D EF 1D AD CA 1D 8D -`-------------- OOOOOOOOOOOOOOOO
; 0606 F3 1D 20 86 09 EE EF 1D AD EF 1D C9 0C D0 F3 60 -- ------------` OOOOOOOOOOOOOOOO
; 0616 AC 89 84 B9 86 84 F0 2B A8 20 32 0A B9 AD 06 D0 -------+- 2----- OOOOOOOOOOOOOOOO
; 0626 22 A9 FF 99 AD 06 B9 22 0A 85 04 B9 26 0A 85 05 "------"----&--- OOOOOOOOOOOOOOOO
; 0636 A9 90 85 03 A9 00 85 02 A9 0D 85 07 A9 80 85 06 ---------------- OOOOOOOOOOOOOOOO
; 0646 20 7E C1 60 AD CA 1D 20 72 06 D0 1F AD CB 1D 20  ~-`--- r------  OOOOOOOOOOOOOOOO
; 0656 72 06 D0 17 AD CC 1D 20 72 06 D0 0F A2 00 AD AC r------ r------- OOOOOOOOOOOOOOOO
; 0666 06 F0 08 20 77 C2 A9 00 8D AC 06 60 A2 00 A8 F0 --- w------`---- OOOOOOOOOOOOOOOO
; 0676 33 20 32 0A B9 AD 06 D0 2B 98 48 20 22 05 68 A8 3 2-----+-H "-h- OOOOOOOOOOOOOOOO
; 0686 8A D0 21 A9 FF 99 AD 06 B9 22 0A 85 10 B9 26 0A --!------"----&- OOOOOOOOOOOOOOOO
; 0696 85 11 98 18 69 02 20 80 C2 A9 0D 85 07 A9 80 85 ----i- --------- OOOOOOOOOOOOOOOO
; 06A6 06 20 8C C2 8A 60 00 00 00 00 00 A9 01 85 02 AD - ---`---------- OOOOOODDDDDOOOOO
; 06B6 C8 1D 49 01 A8 B9 FE 03 AE CB 1D 20 EA 06 8D CB --I-------- ---- OOOOOOOOOOOOOOOO
; 06C6 1D AC C8 1D B9 FE 03 29 7F AE CA 1D 20 EA 06 8D -------)---- --- OOOOOOOOOOOOOOOO
; 06D6 CA 1D AD C3 88 F0 09 AD 08 04 AE CC 1D 20 EA 06 ------------- -- OOOOOOOOOOOOOOOO
; 06E6 8D CC 1D 60 86 06 85 07 20 73 09 18 65 02 CD C3 ---`---- s--e--- OOOOOOOOOOOOOOOO
; 06F6 88 90 0A F0 08 A5 07 29 3F 85 07 A5 02 85 03 A5 -------)?------- OOOOOOOOOOOOOOOO
; 0706 07 10 07 A5 03 85 02 A5 07 60 29 0F C9 01 D0 0A ---------`)----- OOOOOOOOOOOOOOOO
; 0716 A5 06 C9 02 D0 04 A9 01 85 06 A5 07 29 40 F0 0F ------------)@-- OOOOOOOOOOOOOOOO
; 0726 A5 07 29 0F C5 06 D0 07 A5 03 85 02 A5 07 60 A5 --)-----------`- OOOOOOOOOOOOOOOO
; 0736 06 60 AD 89 84 49 01 20 B0 C2 8A D0 24 AD C3 88 -`---I- ----$--- OOOOOOOOOOOOOOOO
; 0746 D0 16 AD F3 1D 48 AC 89 84 B9 86 84 F0 06 8D F3 -----H---------- OOOOOOOOOOOOOOOO
; 0756 1D 20 86 09 68 8D F3 1D AC 89 84 B9 86 84 8D C6 - --h----------- OOOOOOOOOOOOOOOO
; 0766 88 60 48 A9 00 8D F0 1D AD 89 84 8D EF 1D 68 F0 -`H-----------h- OOOOOOOOOOOOOOOO
; 0776 37 C9 01 D0 03 4C AF 07 C9 02 D0 03 4C D7 07 C9 7----L------L--- OOOOOOOOOOOOOOOO
; 0786 03 D0 03 4C E7 07 C9 41 D0 06 20 AF 07 4C F7 07 ---L---A-- --L-- OOOOOOOOOOOOOOOO
; 0796 C9 43 D0 06 20 E7 07 4C 18 08 C9 81 D0 03 4C 39 -C-- --L------L9 OOOOOOOOOOOOOOOO
; 07A6 08 C9 82 D0 03 4C 6B 08 60 AD F0 1D C9 01 F0 20 -----Lk-`------  OOOOOOOOOOOOOOOO
; 07B6 C9 41 D0 14 AC EF 1D A9 01 99 86 84 99 FE 03 A9 -A-------------- OOOOOOOOOOOOOOOO
; 07C6 00 99 BF 88 CE A6 15 60 A9 01 8D F3 1D 4C 9D 08 -------`-----L-- OOOOOOOOOOOOOOOO
; 07D6 60 AD F0 1D C9 02 F0 08 A9 02 8D F3 1D 4C 9D 08 `------------L-- OOOOOOOOOOOOOOOO
; 07E6 60 AD F0 1D C9 03 F0 08 A9 03 8D F3 1D 4C 9D 08 `------------L-- OOOOOOOOOOOOOOOO
; 07F6 60 AD F0 1D C9 41 F0 19 A9 41 20 D7 08 AC EF 1D `----A---A ----- OOOOOOOOOOOOOOOO
; 0806 99 BF 88 A9 41 99 86 84 99 FE 03 20 E1 C1 CE A6 ----A------ ---- OOOOOOOOOOOOOOOO
; 0816 15 60 AD F0 1D C9 43 F0 19 A9 43 20 D7 08 AC EF -`----C---C ---- OOOOOOOOOOOOOOOO
; 0826 1D 99 BF 88 A9 43 99 86 84 99 FE 03 20 E1 C1 CE -----C------ --- OOOOOOOOOOOOOOOO
; 0836 A6 15 60 AD F0 1D C9 81 F0 2A A9 81 8D F3 1D 20 --`------*-----  OOOOOOOOOOOOOOOO
; 0846 86 09 EE 8D 84 A9 81 20 D7 08 AC EF 1D 99 BF 88 ------- -------- OOOOOOOOOOOOOOOO
; 0856 A9 81 99 86 84 99 FE 03 AD EF 1D 20 3D 07 20 3E ----------- =- > OOOOOOOOOOOOOOOO
; 0866 0A CE A6 15 60 AD F0 1D C9 82 F0 2A A9 82 8D F3 ----`------*---- OOOOOOOOOOOOOOOO
; 0876 1D 20 86 09 EE 8D 84 A9 82 20 D7 08 AC EF 1D 99 - ------- ------ OOOOOOOOOOOOOOOO
; 0886 BF 88 A9 82 99 86 84 99 FE 03 AD EF 1D 20 3D 07 ------------- =- OOOOOOOOOOOOOOOO
; 0896 20 3E 0A CE A6 15 60 20 86 09 AD EF 1D 20 3D 07  >----` ----- =- OOOOOOOOOOOOOOOO
; 08A6 AD C5 88 C9 FF F0 0F AC EF 1D AD F3 1D 99 86 84 ---------------- OOOOOOOOOOOOOOOO
; 08B6 EE 8D 84 B8 50 09 20 D1 1A AD EF 1D 20 3D 07 CE ----P- ----- =-- OOOOOOOOOOOOOOOO
; 08C6 A6 15 AC EF 1D B9 86 84 99 FE 03 A9 00 99 BF 88 ---------------- OOOOOOOOOOOOOOOO
; 08D6 60 48 20 3D 09 68 85 02 AD F0 1D 29 C0 D0 0B A5 `H =-h-----)---- OOOOOOOOOOOOOOOO
; 08E6 02 20 73 09 C9 01 F0 0B D0 1B AC EF 1D B9 BF 88 - s------------- OOOOOOOOOOOOOOOO
; 08F6 A2 00 60 AC C3 88 88 30 09 B9 F4 1D D0 F8 98 A2 --`----0-------- OOOOOOOOOOOOOOOO
; 0906 00 60 A2 FF 60 85 02 A0 00 A5 02 85 03 84 04 CC -`--`----------- OOOOOOOOOOOOOOOO
; 0916 C3 88 B0 20 B9 F4 1D C8 C9 00 D0 F1 C6 03 F0 0F --- ------------ OOOOOOOOOOOOOOOO
; 0926 CC C3 88 B0 0F B9 F4 1D C8 C9 00 D0 DC F0 ED A5 ---------------- OOOOOOOOOOOOOOOO
; 0936 04 A2 00 60 A2 FF 60 A0 07 A9 00 99 F4 1D 88 10 ---`--`--------- OOOOOOOOOOOOOOOO
; 0946 FA A9 FF 8D F4 1D A9 08 85 02 A4 02 B9 86 84 20 ---------------  OOOOOOOOOOOOOOOO
; 0956 73 09 AA F0 0F A4 02 B9 BF 88 A8 A9 FF 99 F4 1D s--------------- OOOOOOOOOOOOOOOO
; 0966 C8 CA D0 F7 E6 02 A5 02 C9 0C 90 DE 60 85 03 29 ------------`--) OOOOOOOOOOOOOOOO
; 0976 C0 F0 08 A5 03 29 0F A8 B9 82 09 60 03 03 06 01 -----)-----`---- OOOOOOOOOOOODDDD
; 0986 AD C3 88 D0 23 AD C4 88 29 BF 8D C4 88 8D 12 C0 ----#---)------- OOOOOOOOOOOOOOOO
; 0996 8D 0A 04 AC F3 1D AD EF 1D 20 FB 09 A9 90 85 05 --------- ------ OOOOOOOOOOOOOOOO
; 09A6 A9 00 85 04 20 7E C1 60 AD C4 88 09 40 8D C4 88 ---- ~-`----@--- OOOOOOOOOOOOOOOO
; 09B6 8D 12 C0 8D 0A 04 AC 8E 84 F0 08 A9 08 20 FB 09 ------------- -- OOOOOOOOOOOOOOOO
; 09C6 20 C8 C2 AC 8F 84 F0 08 A9 09 20 FB 09 20 C8 C2  --------- -- -- OOOOOOOOOOOOOOOO
; 09D6 AC 90 84 F0 08 A9 0A 20 FB 09 20 C8 C2 AC F3 1D ------- -- ----- OOOOOOOOOOOOOOOO
; 09E6 AD EF 1D 20 FB 09 20 C8 C2 A9 90 85 05 A9 00 85 --- -- --------- OOOOOOOOOOOOOOOO
; 09F6 04 20 7E C1 60 48 20 32 0A B9 22 0A 85 02 B9 26 - ~-`H 2--"----& OOOOOOOOOOOOOOOO
; 0A06 0A 85 03 68 A8 B9 22 0A 85 04 B9 26 0A 85 05 A9 ---h--"----&---- OOOOOOOOOOOOOOOO
; 0A16 0D 85 07 A9 80 85 06 A9 00 85 08 60 80 00 80 00 -----------`---- OOOOOOOOOOOODDDD
; 0A26 3C 4A 57 65 00 80 00 80 83 90 9E AB 98 10 04 A0 <JWe------------ DDDDDDDDDDDDOOOO
; 0A36 03 D0 04 29 0F A8 88 60 A0 00 98 99 00 82 C8 D0 ---)---`-------- OOOOOOOOOOOOOOOO
; 0A46 FA A9 34 8D 60 0B A9 00 8D CD 0A AC 89 84 B9 86 --4-`----------- OOOOOOOOOOOOOOOO
; 0A56 84 29 0F A0 BD C9 01 F0 0C A0 00 A9 37 8D 60 0B -)----------7-`- OOOOOOOOOOOOOOOO
; 0A66 A9 80 8D CD 0A 88 B9 CA 0A 99 00 82 98 D0 F6 AC ---------------- OOOOOOOOOOOOOOOO
; 0A76 89 84 B9 86 84 29 0F C9 01 F0 15 A0 00 98 99 00 -----)---------- OOOOOOOOOOOOOOOO
; 0A86 89 C8 D0 FA A0 69 88 B9 CA 0B 99 00 89 98 D0 F6 -----i---------- OOOOOOOOOOOOOOOO
; 0A96 20 4A C2 20 C0 0A A9 FF 8D 01 80 A9 80 85 0B A9  J- ------------ OOOOOOOOOOOOOOOO
; 0AA6 00 85 0A A9 12 85 04 A9 01 85 05 20 E7 C1 E6 04 ----------- ---- OOOOOOOOOOOOOOOO
; 0AB6 A9 08 85 05 20 E7 C1 A9 00 60 A0 00 98 99 00 80 ---- ----`------ OOOOOOOOOOOOOOOO
; 0AC6 88 D0 FA 60 12 01 41 00 15 FF FF 1F 15 FF FF 1F ---`--A--------- OOOODDDDDDDDDDDD
; 0AD6 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F ---------------- DDDDDDDDDDDDDDDD
; 0AE6 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F ---------------- DDDDDDDDDDDDDDDD
; 0AF6 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F ---------------- DDDDDDDDDDDDDDDD
; 0B06 15 FF FF 1F 15 FF FF 1F 15 FF FF 1F 11 FC FF 07 ---------------- DDDDDDDDDDDDDDDD
; 0B16 12 FF FE 07 13 FF FF 07 13 FF FF 07 13 FF FF 07 ---------------- DDDDDDDDDDDDDDDD
; 0B26 13 FF FF 07 13 FF FF 07 12 FF FF 03 12 FF FF 03 ---------------- DDDDDDDDDDDDDDDD
; 0B36 12 FF FF 03 12 FF FF 03 12 FF FF 03 12 FF FF 03 ---------------- DDDDDDDDDDDDDDDD
; 0B46 11 FF FF 01 11 FF FF 01 11 FF FF 01 11 FF FF 01 ---------------- DDDDDDDDDDDDDDDD
; 0B56 11 FF FF 01 52 41 4D 20 31 35 37 31 A0 A0 A0 A0 ----RAM 1571---- DDDDDDDDDDDDDDDD
; 0B66 A0 A0 A0 A0 A0 A0 52 44 A0 32 41 A0 A0 A0 A0 13 ------RD-2A----- DDDDDDDDDDDDDDDD
; 0B76 08 47 45 4F 53 20 66 6F 72 6D 61 74 20 56 31 2E -GEOS format V1. DDDDDDDDDDDDDDDD
; 0B86 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0--------------- DDDDDDDDDDDDDDDD
; 0B96 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ---------------- DDDDDDDDDDDDDDDD
; 0BA6 00 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 ---------------- DDDDDDDDDDDDDDDD
; 0BB6 15 15 00 13 13 13 13 13 13 12 12 12 12 12 12 11 ---------------- DDDDDDDDDDDDDDDD
; 0BC6 11 11 11 11 FF FF 1F FF FF 1F FF FF 1F FF FF 1F ---------------- DDDDDDDDDDDDDDDD
; 0BD6 FF FF 1F FF FF 1F FF FF 1F FF FF 1F FF FF 1F FF ---------------- DDDDDDDDDDDDDDDD
; 0BE6 FF 1F FF FF 1F FF FF 1F FF FF 1F FF FF 1F FF FF ---------------- DDDDDDDDDDDDDDDD
; 0BF6 1F FF FF 1F FF FF 1F 00 00 00 FF FF 07 FF FF 07 ---------------- DDDDDDDDDDDDDDDD
; 0C06 FF FF 07 FF FF 07 FF FF 07 FF FF 07 FF FF 03 FF ---------------- DDDDDDDDDDDDDDDD
; 0C16 FF 03 FF FF 03 FF FF 03 FF FF 03 FF FF 03 FF FF ---------------- DDDDDDDDDDDDDDDD
; 0C26 01 FF FF 01 FF FF 01 FF FF 01 FF FF 01 A9 E5 85 ---------------- DDDDDDDDDDDDDOOO
; 0C36 03 A9 80 85 02 20 6F 0C E0 00 D0 0F C9 00 D0 0B ----- o--------- OOOOOOOOOOOOOOOO
; 0C46 A9 A6 85 03 A9 C0 85 02 20 6F 0C E0 00 D0 17 AA -------- o------ OOOOOOOOOOOOOOOO
; 0C56 A9 01 E0 41 F0 12 A9 02 E0 71 F0 0C A9 03 E0 81 ---A-----q------ OOOOOOOOOOOOOOOO
; 0C66 F0 06 A9 FF D0 02 A9 00 60 20 C4 0C A9 01 85 07 --------` ------ OOOOOOOOOOOOOOOO
; 0C76 A9 00 85 06 20 D4 0C E0 00 D0 42 C9 31 D0 2E 20 ---- -----B-1-.  OOOOOOOOOOOOOOOO
; 0C86 D4 0C C9 35 D0 27 20 D4 0C 85 04 29 70 C9 30 D0 ---5-' ----)p-0- OOOOOOOOOOOOOOOO
; 0C96 1C A5 04 0A 0A 0A 0A 85 04 20 D4 0C 85 05 29 70 --------- ----)p OOOOOOOOOOOOOOOO
; 0CA6 C9 30 D0 09 A5 05 29 0F 05 04 A2 00 60 A5 06 D0 -0----)-----`--- OOOOOOOOOOOOOOOO
; 0CB6 02 C6 07 C6 06 A5 06 05 07 D0 B9 A2 00 60 A5 03 -------------`-- OOOOOOOOOOOOOOOO
; 0CC6 8D 41 0D A5 02 8D 40 0D A9 20 8D CD 1D 60 AC CD -A----@-- ---`-- OOOOOOOOOOOOOOOO
; 0CD6 1D C0 20 B0 09 B9 CE 1D EE CD 1D A2 00 60 20 5C -- ----------` \ OOOOOOOOOOOOOOOO
; 0CE6 C2 A9 0D 85 03 A9 3D 85 02 20 43 0D F0 04 20 5F ------=-- C--- _ OOOOOOOOOOOOOOOO
; 0CF6 C2 60 20 AE FF AD 89 84 20 B4 FF A9 FF 20 96 FF -` ----- ---- -- OOOOOOOOOOOOOOOO
; 0D06 A0 00 20 A5 FF 99 CE 1D C8 C0 20 90 F5 20 AB FF -- ------- -- -- OOOOOOOOOOOOOOOO
; 0D16 AD 89 84 20 B1 FF A9 EF 20 93 FF 20 AE FF 20 5F --- ---- -- -- _ OOOOOOOOOOOOOOOO
; 0D26 C2 A9 00 8D CD 1D 18 A9 20 6D 40 0D 8D 40 0D 90 -------- m@--@-- OOOOOOOOOOOOOOOO
; 0D36 03 EE 41 0D B8 50 97 4D 2D 52 00 00 20 A9 00 85 --A--P-M-R-- --- OOOOOOOOOOODOOOO
; 0D46 90 AD 89 84 20 B1 FF 24 90 30 18 A9 FF 20 93 FF ---- --$-0--- -- OOOOOOOOOOOOOOOO
; 0D56 24 90 30 0F A0 00 B1 02 20 A8 FF C8 C0 06 90 F6 $-0----- ------- OOOOOOOOOOOOOOOO
; 0D66 A2 00 60 20 AE FF A2 0D 60 A9 00 8D 8D 84 A0 01 --` ----`------- OOOOOOOOOOOOOOOO
; 0D76 B9 8E 84 F0 03 EE 8D 84 88 10 F5 60 20 5C C2 A9 -----------` \-- OOOOOOOOOOOOOOOO
; 0D86 00 8D C3 88 A9 02 8D C6 1D AD 00 DF 29 10 F0 05 ------------)--- OOOOOOOOOOOOOOOO
; 0D96 A9 08 8D C6 1D AD 00 DF 29 E0 D0 3A A9 55 8D 02 --------)--:-U-- OOOOOOOOOOOOOOOO
; 0DA6 DF CD 02 DF D0 30 A9 AA 8D 02 DF A0 00 88 D0 FD -----0---------- OOOOOOOOOOOOOOOO
; 0DB6 CD 02 DF D0 21 A9 01 8D C3 88 A9 00 85 08 20 DF ----!--------- - OOOOOOOOOOOOOOOO
; 0DC6 0D 90 10 AD C3 88 CD C6 1D F0 0B EE C3 88 E6 08 ---------------- OOOOOOOOOOOOOOOO
; 0DD6 B8 50 EB CE C3 88 4C 5F C2 A9 1D 85 03 A9 BE 85 -P----L_-------- OOOOOOOOOOOOOOOO
; 0DE6 02 A9 00 85 04 85 05 A9 00 85 07 A9 08 85 06 20 ---------------  OOOOOOOOOOOOOOOO
; 0DF6 CB C2 A9 0E 85 03 A9 2A 85 02 20 C8 C2 A9 1D 85 -------*-- ----- OOOOOOOOOOOOOOOO
; 0E06 03 A9 B6 85 02 20 CB C2 A9 1D 85 03 A9 BE 85 02 ----- ---------- OOOOOOOOOOOOOOOO
; 0E16 20 C8 C2 A0 07 B9 2A 0E D9 B6 1D D0 05 88 10 F5  -----*--------- OOOOOOOOOOOOOOOO
; 0E26 38 60 18 60 52 41 4D 43 68 65 63 6B AD C4 88 29 8`-`RAMCheck---) OOOODDDDDDDDOOOO
; 0E36 20 F0 0C AD C8 1D 20 3D 07 20 46 0E 20 F6 0E 60  ----- =- F- --` OOOOOOOOOOOOOOOO
; 0E46 20 EB 0E A9 84 85 03 A9 79 85 05 A9 05 85 07 20  -------y------  OOOOOOOOOOOOOOOO
; 0E56 C8 C2 2C C4 88 70 16 20 EB 0E A9 90 85 03 A9 83 --,--p- -------- OOOOOOOOOOOOOOOO
; 0E66 85 05 A9 0D 85 07 A9 80 85 06 20 C8 C2 20 EB 0E ---------- -- -- OOOOOOOOOOOOOOOO
; 0E76 A9 80 85 02 85 06 A9 9D 85 03 A9 B9 85 05 A9 00 ---------------- OOOOOOOOOOOOOOOO
; 0E86 85 08 A9 02 85 07 20 C8 C2 20 EB 0E A9 BF 85 03 ------ -- ------ OOOOOOOOOOOOOOOO
; 0E96 A9 40 85 02 A9 BB 85 05 A9 80 85 04 A9 10 85 07 -@-------------- OOOOOOOOOOOOOOOO
; 0EA6 A9 C0 85 06 20 C8 C2 A9 30 85 0A A9 D0 85 0D A9 ---- ---0------- OOOOOOOOOOOOOOOO
; 0EB6 00 85 0C A9 80 85 03 A9 00 85 02 A9 CC 85 05 A9 ---------------- OOOOOOOOOOOOOOOO
; 0EC6 40 85 04 A9 01 85 07 A9 00 85 06 A9 00 85 08 A0 @--------------- OOOOOOOOOOOOOOOO
; 0ED6 00 B1 0C 99 00 80 C8 D0 F8 20 C8 C2 E6 0D E6 05 --------- ------ OOOOOOOOOOOOOOOO
; 0EE6 C6 0A D0 EB 60 A9 00 85 02 85 04 85 06 85 08 60 ----`----------` OOOOOOOOOOOOOOOO
; 0EF6 20 EB 0E A9 7E 85 05 A9 05 85 07 A9 0F 85 03 A9  ---~----------- OOOOOOOOOOOOOOOO
; 0F06 0C 85 02 4C C8 C2 78 D8 A2 FF 9A A9 30 85 01 A9 ---L--x-----0--- OOOOOOOOOOOOOOOO
; 0F16 90 85 03 A9 00 85 02 A9 83 85 05 A9 00 85 04 A9 ---------------- OOOOOOOOOOOOOOOO
; 0F26 0D 85 07 A9 80 85 06 20 16 62 A9 9D 85 03 A9 80 ------- -b------ OOOOOOOOOOOOOOOO
; 0F36 85 02 A9 B9 85 05 A9 00 85 04 A9 02 85 07 A9 80 ---------------- OOOOOOOOOOOOOOOO
; 0F46 85 06 20 16 62 A9 BF 85 03 A9 40 85 02 A9 BB 85 -- -b-----@----- OOOOOOOOOOOOOOOO
; 0F56 05 A9 80 85 04 A9 00 85 07 A9 C0 85 06 20 16 62 ------------- -b OOOOOOOOOOOOOOOO
; 0F66 A9 C0 85 03 A9 80 85 02 A9 BC 85 05 A9 C0 85 04 ---------------- OOOOOOOOOOOOOOOO
; 0F76 A9 0F 85 07 A9 80 85 06 20 16 62 A9 30 85 0A A9 -------- -b-0--- OOOOOOOOOOOOOOOO
; 0F86 D0 85 0D A9 00 85 0C A9 80 85 03 A9 00 85 02 A9 ---------------- OOOOOOOOOOOOOOOO
; 0F96 CC 85 05 A9 40 85 04 A9 01 85 07 A9 00 85 06 20 ----@----------  OOOOOOOOOOOOOOOO
; 0FA6 16 62 A0 00 B9 00 80 91 0C C8 D0 F8 E6 0D E6 05 -b-------------- OOOOOOOOOOOOOOOO
; 0FB6 C6 0A D0 EB 20 B4 C1 00 05 00 84 00 A9 00 85 02 ---- ----------- OOOOOOODDDDDOOOO
; 0FC6 A9 A0 85 03 A2 7D A0 3F A9 55 91 02 88 A9 AA 91 -----}-?-U------ OOOOOOOOOOOOOOOO
; 0FD6 02 88 10 F4 A5 02 18 69 40 85 02 90 02 E6 03 CA -------i@------- OOOOOOOOOOOOOOOO
; 0FE6 D0 E4 20 71 C2 A9 FF 8D C5 88 20 80 FE A9 88 85 -- q------ ----- OOOOOOOOOOOOOOOO
; 0FF6 03 A9 C3 85 02 A9 7D 85 05 A9 C3 85 04 A9 00 85 ------}--------- OOOOOOOOOOOOOOOO
; 1006 07 A9 02 85 06 20 16 62 AD 12 C0 8D C4 88 A9 85 ----- -b-------- OOOOOOOOOOOOOOOO
; 1016 85 03 A9 16 85 02 A9 7A 85 05 A9 16 85 04 A9 00 -------z-------- OOOOOOOOOOOOOOOO
; 1026 85 07 A9 03 85 06 A9 00 85 08 20 CB C2 AD 08 DC ---------- ----- OOOOOOOOOOOOOOOO
; 1036 8D 08 DC A9 84 85 03 A9 8E 85 02 A9 79 85 05 A9 ------------y--- OOOOOOOOOOOOOOOO
; 1046 8E 85 04 A9 00 85 07 A9 04 85 06 20 CB C2 A9 88 ----------- ---- OOOOOOOOOOOOOOOO
; 1056 85 03 A9 C7 85 02 A9 7D 85 05 A9 C7 85 04 A9 00 -------}-------- OOOOOOOOOOOOOOOO
; 1066 85 07 A9 04 85 06 20 CB C2 A9 84 85 03 A9 65 85 ------ -------e- OOOOOOOOOOOOOOOO
; 1076 02 A9 79 85 05 A9 65 85 04 A9 00 85 07 A9 11 85 --y---e--------- OOOOOOOOOOOOOOOO
; 1086 06 20 CB C2 A9 88 85 03 A9 CB 85 02 A9 7D 85 05 - -----------}-- OOOOOOOOOOOOOOOO
; 1096 A9 CB 85 04 A9 00 85 07 A9 11 85 06 20 CB C2 A9 ------------ --- OOOOOOOOOOOOOOOO
; 10A6 84 85 03 A9 89 85 02 A9 79 85 05 A9 89 85 04 A9 --------y------- OOOOOOOOOOOOOOOO
; 10B6 00 85 07 A9 01 85 06 20 CB C2 20 5C C2 A9 04 85 ------- -- \---- OOOOOOOOOOOOOOOO
; 10C6 02 A0 00 A2 00 88 D0 FD CA D0 FA C6 02 D0 F2 20 ---------------  OOOOOOOOOOOOOOOO
; 10D6 5F C2 AD 89 84 48 A9 0B 8D 89 84 85 BA A9 00 8D _----H---------- OOOOOOOOOOOOOOOO
; 10E6 8D 84 85 BA A9 08 8D 8C 84 20 B0 C2 A9 08 8D C7 --------- ------ OOOOOOOOOOOOOOOO
; 10F6 1D AC C7 1D B9 86 84 F0 10 C0 0A B0 03 EE 8D 84 ---------------- OOOOOOOOOOOOOOOO
; 1106 AD C7 1D 20 B0 C2 20 E1 C1 EE C7 1D AD C7 1D C9 --- -- --------- OOOOOOOOOOOOOOOO
; 1116 0C 90 DE F0 DC 68 20 B0 C2 4C 2C C2 A0 91 A6 01 -----h --L,----- OOOOOOOOOOOOOOOO
; 1126 A9 35 85 01 A5 03 8D 03 DF A5 02 8D 02 DF A5 05 -5-------------- OOOOOOOOOOOOOOOO
; 1136 8D 05 DF A5 04 8D 04 DF A9 00 8D 06 DF A5 07 8D ---------------- OOOOOOOOOOOOOOOO
; 1146 08 DF A5 06 8D 07 DF A9 00 8D 09 DF 8D 0A DF 8C ---------------- OOOOOOOOOOOOOOOO
; 1156 01 DF AD 00 DF 29 60 F0 F9 86 01 60 00 00 00 00 -----)`----`---- OOOOOOOOOOOOUUUU

