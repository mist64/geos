; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Font drawing

.include "config.inc"
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

; var.s
.import PrvCharWidth

; used by conio.s
.global FontPutChar

; syscall
.global _GetRealSize

.segment "fonts1"

ID110:
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

;---------------------------------------------------------------
; GetRealSize                                             $C1B1
;
; Function:  Returns the size of a character in the current
;            mode (bold, italic...) and current Font.
;
; Pass:      a   ASCII character
;            x   currentMode
; Return:    y   character width
;            x   character height
;            a   baseline offset
; Destroyed: nothing
;---------------------------------------------------------------
.if !wheels ; moved
_GetRealSize:
	subv 32
	jsr GetChWdth1
	tay
	txa
	ldx curHeight
	pha
	and #$40
	beq @1
	iny
@1:	pla
	and #8
	beq @2
	inx
	inx
	iny
	iny
	lda baselineOffset
	addv 2
	rts
@2:	lda baselineOffset
	rts
.endif

.if wheels
FontTVar1 = $8886
FontTVar2 = $8887
.endif

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
	bcc @1
	ldx #3
@1:	lda Font_tabL,x
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
	beq @2
	lda #$80
@2:	sta r8H
	lda r5L
	addv 32
	jsr GetRealSize
	sta r5H
	SubB r5H, r1H
	stx r10H
	tya
	pha
	lda r11H
	bmi @3
	CmpW rightMargin, r11
	bcc Font_16
@3:	lda currentMode
	and #SET_ITALIC
	bne @4
	tax
@4:	txa
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
	beq @5
	dex
@5:	stx r10L
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

.define Font_tab FontGt1, FontGt2, FontGt3, FontGt4
Font_tabL:
	.lobytes Font_tab
Font_tabH:
	.hibytes Font_tab

Font_2:
	ldx r1H
	jsr GetScanLine
	lda FontTVar2
	ldx FontTVar2+1
	bmi @2
	cpx leftMargin+1
	bne @1
	cmp leftMargin
@1:	bcs @3
@2:	ldx leftMargin+1
	lda leftMargin
@3:	pha
	and #%11111000
	sta r4L
	cpx #0
	bne @4
	cmp #$c0
	bcc @6
@4:	subv $80
	pha
	AddVB $80, r5L
	sta r6L
	bcc @5
	inc r5H
	inc r6H
@5:	pla
@6:	sta r1L
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
	bpl @7
	lda #0
@7:	sta FontTVar1
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
	bne @8
	cmp r11L
@8:	bcs @9
	tay
@9:	tya
	and #%00000111
	tax
	lda BitMaskLeadingClear,x
	sta r4H
	eor #$ff
	sta r9H
	tya
	sub r4L
	bpl @A
	lda #0
@A:	lsr
	lsr
	lsr
	add FontTVar1
	sta r8L
	cmp r3H
	bcs @B
	lda r3H
@B:	cmp #3
	bcs @D
	cmp #2
	bne @C
	lda #1
@C:	asl
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
	addv <base
	tay
	lda #0
	adc #>base
	bne @E
@D:	lda #>FontSH5
	ldy #<FontSH5
@E:	sta r12H
	sty r12L
clc_rts:
	clc
	rts

Font_tab2:
	.byte <(noop-base)
	.byte <(b7-base)
	.byte <(b6-base)
	.byte <(b5-base)
	.byte <(b4-base)
	.byte <(b3-base)
	.byte <(b2-base)
	.byte <(b1-base)
	.byte <(c0-base)
	.byte <(c1-base)
	.byte <(c2-base)
	.byte <(c3-base)
	.byte <(c4-base)
	.byte <(c5-base)
	.byte <(c6-base)
	.byte <(c7-base)
	.byte <(noop-base)
	.byte <(d7-base)
	.byte <(d6-base)
	.byte <(d5-base)
	.byte <(d4-base)
	.byte <(d3-base)
	.byte <(d2-base)
	.byte <(d1-base)
	.byte <(e0-base)
	.byte <(e1-base)
	.byte <(e2-base)
	.byte <(e3-base)
	.byte <(e4-base)
	.byte <(e5-base)
	.byte <(e6-base)
	.byte <(e7-base)

