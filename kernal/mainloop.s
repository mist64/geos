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

.if !wheels
_MainLoop:
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

.if wheels
LC4DA = $c4da
LC4C2 = $c4c2
LC325 = $c325

LC38E:  lda     #$00                            ; C38E A9 00                    ..
        .byte   $2C                             ; C390 2C                       ,
LC391:  lda     #$80                            ; C391 A9 80                    ..
        sta     LC325                           ; C393 8D 25 C3                 .%.
        jsr     LC4C2                           ; C396 20 C2 C4                  ..
        lda     $03                             ; C399 A5 03                    ..
        sta     $0F                             ; C39B 85 0F                    ..
        lda     r0                              ; C39D A5 02                    ..
        sta     $0E                             ; C39F 85 0E                    ..
        ldx     $07                             ; C3A1 A6 07                    ..
LC3A3:  ldy     #$00                            ; C3A3 A0 00                    ..
LC3A5:  bit     LC325                           ; C3A5 2C 25 C3                 ,%.
        bpl     LC3B1                           ; C3A8 10 07                    ..
        lda     ($0C),y                         ; C3AA B1 0C                    ..
        sta     ($0E),y                         ; C3AC 91 0E                    ..
        clv                                     ; C3AE B8                       .
        bvc     LC3B5                           ; C3AF 50 04                    P.
LC3B1:  lda     ($0E),y                         ; C3B1 B1 0E                    ..
        sta     ($0C),y                         ; C3B3 91 0C                    ..
LC3B5:  iny                                     ; C3B5 C8                       .
        cpy     $06                             ; C3B6 C4 06                    ..
        bcc     LC3A5                           ; C3B8 90 EB                    ..
        tya                                     ; C3BA 98                       .
        clc                                     ; C3BB 18                       .
        adc     $0E                             ; C3BC 65 0E                    e.
        sta     $0E                             ; C3BE 85 0E                    ..
        bcc     LC3C4                           ; C3C0 90 02                    ..
        inc     $0F                             ; C3C2 E6 0F                    ..
LC3C4:  jsr     LC4DA                           ; C3C4 20 DA C4                  ..
        dex                                     ; C3C7 CA                       .
        bne     LC3A3                           ; C3C8 D0 D9                    ..
        rts                                     ; C3CA 60                       `

        .byte   $00,$00,$00,$00                 ; C3CB 00 00 00 00              ....
.endif
