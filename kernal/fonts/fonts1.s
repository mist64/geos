; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Font drawing: lookup table

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global FontTab

.segment "fonts1"

FontTab:
	.byte $00,$01,$03,$03,$06,$07,$07,$07,$0c,$0d,$0f,$0f,$0e,$0f,$0f,$0f
	.byte $18,$19,$1b,$1b,$1e,$1f,$1f,$1f,$1c,$1d,$1f,$1f,$1e,$1f,$1f,$1f
	.byte $30,$31,$33,$33,$36,$37,$37,$37,$3c,$3d,$3f,$3f,$3e,$3f,$3f,$3f
	.byte $38,$39,$3b,$3b,$3e,$3f,$3f,$3f,$3c,$3d,$3f,$3f,$3e,$3f,$3f,$3f
	.byte $60,$61,$63,$63,$66,$67,$67,$67,$6c,$6d,$6f,$6f,$6e,$6f,$6f,$6f
	.byte $78,$79,$7b,$7b,$7e,$7f,$7f,$7f,$7c,$7d,$7f,$7f,$7e,$7f,$7f,$7f
	.byte $70,$71,$73,$73,$76,$77,$77,$77,$7c,$7d,$7f,$7f,$7e,$7f,$7f,$7f
	.byte $78,$79,$7b,$7b,$7e,$7f,$7f,$7f,$7c,$7d,$7f,$7f,$7e,$7f,$7f,$7f
	.byte $c0,$c1,$c3,$c3,$c6,$c7,$c7,$c7,$cc,$cd,$cf,$cf,$ce,$cf,$cf,$cf
	.byte $d8,$d9,$db,$db,$de,$df,$df,$df,$dc,$dd,$df,$df,$de,$df,$df,$df
	.byte $f0,$f1,$f3,$f3,$f6,$f7,$f7,$f7,$fc,$fd,$ff,$ff,$fe,$ff,$ff,$ff
	.byte $f8,$f9,$fb,$fb,$fe,$ff,$ff,$ff,$fc,$fd,$ff,$ff,$fe,$ff,$ff,$ff
	.byte $e0,$e1,$e3,$e3,$e6,$e7,$e7,$e7,$ec,$ed,$ef,$ef,$ee,$ef,$ef,$ef
	.byte $f8,$f9,$fb,$fb,$fe,$ff,$ff,$ff,$fc,$fd,$ff,$ff,$fe,$ff,$ff,$ff
	.byte $f0,$f1,$f3,$f3,$f6,$f7,$f7,$f7,$fc,$fd,$ff,$ff,$fe,$ff,$ff,$ff
	.byte $f8,$f9,$fb,$fb,$fe,$ff,$ff,$ff,$fc,$fd,$ff,$ff,$fe,$ff,$ff,$ff

