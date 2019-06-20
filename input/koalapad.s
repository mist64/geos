; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Koala pad input driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "c64.inc"

.segment "koalapad"

MouseInit:
	jmp _MouseInit
SlowMouse:
	jmp _SlowMouse
UpdateMouse:
	jmp _UpdateMouse
SetMouse:

dat0:
	.byte 0
dat1:
	.byte 0
dat2:
	.byte 0
dat3:
	.byte 0
dat4:
	.byte 0
dat5:
	.byte 0
dat6:
	.byte 0
dat7:
	.byte 0

_MouseInit:
    LDA #$00
    STA $3B
    LDA #$08
    STA $3A
    STA $3C
    RTS

_SlowMouse:
    BIT $30
    BMI _UpdateMouse
    JMP $FF36

_08A2:
_UpdateMouse:
    LDA $01
    PHA
    LDA #$35
    STA $01
    LDA $DC02
    PHA
    LDA $DC03
    PHA
    LDA $DC00
    PHA
    JSR $FF37
    LDA $FE8E
    EOR #$FF
    STA $FE8E
    BNE _0927
    JSR $FF5B
    LDA $D419
    SEC
    SBC #$1F
    BCS _08CF
    LDA #$00
_08CF:
    STA $02
    LSR $02
    LSR $02
    LSR $02
    SEC
    SBC $02
    CMP #$0C
    BCC _0927
    CMP #$AB
    BEQ _08E4
    BCS _0927
_08E4:
    STA $02
    LDA $D41A
    CMP #$32
    BCC _0927
    CMP #$F9
    BEQ _08F3
    BCS _0927
_08F3:
    STA $03
    LDA $84B7
    BEQ _08FD
    JSR $FF6D
_08FD:
    LDA #$00
    STA $FE8F
    LDA $02
    LDX $FE8A
    LDY $FE8C
    JSR $FFB1
    STY $FE8C
    STX $FE8A   
    LDA $03
    LDX $FE8B
    LDY $FE8D
    JSR $FFB1
    STY $FE8D
    STX $FE8B
    JSR $FF85
_0927:
    PLA
    STA $DC00
    PLA
    STA $DC03
    PLA
    STA $DC02
    PLA
    STA $01
    RTS

_0937:
    LDA #$00
    STA $DC02
    STA $DC03
    LDA $DC01
    AND #$04
    CMP $FE89
    BEQ _095A
    STA $FE89
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    STA $8505
    LDA $39
    ORA #$20
    STA $39
_095A:
    RTS

_095b:
    LDA #$FF
    STA $DC02
    LDA #$40
    STA $DC00
    LDX #$6E
_0967:
    NOP
    NOP
    DEX
    BNE _0967
    RTS

_096d:
    LDA $3B
    STA $04
    LDA $3A
    ROR $04
    ROR A
    CLC
    ADC #$0C
    STA $FE8A
    LDA $3C
    CLC
    ADC #$32
    STA $FE8B
    RTS

_0985:
    BIT $FE8F
    BMI _09B0
    LDX #$00
    LDA $FE8A
    ASL A
    BCC _0993
    INX
_0993:
    STX $3B
    AND #$FE
    STA $3A
    SEC
    LDA $3A
    SBC #$18
    STA $3A
    LDA $3B
    SBC #$00
    STA $3B
    LDA $FE8B
    SEC
    SBC #$32
    AND #$FE
    STA $3C
_09B0:
    RTS

_09b1:
    STX $02
    TAX
    SEC
    SBC $02
    STA $02
    BPL _09C0
    EOR #$FF
    CLC
    ADC #$01
_09C0:
    CMP #$06
    BCC _09CD
    LDA #$80
    ORA $FE8F
    STA $FE8F
    RTS
_09CD:
    RTS

_09ce:
    TYA
    LDY $02
    BMI _09DB
    BEQ _09E7
    CMP #$00
    BPL _09E7
    BMI _09DF
    CMP #$00
_09DB:
    BMI _09E7
_09DF:
    LDA #$80
    ORA $FE8F
    STA $FE8F
_09E7:
    RTS

