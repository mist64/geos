; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Disk driver management on 128K systems

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "swapdiskdriver"

.global _SwapDiskDriver
_SwapDiskDriver:
	lda config
	ora #1
	sta config ; disable I/O
	jsr PrepForFetch2
	jsr SwapMemory
	jsr PrepForFetch2
	lda config
	and #$FE
	sta config ; enable I/O
	rts

; XXX almost a copy of PrepForFetch
PrepForFetch2:
	ldy #5
@1:	lda r0,y
	tax
	lda SetDevTab2,y
	sta r0,y
	txa
	sta SetDevTab2,y
	dey
	bpl @1
	rts

SetDevTab2:
	.word DISK_BASE
	.word DISK_SWAPBASE
	.word DISK_DRV_LGH

; swap r2 bytes between r0 and r1
SwapMemory:
	PushB r0H
	PushB r1H
	PushB r2H
	ldy #$00
LF72E:	lda r2H
	beq LF748
LF732:	lda (r0),y
	tax
	lda (r1),y
	sta (r0),y
	txa
	sta (r1),y
	iny
	bne LF732
	inc r0H
	inc r1H
	dec r2H
	bra LF72E
LF748:	cpy r2L
	beq LF759
	lda (r0),y
	tax
	lda (r1),y
	sta (r0),y
	txa
	sta (r1),y
	iny
	bne LF748
LF759:	PopB r2H
	PopB r1H
	PopB r0H
	rts

