; GEOS KERNAL
;
; Font drawing

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "jumptab.inc"

; conio.s
.import GetChWdth1

; bitmask.s
.import BitMaskPow2
.import BitMaskLeadingSet
.import BitMaskLeadingClear

.global _GetRealSize
.global Font_10

.segment "fonts1"
ID100:
	.byte $b1, $30, $03, $1b, $d8, $c0, $0c, $8d, $80, $10, $02, $20, $01, $08, $40, $04
	.byte $00, $01, $03, $03, $06, $07, $07, $07, $0c, $0d, $0f, $0f, $0e, $0f, $0f, $0f
	.byte $18, $19, $1b, $1b, $1e, $1f, $1f, $1f, $1c, $1d, $1f, $1f, $1e, $1f, $1f, $1f
	.byte $30, $31, $33, $33, $36, $37, $37, $37, $3c, $3d, $3f, $3f, $3e, $3f, $3f, $3f
	.byte $38, $39, $3b, $3b, $3e, $3f, $3f, $3f, $3c, $3d, $3f, $3f, $3e, $3f, $3f, $3f
	.byte $60, $61, $63, $63, $66, $67, $67, $67, $6c, $6d, $6f, $6f, $6e, $6f, $6f, $6f
	.byte $78, $79, $7b, $7b, $7e, $7f, $7f, $7f, $7c, $7d, $7f, $7f, $7e, $7f, $7f, $7f
	.byte $70, $71, $73, $73, $76, $77, $77, $77, $7c, $7d, $7f, $7f, $7e, $7f, $7f, $7f
	.byte $78, $79, $7b, $7b, $7e, $7f, $7f, $7f, $7c, $7d, $7f, $7f, $7e, $7f, $7f, $7f
	.byte $c0, $c1, $c3, $c3, $c6, $c7, $c7, $c7, $cc, $cd, $cf, $cf, $ce, $cf, $cf, $cf
	.byte $d8, $d9, $db, $db, $de, $df, $df, $df, $dc, $dd, $df, $df, $de, $df, $df, $df
	.byte $f0, $f1, $f3, $f3, $f6, $f7, $f7, $f7, $fc, $fd, $ff, $ff, $fe, $ff, $ff, $ff
	.byte $f8, $f9, $fb, $fb, $fe, $ff, $ff, $ff, $fc, $fd, $ff, $ff, $fe, $ff, $ff, $ff
	.byte $e0, $e1, $e3, $e3, $e6, $e7, $e7, $e7, $ec, $ed, $ef, $ef, $ee, $ef, $ef, $ef
	.byte $f8, $f9, $fb, $fb, $fe, $ff, $ff, $ff, $fc, $fd, $ff, $ff, $fe, $ff, $ff, $ff
	.byte $f0, $f1, $f3, $f3, $f6, $f7, $f7, $f7, $fc, $fd, $ff, $ff, $fe, $ff, $ff, $ff
	.byte $f8, $f9, $fb, $fb, $fe, $ff, $ff, $ff, $fc, $fd, $ff, $ff, $fe, $ff, $ff, $ff

.segment "fonts2"

_GetRealSize:
	subv 32
	jsr GetChWdth1
	tay
	txa
	ldx curHeight
	pha
	and #$40
	beq GReSiz1
	iny
GReSiz1:
	pla
	and #8
	beq GReSiz2
	inx
	inx
	iny
	iny
	lda baselineOffset
	addv 2
	rts
GReSiz2:
	lda baselineOffset
	rts

Font_1:
	ldy r1H
	iny
	sty E87FE
	sta r5L
	ldx #0
	addv 32
	jsr GetRealSize
	tya
	pha
	lda r5L
	asl
	tay
	lda (curIndexTable),y
	sta r2L
	and #%00000111
	sta E87FD
	lda r2L
	and #%11111000
	sta r3L
	iny
	lda (curIndexTable),y
	sta r2H
	pla
	add r2L
	sta r6H
	clc
	sbc r3L
	lsr
	lsr
	lsr
	sta r3H
	tax
	cpx #3
	bcc Font_11
	ldx #3
Font_11:
	lda Font_tabL,x
	sta r13L
	lda Font_tabH,x
	sta r13H
	lda r2L
	lsr r2H
	ror
	lsr r2H
	ror
	lsr r2H
	ror
	add cardDataPntr
	sta r2L
	lda r2H
	adc cardDataPntr+1
	sta r2H
	ldy E87FD
	lda BitMaskLeadingSet,y
	eor #$ff
	sta E87FC
	ldy r6H
	dey
	tya
	and #%00000111
	tay
	lda BitMaskLeadingClear,y
	eor #$ff
	sta r7H
	lda currentMode
	tax
	and #SET_OUTLINE
	beq Font_12
	lda #$80
