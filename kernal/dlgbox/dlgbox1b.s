; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: function pointer table

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DBDoUSR_ROUT
.import DBDoUSRICON
.import DBDoOPVEC
.import DBDoGETFILES
.import DBDoGRPHSTR
.import DBDoSYSOPV
.import DBDoGETSTR
.import DBDoVARSTR
.import DBDoTXTSTR
.import DBDoIcons
.ifdef wheels
.import DoESC_RULER
.endif

.global DlgBoxProcH
.global DlgBoxProcL

.segment "dlgbox1b"

.define DlgBoxProc1 DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons
.ifdef wheels_fixes ; fix: have commands 7-10 (undefined) point to RTS
.define DlgBoxProc2 DoESC_RULER, DoESC_RULER, DoESC_RULER, DoESC_RULER
.else
.define DlgBoxProc2 DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons
.endif
.define DlgBoxProc3 DBDoTXTSTR, DBDoVARSTR, DBDoGETSTR, DBDoSYSOPV, DBDoGRPHSTR, DBDoGETFILES, DBDoOPVEC, DBDoUSRICON, DBDoUSR_ROUT

DlgBoxProcL:
	.lobytes DlgBoxProc1
	.lobytes DlgBoxProc2 ; not used
	.lobytes DlgBoxProc3
DlgBoxProcH:
	.hibytes DlgBoxProc1
.ifdef wheels_fixes ; fix: correct pointers
	.hibytes DlgBoxProc2
.else
	.lobytes DlgBoxProc2 ; yes, lobytes!! -- not used
.endif
	.hibytes DlgBoxProc3

.ifdef bsw128
	.word $FEEF ; ???
.endif
