
;GEOS system variables
;by Maciej 'YTM/Elysium' Witkowiak
;19-3-99

;addresses defined so-so
Z45		=	$45
Z46		=	$46
Z47		=	$47

z8b		=	$8b
z8c		=	$8c
z8d		=	$8d
z8e		=	$8e
z8f		=	$8f

;GEOS Kernal internal zpage vectors (not for use by apps)
IconDescVec	=	$3f
IconDescVecH	=	$40
CallRLo 	=	$41
CallRHi 	=	$42
DBoxDesc	=	$43
DBoxDescL	=	$43
DBoxDescH	=	$44

;Commodore Kernal equations
tapeBuffVec	=	$b2
curScrLine	=	$d1
curPos		=	$d3
kbdQuePos	=	$c6
kbdQue		=	$0277
BASICMemBot	=	$0282
BASICMemTop	=	$0284
scrAddyHi	=	$0288
PALNTSCFLAG	=	$02a6
BASICspace	=	$0800
BASIC_START	=	$a000
curScrLineColor =	$d8f0
KERNALVecTab	=	$fd30
KERNALCIAInit	=	$fda3
KERNALVICInit	=	$ff81

;GEOS Kernal internal vars (not for use by apps)
menuOptNumber	=	$86c0
menuTop 	=	$86c1
menuBottom	=	$86c2
menuLeft	=	$86c3
menuRight	=	$86c5
menuStackL	=	$86c7
menuStackH	=	$86cb
menuOptionTab	=	$86cf
menuLimitTabL	=	$86d3
menuLimitTabH	=	$86e2
TimersTab	=	$86f1
TimersCMDs	=	$8719
TimersRtns	=	$872d
TimersVals	=	$8755
NumTimers	=	$877d
DelaySP 	=	$877e
DelayValL	=	$877f
DelayValH	=	$8793
DelayRtnsL	=	$87a7
DelayRtnsH	=	$87bb
stringLen	=	$87cf
stringMaxLen	=	$87d0
tmpKeyVector	=	$87d1
stringMargCtrl	=	$87d3
GraphPenX	=	$87d4
GraphPenXL	=	$87d4
GraphPenXH	=	$87d5
GraphPenY	=	$87d6
KbdQueHead	=	$87d7
KbdQueTail	=	$87d8
KbdQueFlag	=	$87d9
KbdQueue	=	$87da
KbdNextKey	=	$87ea
KbdDBncTab	=	$87eb
KbdDMltTab	=	$87f3

PrvCharWidth	=	$8807
clkBoxTemp	=	$8808
clkBoxTemp2	=	$8809
alarmWarnFlag	=	$880a
tempIRQAcc	=	$880b
defIconTab	=	$880c

DeskAccPC	=	$8850
DeskAccSP	=	$8852
dlgBoxCallerPC	=	$8853
dlgBoxCallerSP	=	$8855
DBGFilesFound	=	$8856
DBGFOffsLeft	=	$8857
DBGFOffsTop	=	$8858
DBGFNameTable	=	$8859
DBGFTableIndex	=	$885b
DBGFileSelected =	$885c

RecordDirTS	=	$8861
RecordDirOffs	=	$8863
RecordTableTS	=	$8865
verifyFlag	=	$8867
TempCurDrive	=	$8868

;GEOS BOOT and REU reboot adresses
InitKernal	=	$5000
BVBuff		=	$0400
RunREU		=	$6000

;locations to be defined later
E87FC		=	$87fc
E87FD		=	$87fd
E87FE		=	$87fe
E87FF		=	$87ff
E8800		=	$8800
A885D		=	$885d
A885E		=	$885e
A885F		=	$885f
A8860		=	$8860
e88b7		=	$88b7	;4 bytes indexed by curDrive, 1571 disk type (SS/DS)
A8FE8		=	$8fe8
A8FF0		=	$8ff0

;RamExp stats block structure
DACC_ST_ADDR	=	$80	;deskAccessory load addy
DACC_LGH	=	$82	;deskAccessory lenght
DTOP_CHNUM	=	$83	;DeskTop # of chains
RAM_EXP_1STFREE	=	$84	;# of 1st free block
DTOP_CHAIN	=	$85	;# of DTop chains, (=6) up to $98