Font_12:
	sta r8H
	lda r5L
	addv 32
	jsr GetRealSize
	sta r5H
	SubB r5H, r1H
	stx r10H
	tya
	pha
	lda r11H
	bmi Font_13
	CmpW rightMargin, r11
	bcc Font_16
Font_13:
	lda currentMode
	and #SET_ITALIC
	bne Font_14
	tax
Font_14:
	txa
	lsr
	sta r3L
	add r11L
	sta FontTVar2
	lda r11H
	adc #0
	sta FontTVar2+1
	PopB PrvCharWidth
	add FontTVar2
	sta r11L
	lda #0
	adc FontTVar2+1
	sta r11H
	bmi Font_17
	CmpW leftMargin, r11
	bcs Font_17
	jsr Font_2
	ldx #0
	lda currentMode
	and #SET_REVERSE
	beq Font_15
	dex
Font_15:
	stx r10L
	clc
	rts

Font_16:
	PopB PrvCharWidth
	add r11L
	sta r11L
	bcc Font_18
	inc r11H
	sec
	rts
Font_17:
	SubB r3L, r11L
	bcs Font_18
	dec r11H
Font_18:
	sec
	rts

Font_tabL:
	.byte <FontGt1, <FontGt2, <FontGt3, <FontGt4
Font_tabH:
	.byte >FontGt1, >FontGt2, >FontGt3, >FontGt4

Font_2:
	ldx r1H
	jsr GetScanLine
	lda FontTVar2
	ldx FontTVar2+1
	bmi Font_22
	cpx leftMargin+1
	bne Font_21
	cmp leftMargin
Font_21:
	bcs Font_23
Font_22:
	ldx leftMargin+1
	lda leftMargin
Font_23:
	pha
	and #%11111000
	sta r4L
	cpx #0
	bne Font_24
	cmp #$c0
	bcc Font_26
Font_24:
	subv $80
	pha
	AddVB $80, r5L
	sta r6L
	bcc Font_25
	inc r5H
	inc r6H
Font_25:
	pla
Font_26:
	sta r1L
	MoveB FontTVar2+1, r3L
	lsr r3L
	lda FontTVar2
	ror
	lsr r3L
	ror
	lsr r3L
	ror
	sta r7L
	lda leftMargin+1
	lsr
	lda leftMargin
	ror
	lsr
	lsr
	sub r7L
	bpl Font_27
	lda #0
Font_27:
	sta FontTVar1
	lda FontTVar2
	and #%00000111
	sta r7L
	pla
	and #%00000111
	tay
	lda BitMaskLeadingSet,y
	sta r3L
	eor #$ff
	sta r9L
	ldy r11L
	dey
	ldx rightMargin+1
	lda rightMargin
	cpx r11H
	bne Font_28
	cmp r11L
Font_28:
	bcs Font_29
	tay
Font_29:
	tya
	and #%00000111
	tax
	lda BitMaskLeadingClear,x
	sta r4H
	eor #$ff
	sta r9H
	tya
	sub r4L
	bpl Font_210
	lda #0
Font_210:
	lsr
	lsr
	lsr
	add FontTVar1
	sta r8L
	cmp r3H
	bcs Font_211
	lda r3H
Font_211:
	cmp #3
	bcs Font_213
	cmp #2
	bne Font_212
	lda #1
Font_212:
	asl
	asl
	asl
	asl
	sta r12L
	lda r7L
	sub E87FD
	addv 8
	add r12L
	tax
	lda Font_tab2,x
	addv <FontSH1
	tay
	lda #0
	adc #>FontSH1
	bne Font_214
Font_213:
	lda #>FontSH5
	ldy #<FontSH5
Font_214:
	sta r12H
	sty r12L
Font_215:
	clc
	rts

