; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; C64: Aliases for utility functions
;
; The C128 version calls some functions indirectly,
; so for the C64, we alias the symbols.

.import _ProcessDelays
.import GetInlineDrwParms
.import GrStSetCoords
.import _ProcessTimers
.import _IsMseInRegion
.import _CRC
.import _GetRandom
.import _DSdiv
.import _Ddiv
.import _DMult
.import _BMult
.import _BBMult

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

__ProcessDelays = _ProcessDelays
__GetInlineDrwParms = GetInlineDrwParms
__GrStSetCoords = GrStSetCoords
__ProcessTimers = _ProcessTimers
__IsMseInRegion = _IsMseInRegion
__CRC = _CRC
__GetRandom = _GetRandom
__DSdiv = _DSdiv
__Ddiv = _Ddiv
__DMult = _DMult
__BMult = _BMult
__BBMult = _BBMult
