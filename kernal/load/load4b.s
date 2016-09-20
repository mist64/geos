; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Loading: LdApplic syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import UNK_4
.import UNK_5
.import EnterDeskTop
.import StartAppl
.import GetFHdrInfo
.import A885E
.ifdef bsw128
.import CheckAppCompat
.import _LdFile2
.else
.import LdFile
.endif

.global _LdApplic

.segment "load4b"

_LdApplic:
.ifdef bsw128
	jsr UNK_5
	jsr GetFHdrInfo
	bnex @1
	jsr CheckAppCompat
	beq @2
@1:	rts
@2:	jsr _LdFile2
	bnex @3
	bbsf 0, A885E, @3
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
@3:	jmp EnterDeskTop
.else
	jsr UNK_5
	jsr LdFile
	bnex @1
	bbsf 0, A885E, @1
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
@1:	rts
.endif

