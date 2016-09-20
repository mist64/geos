; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Loading

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import CopyFString
.import A885F
.import A885E
.import A885D
.if .defined(trap2) && .defined(trap2_alternate_location)
.import GetSerialNumber2
.import SerialHiCompare
.endif

.global UNK_4
.global UNK_5

.segment "load2"

UNK_4:
	MoveB A885D, r10L
	MoveB A885E, r0L
	and #1
	beq @1
	MoveW A885F, r7
@1:	LoadW r2, dataDiskName
	LoadW r3, dataFileName
	rts

UNK_5:
.if .defined(trap2) && .defined(trap2_alternate_location)
	; copy high-byte of serial
	lda SerialHiCompare
	bne @1
	jsr GetSerialNumber2
	sta SerialHiCompare
@1:
.endif
.ifndef bsw128
	MoveW r7, A885F
.endif
	MoveB r10L, A885D
	MoveB r0L, A885E
	and #%11000000
	beq @2
.ifdef bsw128
	LoadW r4, dataDiskName
	ldx #r2
	ldy #r4
	lda #16
	jsr CopyFString
	LoadW r4, dataFileName
	ldx #r3
.else
	ldy #>dataDiskName
	lda #<dataDiskName
	ldx #r2
	jsr @1
	ldy #>dataFileName
	lda #<dataFileName
	ldx #r3
@1:	sty r4H
	sta r4L
.endif
	ldy #r4
	lda #16
	jsr CopyFString
@2:
.ifdef bsw128
	MoveW r7, A885F
.endif
	rts

