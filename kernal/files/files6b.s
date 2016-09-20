; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global GetStartHAddr
.global SetBufTSVector
.global SetFHeadVector

.segment "files6b"

SetBufTSVector:
	LoadW r6, fileTrScTab
	rts

GetStartHAddr:
	MoveW fileHeader + O_GHST_ADDR, r7
	rts

SetFHeadVector:
	LoadW r4, fileHeader
	rts

