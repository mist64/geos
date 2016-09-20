; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/CIA clock driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global pingTab
.global pingTabEnd

.segment "time2"

pingTab:
	.byte $00, $10, $00, $08, $40, $08, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $0f
pingTabEnd:

.if (!.defined(remove_dead_bytes)) && (!.defined(bsw128))
; ???
.ifdef wheels
	.word 0
.else
	.word $0f00
.endif
.endif
