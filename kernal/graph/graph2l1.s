; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import GraphPenX
.import GraphPenY
.import GetCoords

GraphPenXL = GraphPenX
GraphPenXH = GraphPenX+1

.global GrStSetCoords

.segment "graph2l1"

GrStSetCoords:
	jsr GetCoords
	cmp GraphPenY
	bcs @1
	sta r2L
	pha
	lda GraphPenY
	sta r2H
	bra @2
@1:	sta r2H
	pha
	lda GraphPenY
	sta r2L
@2:	PopB GraphPenY
	cpy GraphPenXH
	beq @3
	bcs @5
@3:	bcc @4
	cpx GraphPenXL
	bcs @5
@4:	stx r3L
	sty r3H
	MoveW GraphPenX, r4
	bra @6
@5:	stx r4L
	sty r4H
	MoveW GraphPenX, r3
@6:	stx GraphPenXL
	sty GraphPenXH
	rts

