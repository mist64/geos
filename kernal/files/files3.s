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

.import DkNmTabH
.import DkNmTabL

.global _GetPtrCurDkNm

.segment "files3"

_GetPtrCurDkNm:
	ldy curDrive
	lda DkNmTabL-8,Y
	sta zpage,x
	lda DkNmTabH-8,Y
	sta zpage+1,x
	rts

