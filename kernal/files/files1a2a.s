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

.global Add2
.global Add2_return

.segment "files1a2a"

Add2:
.ifdef wheels_size_and_speed ; optimized
	clc
        lda     #2
        adc     r6L
        sta     r6L
        bcc     @1
        inc     r6H
@1:	rts
.else
	AddVW 2, r6
Add2_return:
	rts
.endif

