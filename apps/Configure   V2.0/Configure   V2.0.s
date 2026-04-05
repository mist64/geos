
		.segment "DIRENTRY"

	.byte 131
	.byte $0c, $11 ; start t&s, ignore
	.byte "CONFIGURE"
	.res  (16 - 9), $a0
	.byte $0c, $09 ; header t&s, ignore
	.byte 1
	.byte 14
	.byte 88, 8, 20, 13, 45

	.word $4e ; ??? what ???
	.byte "PRG formatted GEOS file V1.0"

		.segment "FILEINFO"

	.import __VLIR0_START__
	.import APP_START

	.byte 3, 21, 63 | $80

	; Icon
	;.byte $ff,$ff,$ff,$80,$00,$01
	.byte %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000001
	.byte $81,$c1,$81,$88,$22,$41,$9c
	.byte $c2,$41,$89,$02,$41,$81,$e9,$81,$80,$00,$01,$87,$ff,$f9,$88,$00
	.byte $09,$90,$00,$19,$bf,$ff,$f9,$a0,$00,$39,$a7,$ff,$39,$a0,$f8,$39
	.byte $a0,$00,$35,$bf,$ff,$e9,$95,$55,$51,$8a,$aa,$a1
	;.byte $80,$00,$01,$ff,$ff,$ff
	.byte %10000000, %00000000, %00000001
	.byte %11111111, %11111111, %11111111

	.byte 131, 14, 1
	.word __VLIR0_START__, __VLIR0_START__ - 1, APP_START

	.byte "Configure"
	.res  (12 - 9), $20
	.byte "V2.0"
	.byte 0, 0, 0
	.byte $80 ; XXX what mode is that?

	.byte "Berkeley Softworks"
	.byte 0
	;.res  (63 - 19) ; uncomment if we ignore junk below
	.res 21
	; ??? junk ???
	.byte $e1, $e1, $e1
	.byte $ff, $01, $ff, $01, $ff, $01, $ff, $01
	.byte $aa, $55, $aa, $55, $aa, $55, $aa, $55
	.byte $aa, $55, $aa, $55

	.byte "Allows varying disk configurations:  1541, 1571, 1581 & RAM disks supported."
	.byte 0
	; ??? junk ???
	.byte $00, $ff, $00, $ff, $00
	.byte $54, $84
	.byte $ff, $00, $ff, $00, $ff, $00, $00, $00, $ff, $00, $ff, $00

		.segment "RECORDS"

	.import __VLIR0_START__, __VLIR0_LAST__, __BSS_SIZE__
	.import __VLIR1_START__, __VLIR1_LAST__
	.import __VLIR2_START__, __VLIR2_LAST__
	.import __VLIR3_START__, __VLIR3_LAST__
	.import __VLIR4_START__, __VLIR4_LAST__
	.import __VLIR5_START__, __VLIR5_LAST__

	.byte .lobyte ((__VLIR0_LAST__ - __VLIR0_START__ - __BSS_SIZE__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR0_LAST__ - __VLIR0_START__ - __BSS_SIZE__ - 1) .MOD 254) + 2
	.byte .lobyte ((__VLIR1_LAST__ - __VLIR1_START__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR1_LAST__ - __VLIR1_START__ - 1) .MOD 254) + 2
	.byte .lobyte ((__VLIR2_LAST__ - __VLIR2_START__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR2_LAST__ - __VLIR2_START__ - 1) .MOD 254) + 2
	.byte .lobyte ((__VLIR3_LAST__ - __VLIR3_START__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR3_LAST__ - __VLIR3_START__ - 1) .MOD 254) + 2
	.byte .lobyte ((__VLIR4_LAST__ - __VLIR4_START__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR4_LAST__ - __VLIR4_START__ - 1) .MOD 254) + 2
	.byte .lobyte ((__VLIR5_LAST__ - __VLIR5_START__ - 1) /    254) + 1
	.byte .lobyte ((__VLIR5_LAST__ - __VLIR5_START__ - 1) .MOD 254) + 2

	.export __STACKSIZE__ : absolute = $0000

	.export __OVERLAYSIZE__ : absolute = $9000

