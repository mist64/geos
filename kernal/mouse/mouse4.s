; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse: DoCheckButtons syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import KbdScanHelp3

.import CallRoutine
.import DisablSprite
.import EnablSprite
.import PosSprite
.import TempHideMouse

.ifdef bsw128
L881A = $881A ; XXX wrong bank!
.endif

.global _DoCheckButtons
.global DoESC_RULER

.segment "mouse4"

_DoCheckButtons:
.ifdef bsw128
.import _BackBankFunc_23
	bbrf 7, L881A, @X
	jsr TempHideMouse
	LoadB r3L, 1
	MoveW stringX, r4
	MoveB stringY, r5
	jsr PosSprite
	jsr EnablSprite
	clv
@X:	bvc @Y
	jsr TempHideMouse
	LoadB r3L, 1
	jsr DisablSprite
@Y:	LoadB L881A, 0
	bbrf 7, graphMode, @Z
	jsr _BackBankFunc_23
@Z:
.endif
	bbrf INPUT_BIT, pressFlag, @1
	rmbf INPUT_BIT, pressFlag
	lda inputVector
	ldx inputVector+1
	jsr CallRoutine
@1:	bbrf MOUSE_BIT, pressFlag, @2
	rmbf MOUSE_BIT, pressFlag
	lda mouseVector
	ldx mouseVector+1
	jsr CallRoutine
@2:	bbrf KEYPRESS_BIT, pressFlag, @3
	jsr KbdScanHelp3
	lda keyVector
	ldx keyVector+1
	jsr CallRoutine
@3:	lda faultData
	beq DoESC_RULER
	lda mouseFaultVec
	ldx mouseFaultVec+1
	jsr CallRoutine
	lda #NULL
	sta faultData
DoESC_RULER:
	rts
