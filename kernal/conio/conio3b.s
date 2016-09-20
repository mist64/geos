; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: UseSystemFont, LoadCharSet, GetCharWidth syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _LoadCharSet

.import BSWFont

.if .defined(trap2) && (!.defined(trap2_alternate_location))
.import GetSerialNumber2
.import SerialHiCompare
.endif

.ifdef bsw128
.import BSWFont80
.endif

.ifdef bsw128
; XXX back bank, yet var lives on front bank!
PrvCharWidth = $880D
.else
.import PrvCharWidth
.endif

.global GetChWdth1
.global _UseSystemFont
.global _GetCharWidth

.segment "conio3b"

_UseSystemFont:
.ifdef bsw128
	bbsf 7, graphMode, @X
	LoadW r0, BSWFont
	bra _LoadCharSet
@X:	LoadW r0, BSWFont80
.else
	LoadW r0, BSWFont
.endif
_LoadCharSet:
	ldy #0
@1:	lda (r0),y
	sta baselineOffset,y
	iny
	cpy #8
	bne @1
	AddW r0, curIndexTable
	AddW r0, cardDataPntr

.if .defined(trap2) && (!.defined(trap2_alternate_location))
	; copy high-byte of serial
	lda SerialHiCompare
	bne @2
	jsr GetSerialNumber2
	sta SerialHiCompare
@2:
.endif
	rts

_GetCharWidth:
	subv $20
	bcs GetChWdth1
	lda #0
	rts
GetChWdth1:
	cmp #$5f
.ifdef bsw128 ; branch taken/not taken optimization
	beq @2
.else
	bne @1
	lda PrvCharWidth
	rts
@1:
.endif
	asl
	tay
	iny
	iny
	lda (curIndexTable),y
	dey
	dey
	sec
	sbc (curIndexTable),y
	rts
.ifdef bsw128 ; branch taken/not taken optimization
@2:	lda PrvCharWidth
	rts
.endif

