; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; C128: Jump table below I/O area

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import MoveDataCore
.import _ProcessDelays
.import GetInlineDrwParms
.import GrStSetCoords
.import _ProcessTimers
.import _IsMseInRegion
.import _CRC
.import _GetRandom
.import _BBMult
.import _BMult
.import _DMult
.import _Ddiv
.import _DSdiv

.global JumpTableBelowIO
.global J_IsMseInRegion
.global JMoveDataCore
.global J_CRC
.global J_GetRandom
.global J_BBMult
.global J_BMult
.global J_DMult
.global J_Ddiv
.global J_DSdiv
.global J_ProcessDelays
.global JGetInlineDrwParms
.global JGrStSetCoords
.global J_ProcessTimers

.segment "iojmptab"

; jump table for functions that live below the I/O area

JumpTableBelowIO:
J_IsMseInRegion:	jmp _IsMseInRegion
JMoveDataCore:		jmp MoveDataCore
J_CRC:			jmp _CRC
J_GetRandom:		jmp _GetRandom
J_BBMult:		jmp _BBMult
J_BMult:		jmp _BMult
J_DMult:		jmp _DMult
J_Ddiv:			jmp _Ddiv
J_DSdiv:		jmp _DSdiv
J_ProcessDelays:	jmp _ProcessDelays
JGetInlineDrwParms:	jmp GetInlineDrwParms
JGrStSetCoords:		jmp GrStSetCoords
J_ProcessTimers:	jmp _ProcessTimers