Font_tab2:
	.byte <(FntSh56-FontSH1)
	.byte <(FontSH3-FontSH1+0)
	.byte <(FontSH3-FontSH1+1)
	.byte <(FontSH3-FontSH1+2)
	.byte <(FontSH3-FontSH1+3)
	.byte <(FontSH3-FontSH1+4)
	.byte <(FontSH3-FontSH1+5)
	.byte <(FontSH3-FontSH1+6)
	.byte <(FontSH1-FontSH1+7)
	.byte <(FontSH1-FontSH1+6)
	.byte <(FontSH1-FontSH1+5)
	.byte <(FontSH1-FontSH1+4)
	.byte <(FontSH1-FontSH1+3)
	.byte <(FontSH1-FontSH1+2)
	.byte <(FontSH1-FontSH1+1)
	.byte <(FontSH1-FontSH1+0)
	.byte <(FntSh56-FontSH1)
	.byte <(FontSH4-FontSH1+0)
	.byte <(FontSH4-FontSH1+5)
	.byte <(FontSH4-FontSH1+10)
	.byte <(FontSH4-FontSH1+15)
	.byte <(FontSH4-FontSH1+20)
	.byte <(FontSH4-FontSH1+25)
	.byte <(FontSH4-FontSH1+30)
	.byte <(FontSH2-FontSH1+35)
	.byte <(FontSH2-FontSH1+30)
	.byte <(FontSH2-FontSH1+25)
	.byte <(FontSH2-FontSH1+20)
	.byte <(FontSH2-FontSH1+15)
	.byte <(FontSH2-FontSH1+10)
	.byte <(FontSH2-FontSH1+5)
	.byte <(FontSH2-FontSH1+0)

Font_3:
	lda currentMode
	bpl Font_32
	ldy r1H
	cpy E87FE
	beq Font_31
	dey
	cpy E87FE
	bne Font_32
Font_31:
	lda r10L
	eor #$ff
	sta r10L
Font_32:
	bbrf ITALIC_BIT, currentMode, Font_215
	lda r10H
	lsr
	bcs Font_35
	ldx FontTVar2
	bne Font_33
	dec FontTVar2+1
Font_33:
	dex
	stx FontTVar2
	ldx r11L
	bne Font_34
	dec r11H
Font_34:
	dex
	stx r11L
	jsr Font_2
Font_35:
	CmpW rightMargin, FontTVar2
	bcc Font_36
	CmpW leftMargin, r11
	rts
Font_36:
	sec
	rts

Font_4:
	ldy r1L
	ldx FontTVar1
	lda Z45,x
	cpx r8L
	beq Font_43
	bcs Font_44
	eor r10L
	and r9L
	sta Font4_B1
	lda r3L
	and (r6),y
Font4_B1 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
Font_41:
	tya
	addv 8
	tay
	inx
	cpx r8L
	beq Font_42
	lda Z45,x
	eor r10L
	sta (r6),y
	sta (r5),y
	bra Font_41
Font_42:
	lda Z45,x
	eor r10L
	and r9H
	sta Font4_B2
	lda r4H
	and (r6),y
Font4_B2 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
	rts
Font_43:
	eor r10L
	and r9H
	eor #$ff
	ora r3L
	ora r4H
	eor #$ff
	sta Font4_B3
	lda r3L
	ora r4H
	and (r6),y
Font4_B3 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
Font_44:
	rts

Font_5:
	ldx r8L
	lda #0
Font_51:
	sta E87FF,x
	dex
	bpl Font_51
	lda r8H
	and #%01111111
	bne Font_54
Font_52:
	jsr Font_8
Font_52_2:
	ldx r8L
Font_53:
	lda E87FF,x
	sta Z45,x
	dex
	bpl Font_53
	inc r8H
	rts
Font_54:
	cmp #1
	beq Font_55
	ldy r10H
	dey
	beq Font_52
	dey
	php
	jsr Font_8
	jsr Font_6
	plp
	beq Font_56
Font_55:
	jsr Font_6
	jsr FntIndirectJMP
	jsr Font_8
	SubW curSetWidth, r2
Font_56:
	jsr FntIndirectJMP
	jsr Font_8
	jsr Font_7
	bra Font_52_2

Font_6:
	AddW curSetWidth, r2
	rts

Font_7:
	ldy #$ff
Font_71:
	iny
	ldx #7
Font_72:
	lda Z45,y
	and BitMaskPow2,x
	beq Font_73
	lda BitMaskPow2,x
	eor #$ff
	and E87FF,y
	sta E87FF,y
Font_73:
	dex
	bpl Font_72
	cpy r8L
	bne Font_71
	rts

Font_8:
	jsr Font_9
	ldy #$ff
Font_81:
	iny
	ldx #7
Font_82:
	lda Z45,y
	and BitMaskPow2,x
	beq Font_87
	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
	inx
	cpx #8
	bne Font_83
	lda E87FE,y
	ora #1
	sta E87FE,y
	bne Font_84
