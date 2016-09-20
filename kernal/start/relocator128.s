; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak; Michael Steil
;
; C128 relocation code
;
; layout:
; $4800-$4c00 - relocator
; $4c00-$5000 - purgeable start code -> $15000
; $5000-$9000 - bank1 kernal 	     -> $1c000
; $9000-$a000 - bank1 disk driver    -> $19000
; $a000-$c000 - bank0 kernal high    -> $0e000
; $c000-$d000 - bank0 kernal low     -> $0c000	(in place)
;
; note that $ff05-$ffff (lastpage) must be handled in special way
; in both banks
;

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "relocator"

RELOC_PAGE = $0400 	 ; in shared area
RELOCATOR = $0500

InitKernal = $5000

	sei
	LoadB config, %00111110 ; enter bank0+I/O
	PushB grcntrl1
	PushB clkreg
	LoadB grcntrl1, 0
	LoadB clkreg, 1
	lda mmu+6
	and #%11110000 ; no sharing
	sta mmu+6
	ldx #0
InstallRel:
	lda RelMoveData,x
	sta RELOCATOR,x
	inx
	cpx #RelMoveDataEnd-RelMoveData
	bne InstallRel

	LoadW r0, $4c00
	LoadW r1, $5000
	LoadB r3L, 0
	LoadB r3H, 1
	LoadB r2L, 4
	jsr RELOCATOR

	LoadW r0, $5000
	LoadW r1, $c000
	LoadB r3L, 0
	LoadB r3H, 1
	LoadB r2L, 64-1
	jsr RELOCATOR

	LoadW r0, $9000
	LoadW r1, $9000
	LoadB r3L, 0
	LoadB r3H, 1
	LoadB r2L, 16
	jsr RELOCATOR

	LoadW r0, $9000
	LoadW r1, $d000
	LoadB r3L, 0
	LoadB r3H, 0
	LoadB r2L, 16
	jsr RELOCATOR

	LoadW r0, $a000
	LoadW r1, $e000
	LoadB r3L, 0
	LoadB r3H, 0
	LoadB r2L, 32-1
	jsr RELOCATOR

	ldx #0
lastpage0:
	lda $a000+$1f05,x
	sta $ff05,x
	lda $5000+$3f05,x
	sta RELOC_PAGE+5,x
	inx
	cpx #$100-5
	bne lastpage0

	ldx #0
InstallTram:
	lda Trampoline,x
	sta RELOCATOR,x
	inx
	cpx #TrampolineEnd-Trampoline
	bne InstallTram

	PopB clkreg
	PopB grcntrl1

	jmp RELOCATOR

Trampoline:
	LoadB config, %01111110 ; enter bank1+I/O
	inc $d020
	lda mmu+6
	and #%11110000
	ora #%00000111 ; share bottom 16k
	sta mmu+6
	ldx #0
lastpage1:
	lda RELOC_PAGE+5,x
	sta $ff05,x
	inx
	cpx #$100-5
	bne lastpage1

	jmp InitKernal ; all is in place, RUN!
TrampolineEnd:

; r3L - source
; r3H - dest bank
; r0 - source data
; r1 - dest data
; r2L - # of pages
RelMoveData:
	PushB config
	PushB mmu+6
	and #%11110000
	ora #%00000111 ; share bottom 16k
	sta mmu+6
	lda r3L
	ror
	ror
	ror
	and #%11000000
	ora #%00111111
	sta r3L
	sta config
	lda r3H
	ror
	ror
	ror
	and #%11000000
	ora #%00111111
	sta r3H

	ldy #0
	ldx r2L

RelMoveB_1:
	lda (r0),y
	sta RELOC_PAGE,y
	iny
	bne RelMoveB_1

	MoveB r3H, config
RelMoveB_2:
	lda RELOC_PAGE,y
	sta (r1),y
	iny
	bne RelMoveB_2

	MoveB r3L, config
	inc r0H
	inc r1H
	dex
	bpl RelMoveB_1

	PopB mmu+6
	PopB config
	rts
RelMoveDataEnd:
