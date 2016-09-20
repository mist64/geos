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

.segment "files2"

.global DkNmTabH
.global DkNmTabL

.define DkNmTab DrACurDkNm, DrBCurDkNm, DrCCurDkNm, DrDCurDkNm
DkNmTabL:
	.lobytes DkNmTab
DkNmTabH:
	.hibytes DkNmTab