.if wheels
	.res 9, 0
.endif

.if wheels ; xxx moved, but unchanged
_GetRealSize:
	subv 32
	jsr GetChWdth1
	tay
	txa
	ldx curHeight
	pha
	and #$40
	beq @1
	iny
@1:	pla
	and #8
	beq @2
	inx
	inx
	iny
	iny
	lda baselineOffset
	addv 2
	rts
@2:	lda baselineOffset
	rts

.endif

; called if currentMode & (SET_UNDERLINE | SET_ITALIC)
Font_3:
	lda currentMode
	bpl @2
	ldy r1H
	cpy E87FE
	beq @1
	dey
	cpy E87FE
	bne @2
@1:	lda r10L
	eor #$ff
	sta r10L
@2:
.if wheels
	bbsf ITALIC_BIT, currentMode, @X
	clc
	rts
@X:
.else
	bbrf ITALIC_BIT, currentMode, clc_rts
.endif
	lda r10H
	lsr
	bcs @5
	ldx FontTVar2
	bne @3
	dec FontTVar2+1
@3:	dex
	stx FontTVar2
	ldx r11L
	bne @4
	dec r11H
@4:	dex
	stx r11L
	jsr Font_2
@5:	CmpW rightMargin, FontTVar2
	bcc @6
	CmpW leftMargin, r11
	rts
@6:	sec
	rts

Font_4:
	ldy r1L
	ldx FontTVar1
	lda Z45,x
	cpx r8L
	beq @3
	bcs @4
	eor r10L
	and r9L
	sta @mask1
	lda r3L
	and (r6),y
@mask1 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
@1:	tya
	addv 8
	tay
	inx
	cpx r8L
	beq @2
	lda Z45,x
	eor r10L
	sta (r6),y
	sta (r5),y
	bra @1
@2:	lda Z45,x
	eor r10L
	and r9H
	sta @mask2
	lda r4H
	and (r6),y
@mask2 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
	rts
@3:	eor r10L
	and r9H
	eor #$ff
	ora r3L
	ora r4H
	eor #$ff
	sta @mask3
	lda r3L
	ora r4H
	and (r6),y
@mask3 = *+1
	ora #0
	sta (r6),y
	sta (r5),y
@4:	rts

Font_5:
	ldx r8L
	lda #0
@1:	sta E87FF,x
	dex
	bpl @1
	lda r8H
	and #%01111111
	bne @5
@2:	jsr Font_8
@3:	ldx r8L
@4:	lda E87FF,x
	sta Z45,x
	dex
	bpl @4
	inc r8H
	rts
@5:	cmp #1
	beq @6
	ldy r10H
	dey
	beq @2
	dey
	php
	jsr Font_8
	jsr Font_6
	plp
	beq @7
@6:	jsr Font_6
	jsr FntIndirectJMP
	jsr Font_8
	SubW curSetWidth, r2
@7:	jsr FntIndirectJMP
	jsr Font_8
	jsr Font_7
	bra @3

Font_6:
	AddW curSetWidth, r2
	rts

Font_7:
	ldy #$ff
@1:	iny
	ldx #7
@2:	lda Z45,y
	and BitMaskPow2,x
	beq @3
	lda BitMaskPow2,x
	eor #$ff
	and E87FF,y
	sta E87FF,y
@3:	dex
	bpl @2
	cpy r8L
	bne @1
	rts

Font_8:
	jsr Font_9
	ldy #$ff
@1:	iny
	ldx #7