Font_83:
	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
Font_84:
	dex
	dex
	bpl Font_85
	lda E8800,y
	ora #$80
	sta E8800,y
	bne Font_86
Font_85:
	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
Font_86:
	inx
Font_87:
	dex
	bpl Font_82
	cpy r8L
	bne Font_81
	rts

Font_9:
	lsr Z45
	ror Z45+1
	ror Z45+2
	ror Z45+3
	ror Z45+4
	ror Z45+5
	ror Z45+6
	ror Z45+7
	rts

Font_10:
	nop
	tay
	PushB r1H
	tya
	jsr Font_1
	bcs Font_108
Font_100:
	clc
	lda currentMode
	and #SET_UNDERLINE | SET_ITALIC
	beq Font_101
	jsr Font_3
Font_101:
	php
	bcs Font_102
	jsr FntIndirectJMP
Font_102:
	bbrf 7, r8H, Font_103
	jsr Font_5
	bra Font_104
Font_103:
	jsr Font_6
Font_104:
	plp
	bcs Font_106
	lda r1H
	cmp windowTop
	bcc Font_106
	cmp windowBottom
	bcc Font_105
	bne Font_106
Font_105:
	jsr Font_4
Font_106:
	inc r5L
	inc r6L
	lda r5L
	and #%00000111
	bne Font_107
	inc r5H
	inc r6H
	AddVB $38, r5L
	sta r6L
	bcc Font_107
	inc r5H
	inc r6H
Font_107:
	inc r1H
	dec r10H
	bne Font_100
Font_108:
	PopB r1H
	rts

;procedures indexed from Font_Tab2, DO NOT CHANGE!

FontSH1:
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	jmp FntShJump
FontSH2:
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	lsr
	ror Z46
	ror Z47
	jmp FntShJump
FontSH3:
	asl
	asl
	asl
	asl
	asl
	asl
	asl
	jmp FntShJump
FontSH4:
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	asl Z47
	rol Z46
	rol
	jmp FntShJump
FontSH5:
	sta Z45
	lda r7L
	sub E87FD
	beq FntSh52
	bcc FntSh53
	tay
FntSh51:
	jsr Font_9
	dey
	bne FntSh51
FntSh52:
	lda Z45
	jmp FntShJump
FntSh53:
	lda E87FD
	sub r7L
	tay
FntSh54:
	asl Z45+7
	rol Z45+6
	rol Z45+5
	rol Z45+4
	rol Z45+3
	rol Z45+2
	rol Z45+1
	rol Z45
	dey
	bne FntSh54
	lda Z45
FntShJump:
	sta Z45
	bbrf BOLD_BIT, currentMode, FntSh56
	lda #0
	pha
	ldy #$ff
FntSh55:
	iny
	ldx Z45,y
	pla
	ora ID100+$10,x
	sta Z45,y
	txa
	lsr
	lda #0
	ror
	pha
	cpy r8L
	bne FntSh55
	pla
FntSh56:
	rts

; end of indexed table, keep on changin'

FntIndirectJMP:
	ldy #0
	jmp (r13)

FontGt1:
	sty Z45+1
	sty Z45+2
	lda (r2),y
	and E87FC
	and r7H
	jmp (r12)

FontGt2:
	sty Z45+2
	sty Z45+3
	lda (r2),y
	and E87FC
	sta Z45
	iny
	lda (r2),y
	and r7H
	sta Z45+1
FontGt2_1:
	lda Z45
	jmp (r12)

FontGt3:
	sty Z45+3
	sty Z45+4
	lda (r2),y
	and E87FC
	sta Z45
	iny
	lda (r2),y
	sta Z45+1
	iny
	lda (r2),y
	and r7H
	sta Z45+2
	bra FontGt2_1

FontGt4:
	lda (r2),y
	and E87FC
	sta Z45
FontGt4_1:
	iny
	cpy r3H
	beq FontGt4_2
	lda (r2),y
	sta Z45,y
	bra FontGt4_1
FontGt4_2:
	lda (r2),y
	and r7H
	sta Z45,y
	lda #0
	sta Z45+1,y
	sta Z45+2,y
	beq FontGt2_1

FontTVar1:
	.byte 0
FontTVar2:
.ifdef maurice
    ; This should be initialized to 0, and will
    ; be changed at runtime.
    ; Maurice's version was created by dumping
    ; KERNAL from memory after it had been running,
    ; so it has a random value here.
	.word $34
.else
	.word 0
.endif
