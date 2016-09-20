; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Memory utility functions: i_FillRam

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _FillRam
.import GetMDataDatas

.import DoInlineReturn

.global _i_FillRam

.segment "memory3"

;---------------------------------------------------------------
; i_FillRam                                               $C1B4
;
; Same as FillRam with data after the jsr
;---------------------------------------------------------------
_i_FillRam:
	PopW returnAddress
	jsr GetMDataDatas
	jsr _FillRam
	php
	lda #6
	jmp DoInlineReturn
