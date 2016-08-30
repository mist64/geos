; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Main Loop

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"
.include "c64.inc"

; conio.s
.import ProcessCursor

; math.s
.import _GetRandom

; mouse.s
.import _DoCheckButtons
.import ProcessMouse

; process.s
.import _DoCheckDelays
.import _ExecuteProcesses
.import _ProcessDelays
.import _ProcessTimers

; time.s
.import _DoUpdateTime

; used by filesys.s, load.s
.global _MNLP

; syscall
.global _InterruptMain
.global _MainLoop

.segment "mainloop1"

_MainLoop:
.if wheels
LD011 = $D011
LFCBA = $FCBA
LCBDB = $CBDB
LCAFC = $CAFC
LFA27 = $FA27
LCF55 = $CF55

	bit     saverStatus                           ; C037 2C B4 88                 ,..
        bpl     LC052                           ; C03A 10 16                    ..
        bvs     LC052                           ; C03C 70 14                    p.
        bit     $84B4                           ; C03E 2C B4 84                 ,..
        bvs     LC052                           ; C041 70 0F                    p.
        sei                                     ; C043 78                       x
        lda     saverStatus                           ; C044 AD B4 88                 ...
        and     #$7F                            ; C047 29 7F                    ).
        ora     #$01                            ; C049 09 01                    ..
        sta     saverStatus                           ; C04B 8D B4 88                 ...
        jsr     LCF55                           ; C04E 20 55 CF                  U.
        cli                                     ; C051 58                       X
LC052:  jsr     LFA27                           ; C052 20 27 FA                  '.
        jsr     LCAFC                           ; C055 20 FC CA                  ..
LC058:  jsr     LCBDB                           ; C058 20 DB CB                  ..
        jsr     LFCBA                           ; C05B 20 BA FC                  ..
        lda     $849B                           ; C05E AD 9B 84                 ...
        ldx     $849C                           ; C061 AE 9C 84                 ...
LC064:  jsr     CallRoutine                     ; C064 20 D8 C1                  ..
        cli                                     ; C067 58                       X
        ldx     $01                             ; C068 A6 01                    ..
        lda     #$35                            ; C06A A9 35                    .5
        sta     $01                             ; C06C 85 01                    ..
        lda     LD011                           ; C06E AD 11 D0                 ...
        and     #$7F                            ; C071 29 7F                    ).
LC073:  sta     LD011                           ; C073 8D 11 D0                 ...
        stx $01                                 ; C076 86                       .
LC077:  jmp _MainLoop                         ; C077 01 4C                    .L
.else
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:
	jsr CallRoutine
	cli
	jmp _MainLoop2
.endif

.segment "mainloop2"

.if !wheels
_MainLoop2:
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	jmp _MainLoop
.endif

.segment "mainloop3"

;---------------------------------------------------------------
;---------------------------------------------------------------
_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom
