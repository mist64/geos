; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: misc

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.ifdef wheels
.import StringGetNext
.import DBStringFaultVec2
.endif

.import CallRoutine
.import GraphicsString
.import RstrFrmDialogue

.global DBStringFaultVec
.global DBDoGRPHSTR
.global DBDoOPVEC
.global DBDoUSR_ROUT

.segment "dlgbox1g"

DBStringFaultVec:
	bbsf 7, mouseData, DBDoOPVEC_rts
.ifdef wheels_size ; reuse common code
	jmp DBStringFaultVec2
.else
	lda #DBSYSOPV
	sta sysDBData
	jmp RstrFrmDialogue
.endif

DBDoOPVEC:
	ldy r1L
	lda (DBoxDesc),y
	sta otherPressVec
	iny
	lda (DBoxDesc),y
	sta otherPressVec+1
	iny
	sty r1L
DBDoOPVEC_rts:
	rts


DBDoGRPHSTR:
	ldy r1L
.ifdef wheels_size
	jsr StringGetNext
.else
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
.endif
	pha
	jsr GraphicsString
	PopB r1L
	rts

DBDoUSR_ROUT:
	ldy r1L
.ifdef wheels_size_and_speed ; 13->11 bytes, 25->23 cycles
	iny
	iny
	tya
	pha
	dey
	lda (DBoxDesc),y
	tax
	dey
	lda (DBoxDesc),y
.else
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	tax
	iny
	tya
	pha
	lda r0L
.endif
	jsr CallRoutine
	PopB r1L
	rts

