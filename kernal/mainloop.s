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

;---------------------------------------------------------------
;---------------------------------------------------------------
_MainLoop:
.if wheels
LD41A = $D41A
LD419 = $D419
LDC0D = $DC0D
LDC04 = $DC04
L9FEE = $9FEE
LDC05 = $DC05
L9FEF = $9FEF
LDC0E = $DC0E
LDC02 = $DC02
LDC00 = $DC00
LD011 = $D011
LFCBA = $FCBA
LCBDB = $CBDB
LCAFC = $CAFC
LFA27 = $FA27
LCF55 = $CF55

_MNLP = $aaaa

; ----------------------------------------------------------------------------
LC037:  bit     $88B4                           ; C037 2C B4 88                 ,..
        bpl     LC052                           ; C03A 10 16                    ..
        bvs     LC052                           ; C03C 70 14                    p.
        bit     $84B4                           ; C03E 2C B4 84                 ,..
        bvs     LC052                           ; C041 70 0F                    p.
        sei                                     ; C043 78                       x
        lda     $88B4                           ; C044 AD B4 88                 ...
        and     #$7F                            ; C047 29 7F                    ).
        ora     #$01                            ; C049 09 01                    ..
        sta     $88B4                           ; C04B 8D B4 88                 ...
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
        .byte   $86                             ; C076 86                       .
LC077:  ora     ($4C,x)                         ; C077 01 4C                    .L
        .byte   $37                             ; C079 37                       7
        cpy     #$1E                            ; C07A C0 1E                    ..
        bmi     LC058+2                        ; C07C 30 DC                    0.
        inc     $8484                           ; C07E EE 84 84                 ...
        dey                                     ; C081 88                       .
        dey                                     ; C082 88                       .
LC083:  php                                     ; C083 08                       .
        sei                                     ; C084 78                       x
        lsr     a                               ; C085 4A                       J
        ror     a                               ; C086 6A                       j
        ror     a                               ; C087 6A                       j
        sta     LDC00                           ; C088 8D 00 DC                 ...
        lda     LDC02                           ; C08B AD 02 DC                 ...
        pha                                     ; C08E 48                       H
        lda     #$C0                            ; C08F A9 C0                    ..
        sta     LDC02                           ; C091 8D 02 DC                 ...
        lda     LDC0E                           ; C094 AD 0E DC                 ...
        and     #$FE                            ; C097 29 FE                    ).
        sta     LDC0E                           ; C099 8D 0E DC                 ...
        lda     L9FEF                           ; C09C AD EF 9F                 ...
        sta     LDC05                           ; C09F 8D 05 DC                 ...
        lda     L9FEE                           ; C0A2 AD EE 9F                 ...
        sta     LDC04                           ; C0A5 8D 04 DC                 ...
        lda     #$7F                            ; C0A8 A9 7F                    ..
        sta     LDC0D                           ; C0AA 8D 0D DC                 ...
        lda     LDC0D                           ; C0AD AD 0D DC                 ...
        lda     LDC0E                           ; C0B0 AD 0E DC                 ...
        and     #$40                            ; C0B3 29 40                    )@
        ora     #$19                            ; C0B5 09 19                    ..
        sta     LDC0E                           ; C0B7 8D 0E DC                 ...
        lda     #$01                            ; C0BA A9 01                    ..
LC0BC:  bit     LDC0D                           ; C0BC 2C 0D DC                 ,..
        beq     LC0BC                           ; C0BF F0 FB                    ..
        ldx     LD419                           ; C0C1 AE 19 D4                 ...
        ldy     LD41A                           ; C0C4 AC 1A D4                 ...
        pla                                     ; C0C7 68                       h
        sta     LDC02                           ; C0C8 8D 02 DC                 ...
        plp                                     ; C0CB 28                       (
        rts                                     ; C0CC 60                       `

; ----------------------------------------------------------------------------
LC0CD:  lda     $06                             ; C0CD A5 06                    ..
        lsr     a                               ; C0CF 4A                       J
        lsr     a                               ; C0D0 4A                       J
        lsr     a                               ; C0D1 4A                       J
        sta     $05                             ; C0D2 85 05                    ..
        sec                                     ; C0D4 38                       8
        lda     $07                             ; C0D5 A5 07                    ..
        sbc     $06                             ; C0D7 E5 06                    ..
        lsr     a                               ; C0D9 4A                       J
        lsr     a                               ; C0DA 4A                       J
        lsr     a                               ; C0DB 4A                       J
        sta     $07                             ; C0DC 85 07                    ..
        inc     $07                             ; C0DE E6 07                    ..
        lda     $09                             ; C0E0 A5 09                    ..
        lsr     a                               ; C0E2 4A                       J
        lda     $08                             ; C0E3 A5 08                    ..
        ror     a                               ; C0E5 6A                       j
        lsr     a                               ; C0E6 4A                       J
        lsr     a                               ; C0E7 4A                       J
        sta     $04                             ; C0E8 85 04                    ..
        sec                                     ; C0EA 38                       8
        lda     $0A                             ; C0EB A5 0A                    ..
        sbc     $08                             ; C0ED E5 08                    ..
        pha                                     ; C0EF 48                       H
        lda     $0B                             ; C0F0 A5 0B                    ..
        sbc     $09                             ; C0F2 E5 09                    ..
        lsr     a                               ; C0F4 4A                       J
        pla                                     ; C0F5 68                       h
        ror     a                               ; C0F6 6A                       j
        lsr     a                               ; C0F7 4A                       J
        lsr     a                               ; C0F8 4A                       J
        sta     $06                             ; C0F9 85 06                    ..
        inc     $06                             ; C0FB E6 06                    ..
        rts                                     ; C0FD 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; C0FE 00                       .
        brk                                     ; C0FF 00                       .
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

.segment "mainloop3"

;---------------------------------------------------------------
;---------------------------------------------------------------
_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom

