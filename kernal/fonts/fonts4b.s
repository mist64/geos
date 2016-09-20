; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Font drawing

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global FontGt1
.global FontGt2
.global FontGt3
.global FontGt4
.global FontTVar1
.global FontTVar2

.segment "fonts4b"

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
.ifdef bsw128 ; dup for speed?
	lda Z45
	jmp (r12)
.else
	bra FontGt2_1
.endif

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
.ifdef bsw128 ; dup for speed?
	lda Z45
	jmp (r12)
.else
	beq FontGt2_1
.endif

.ifndef bsw128

.ifndef wheels
FontTVar1:
.endif
	.byte 0
.ifndef wheels
FontTVar2:
.endif
.ifdef cbmfiles
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
