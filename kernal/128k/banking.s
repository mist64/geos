; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Cross-bank calling

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global CallAddr2
.global CallCBMKERNAL
.global _CallNoRAMSharing
.global CallBackBank

.segment "banking"

; disable RAM sharing between banks and call
; indirect address in register indexed by A
_CallNoRAMSharing:
	sta @addr2
	MoveB rcr, @addr1
	and #%11110000
	sta rcr
	jsr @1
@addr1 = * + 1
	ldx #0
	stx rcr
	rts
@addr2 = * + 1
@1:
	jmp (0)

; called from $FF81+, CBM KERNAL calls
CallCBMKERNAL:
	; save A
	sta L8896
	; get JSR target from stack
	PopW @address
	sec
	lda @address
	sbc #2
	sta @address
	lda @address + 1
	sbc #0
	sta @address + 1
	; switch banks
	MoveB config, krnlSaveConfig
	LoadB config, CKRNLIOIN
	lda rcr
	sta krnlSaveRcr
	and #%11110000 ; don't touch VIC
	ora #%00000101 ; 4 KB common RAM bottom
	sta rcr
	; restore A
	lda L8896
	; call function
@address = *+1
	jsr $FF8A
	; save A and P
	php
	pha
	; restore banking
	MoveB krnlSaveRcr, rcr
	MoveB krnlSaveConfig, config
	; restore A and P
	pla
	plp
	rts

; called from $E000+
CallBackBank:
	; save A and P
	sta bank0SaveA
	php
	PopB bank0SavePS
	pla
	; get JSR target from stack
	sub #2
	sta CallAddr2
	PopB CallAddr2 + 1
	; switch banks
	lda rcr
	sta bank0SaveRcr
	and #%11110000 ; don't touch VIC
	ora #%00001011 ; 16 KB common RAM top
	sta rcr
	; restore A and P
	lda bank0SavePS
	pha
	lda bank0SaveA
	plp
	; call function
CallAddr2 = *+1
	jsr $E072
	; restore banking
	php
	pha
	lda bank0SaveRcr
	sta rcr
	pla
	plp
	rts
