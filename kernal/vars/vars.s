; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; KERNAL internal variables
; These are not part of the API and can be changed.

.include "config.inc"

.global menuOptNumber
.global menuTop
.global menuBottom

.global menuLeft
.global menuRight
.global menuStackL
.global menuStackH
.global menuOptionTab
.global menuLimitTabL
.global menuLimitTabH
.global TimersTab
.global TimersCMDs
.global TimersRtns
.global TimersVals
.global NumTimers
.global DelaySP
.global DelayValL
.global DelayValH
.global DelayRtnsL
.global DelayRtnsH
.global stringLen
.global stringMaxLen
.global tmpKeyVector
.global stringMargCtrl
.global GraphPenX
.global GraphPenXL
.global GraphPenXH
.global GraphPenY
.global KbdQueHead
.global KbdQueTail
.global KbdQueFlag
.global KbdQueue
.global KbdNextKey
.global KbdDBncTab
.global KbdDMltTab

.global PrvCharWidth
.global clkBoxTemp
.ifdef bsw128
.global L881A
.endif
.global clkBoxTemp2
.global alarmWarnFlag
.global tempIRQAcc
.global defIconTab
.global DeskAccPC
.global DeskAccSP
.global dlgBoxCallerPC
.global dlgBoxCallerSP
.global DBGFilesFound
.global DBGFOffsLeft
.global DBGFOffsTop
.global DBGFNameTable
.global DBGFTableIndex
.global DBGFileSelected
.global A885D
.global L8871
.global A885E
.global A885F
.global RecordDirTS
.global RecordDirOffs
.global RecordTableTS
.global verifyFlag
.global TempCurDrive
.global scr_mobx

.segment "vars"

menuOptNumber:  .byte 0
menuTop:        .byte 0
menuBottom:     .byte 0
menuLeft:       .word 0
menuRight:      .word 0
menuStackL:     .res 4, 0
menuStackH:     .res 4, 0
menuOptionTab:  .res 4, 0
menuLimitTabL:  .res 15, 0
menuLimitTabH:  .res 15, 0
TimersTab:      .res 40, 0
TimersCMDs:     .res 20, 0
TimersRtns:     .res 40, 0
TimersVals:     .res 40, 0
NumTimers:      .byte 0
DelaySP:        .byte 0
DelayValL:      .res 20, 0
DelayValH:      .res 20, 0
DelayRtnsL:     .res 20, 0
DelayRtnsH:     .res 20, 0
stringLen:      .byte 0
stringMaxLen:   .byte 0
tmpKeyVector:   .word 0
stringMargCtrl: .byte 0
GraphPenX:      .word 0
GraphPenY:      .byte 0
KbdQueHead:     .byte 0
KbdQueTail:     .byte 0
KbdQueFlag:     .byte 0
KbdQueue:       .res 16, 0
KbdNextKey:     .byte 0
.ifdef wheels ; used for something else; original contents moved
.global TmpFilename
TmpFilename:    .res 28, 0
.else
KbdDBncTab:     .res 8, 0
.ifdef bsw128
		.res 3, 0
.endif
KbdDMltTab:	.res 20, 0
.endif

.ifdef bsw128
		.res 3, 0
.endif
PrvCharWidth:	.byte 0
.ifdef bsw128
		.res 11, 0
.endif
clkBoxTemp:	.byte 0
.ifdef bsw128
L881A:		.byte 0
.endif
clkBoxTemp2:	.byte 0
alarmWarnFlag:	.byte 0
.ifdef bsw128
		.byte 0
.endif
tempIRQAcc:     .byte 0
defIconTab:	.res 68, 0

DeskAccPC:	.word 0
DeskAccSP:	.byte 0
dlgBoxCallerPC:	.word 0
dlgBoxCallerSP:	.byte 0
DBGFilesFound:	.byte 0
DBGFOffsLeft:	.byte 0
DBGFOffsTop:	.byte 0
DBGFNameTable:	.word 0
DBGFTableIndex:	.byte 0
DBGFileSelected: .byte 0
A885D:		.byte 0
.ifdef bsw128
L8871:		.byte 0
.endif
A885E:		.byte 0
A885F:		.byte 0
		.byte 0


RecordDirTS:	.word 0
RecordDirOffs:	.word 0
RecordTableTS:	.word 0
verifyFlag:	.byte 0
TempCurDrive:	.byte 0
scr_mobx:	.word 0


.ifdef wheels ; moved
		.res 5, 0
KbdDBncTab:     .res 8, 0
		.res 3, 0
KbdDMltTab:     .res 20, 0
.endif
