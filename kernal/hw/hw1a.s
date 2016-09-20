; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; VIC initialization table

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global VIC_IniTbl
.global VIC_IniTbl_end

.segment "hw1a"

VIC_IniTbl:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $3b, $fb, $aa, $aa, $01, $08, $00
	.byte $38, $0f, $01, $00, $00, $00
VIC_IniTbl_end:

