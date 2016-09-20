; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; C128: Wrappers for functions below I/O
;
; On the C128, these function implementations are located
; between $D000-$E000. Since I/O is turned on by default,
; these wrappers turn off I/O, call these functions, and
; restore the I/O configuration.


.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "iowrapper"

.import JumpTableBelowIO
.import J_IsMseInRegion
.import JMoveDataCore
.import J_CRC
.import J_GetRandom
.import J_BBMult
.import J_BMult
.import J_DMult
.import J_Ddiv
.import J_DSdiv
.import J_ProcessDelays
.import JGetInlineDrwParms
.import JGrStSetCoords
.import J_ProcessTimers

.global __ProcessDelays
.global __GetInlineDrwParms
.global __GrStSetCoords
.global __ProcessTimers
.global __IsMseInRegion
.global __CRC
.global __GetRandom
.global __DSdiv
.global __Ddiv
.global __DMult
.global __BMult
.global __BBMult
.global __MoveDataCore
.global CallAddr
.global RestoreConfig

__IsMseInRegion:
	lda #<(J_IsMseInRegion - JumpTableBelowIO)
	.byte $2c
__MoveDataCore:
	lda #<(JMoveDataCore - JumpTableBelowIO)
	.byte $2c
__CRC:
	lda #<(J_CRC - JumpTableBelowIO)
	.byte $2c
__GetRandom:
	lda #<(J_GetRandom - JumpTableBelowIO)
	.byte $2c
__BBMult:
	lda #<(J_BBMult - JumpTableBelowIO)
	.byte $2c
__BMult:
	lda #<(J_BMult - JumpTableBelowIO)
	.byte $2c
__DMult:
	lda #<(J_DMult - JumpTableBelowIO)
	.byte $2c
__Ddiv:
	lda #<(J_Ddiv - JumpTableBelowIO)
	.byte $2c
__DSdiv:
	lda #<(J_DSdiv - JumpTableBelowIO)
	.byte $2c
__ProcessDelays:
	lda #<(J_ProcessDelays - JumpTableBelowIO)
	.byte $2c
__GetInlineDrwParms:
	lda #<(JGetInlineDrwParms - JumpTableBelowIO)
	.byte $2c
__GrStSetCoords:
	lda #<(JGrStSetCoords - JumpTableBelowIO)
	.byte $2c
__ProcessTimers:
	lda #<(J_ProcessTimers - JumpTableBelowIO)
	sta CallAddr
	lda config
	sta RestoreConfig
	ora #1
	sta config
CallAddr = * + 1
	jsr $D003
	php
	pha
RestoreConfig = * + 1
	lda #$7f
	sta config
	pla
	plp
	rts
