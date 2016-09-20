; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Loading

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _EnterDT_Str1
.import _EnterDT_Str0

.global _EnterDT_DB

.segment "load1b"

.ifndef wheels
_EnterDT_DB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word _EnterDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word _EnterDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL
.endif

.ifdef wheels_size
.global IncR0JmpInd
.global JmpR0Ind
.import IncR0
IncR0JmpInd:
	jsr IncR0
JmpR0Ind:
	jmp (r0)
.endif

