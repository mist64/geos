; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
;

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global GetInlineDrwParms

.segment "inline"

GetInlineDrwParms:
.ifdef bsw128
	PopW r6
.endif
	PopW r5
	PopW returnAddress
.ifdef wheels_size
	ldy #0
@1:	iny
	lda (returnAddress),y
	sta r1H,y
	cpy #6
	bne @1
.else
	ldy #1
	lda (returnAddress),Y
	sta r2L
	iny
	lda (returnAddress),Y
	sta r2H
	iny
	lda (returnAddress),Y
	sta r3L
	iny
	lda (returnAddress),Y
	sta r3H
	iny
	lda (returnAddress),Y
	sta r4L
	iny
	lda (returnAddress),Y
	sta r4H
.endif
	PushW r5
.ifdef bsw128
	PushW r6
.endif
	rts

