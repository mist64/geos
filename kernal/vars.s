.segment "vars"


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
.global RecordDirTS
.global RecordDirOffs
.global RecordTableTS
.global verifyFlag
.global TempCurDrive

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
GraphPenXL      =       GraphPenX
GraphPenXH      =       GraphPenX+1
GraphPenY:      .byte 0
KbdQueHead:     .byte 0
KbdQueTail:     .byte 0
KbdQueFlag:     .byte 0
KbdQueue:       .res 16, 0
KbdNextKey:     .byte 0
KbdDBncTab:     .res 8, 0
KbdDMltTab:     .res 20, 0

PrvCharWidth:   .byte 0
clkBoxTemp:     .byte 0
clkBoxTemp2:    .byte 0
alarmWarnFlag:  .byte 0
tempIRQAcc:     .byte 0
defIconTab:     .res 68, 0

DeskAccPC:      .word 0
DeskAccSP:      .byte 0
dlgBoxCallerPC: .word 0
dlgBoxCallerSP: .byte 0
DBGFilesFound:  .byte 0
DBGFOffsLeft:   .byte 0
DBGFOffsTop:    .byte 0
DBGFNameTable:  .word 0
DBGFTableIndex: .byte 0
DBGFileSelected: .res 5, 0

RecordDirTS:    .word 0
RecordDirOffs:  .word 0
RecordTableTS:  .word 0
verifyFlag:     .byte 0
TempCurDrive:   .res 83, 0
