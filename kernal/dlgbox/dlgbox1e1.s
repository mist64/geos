; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: default icon descriptors

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DBIcDISK
.import DBIcPicDISK
.import DBIcOPEN
.import DBIcPicOPEN
.import DBIcNO
.import DBIcPicNO
.import DBIcYES
.import DBIcPicYES
.import DBIcCANCEL
.import DBIcPicCANCEL
.import DBIcOK
.import DBIcPicOK

.global DBDefIconsTab

.ifdef wheels
.global DBDefIconsTabRoutine
.endif

.segment "dlgbox1e1"

.ifdef bsw128
MSB = DOUBLE_B
.else
MSB = 0
.endif

DBDefIconsTab:
	.word DBIcPicOK
	.word 0
	.byte MSB | 6, 16
DBDefIconsTabRoutine:
	.word DBIcOK

	.word DBIcPicCANCEL
	.word 0
	.byte MSB | 6, 16
	.word DBIcCANCEL

	.word DBIcPicYES
	.word 0
	.byte MSB | 6, 16
	.word DBIcYES

	.word DBIcPicNO
	.word 0
	.byte MSB | 6, 16
	.word DBIcNO

	.word DBIcPicOPEN
	.word 0
	.byte 6, 16
	.word DBIcOPEN

	.word DBIcPicDISK
	.word 0
	.byte 6, 16
	.word DBIcDISK