@2:	lda Z45,y
	and BitMaskPow2,x
	beq @7
	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
	inx
	cpx #8
	bne @3
	lda E87FE,y
	ora #1
	sta E87FE,y
	bne @4
@3:	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
@4:	dex
	dex
	bpl @5
	lda E8800,y
	ora #$80
	sta E8800,y
	bne @6
@5:	lda E87FF,y
	ora BitMaskPow2,x
	sta E87FF,y
@6:	inx
@7:	dex
	bpl @2
	cpy r8L
	bne @1
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

; central character printing, called from conio.s
; character - 32 in A
FontPutChar:
.if !wheels
	nop
.endif
	tay
	PushB r1H
	tya
	jsr Font_1 ; put pointer in r13
	bcs @9 ; return
@1:	clc
	lda currentMode
	and #SET_UNDERLINE | SET_ITALIC
	beq @2
	jsr Font_3
@2:	php
	bcs @3
	jsr FntIndirectJMP ; call r13
@3:	bbrf 7, r8H, @4
	jsr Font_5
	bra @5
@4:	jsr Font_6
@5:	plp
	bcs @7
	lda r1H
	cmp windowTop
	bcc @7
	cmp windowBottom
	bcc @6
	bne @7
@6:	jsr Font_4
@7:	inc r5L
	inc r6L
	lda r5L
	and #%00000111
	bne @8
	inc r5H
	inc r6H
	AddVB $38, r5L
	sta r6L
	bcc @8
	inc r5H
	inc r6H
@8:	inc r1H
	dec r10H
	bne @1
@9:	PopB r1H
	rts

base:

c7:	lsr
c6:	lsr
c5:	lsr
c4:	lsr
c3:	lsr
c2:	lsr
c1:	lsr
c0:	jmp FntShJump

e7:	lsr
	ror Z46
	ror Z47
e6:	lsr
	ror Z46
	ror Z47
e5:	lsr
	ror Z46
	ror Z47
e4:	lsr
	ror Z46
	ror Z47
e3:	lsr
	ror Z46
	ror Z47
e2:	lsr
	ror Z46
	ror Z47
e1:	lsr
	ror Z46
	ror Z47
e0:	jmp FntShJump

b7:	asl
b6:	asl
b5:	asl
b4:	asl
b3:	asl
b2:	asl
b1:	asl
	jmp FntShJump

d7:	asl Z47
	rol Z46
	rol
d6:	asl Z47
	rol Z46
	rol
d5:	asl Z47
	rol Z46
	rol
d4:	asl Z47
	rol Z46
	rol
d3:	asl Z47
	rol Z46
	rol
d2:	asl Z47
	rol Z46
	rol
d1:	asl Z47
	rol Z46
	rol
	jmp FntShJump

.assert * - base < 256, error, "Font shift code must be < 256 bytes"

FontSH5:
	sta Z45
	lda r7L
	sub E87FD
	beq @2
	bcc @3
	tay
@1:
	jsr Font_9
	dey
	bne @1
@2:
	lda Z45
	jmp FntShJump
@3:
	lda E87FD
	sub r7L
	tay
@4:
	asl Z45+7
	rol Z45+6
	rol Z45+5
	rol Z45+4
	rol Z45+3
	rol Z45+2
	rol Z45+1
	rol Z45
	dey
	bne @4
	lda Z45
FntShJump:
	sta Z45
	bbrf BOLD_BIT, currentMode, noop
	lda #0
	pha
	ldy #$ff
@5:
	iny
	ldx Z45,y
	pla
	ora ID110,x
	sta Z45,y
	txa
	lsr
	lda #0
	ror
	pha
	cpy r8L
	bne @5
	pla
noop:
	rts

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

.if wheels
	.byte 0, 0, 0
.else
FontTVar1:
	.byte 0
FontTVar2:
.if cbmfiles
	; This should be initialized to 0, and will
	; be changed at runtime.
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it has a random value here.
	.word $34
.else
	.word 0
.endif
.endif