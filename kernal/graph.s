; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; VIC-II graphics library

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; conio.s
.import _PutString

; bitmask.s
.import BitMaskPow2Rev
.import BitMaskLeadingSet
.import BitMaskLeadingClear

; patterns.s
.import PatternTab

; var.s
.import GraphPenX
.import GraphPenY

; used by filesys.s
.global ClrScr

; syscalls
.global _BitOtherClip
.global _BitmapClip
.global _BitmapUp
.global _DrawLine
.global _DrawPoint
.global _FrameRectangle
.global _GetScanLine
.global _GraphicsString
.global _HorizontalLine
.global _ImprintRectangle
.global _InvertLine
.global _InvertRectangle
.global _RecoverLine
.global _RecoverRectangle
.global _Rectangle
.global _SetPattern
.global _TestPoint
.global _VerticalLine
.global _i_BitmapUp
.global _i_FrameRectangle
.global _i_GraphicsString
.global _i_ImprintRectangle
.global _i_RecoverRectangle
.global _i_Rectangle

GraphPenXL = GraphPenX
GraphPenXH = GraphPenX+1

.segment "graph1"

.if !wheels
;---------------------------------------------------------------
; used by EnterDesktop
;---------------------------------------------------------------
ClrScr:
	LoadW r0, SCREEN_BASE
	LoadW r1, BACK_SCR_BASE
	ldx #$7D
ClrScr1:
	ldy #$3F
ClrScr2:
	lda #backPattern1
	sta (r0),Y
	sta (r1),Y
	dey
	lda #backPattern2
	sta (r0),Y
	sta (r1),Y
	dey
	bpl ClrScr2
	AddVW 64, r0
	AddVW 64, r1
	dex
	bne ClrScr1
	rts
.endif

.segment "graph2"

PrepareXCoord:
	ldx r11L
	jsr _GetScanLine
	lda r4L
	and #%00000111
	tax
	lda BitMaskLeadingClear,x
	sta r8H
	lda r3L
	and #%00000111
	tax
	lda BitMaskLeadingSet,x
	sta r8L
	lda r3L
	and #%11111000
	sta r3L
	lda r4L
	and #%11111000
	sta r4L
	rts

;---------------------------------------------------------------
; HorizontalLine                                          $C118
;
; Pass:      a    pattern byte
;            r11L y position in scanlines (0-199)
;            r3   x in pixel of left end (0-319)
;            r4   x in pixel of right end (0-319)
; Return:    r11L unchanged
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_HorizontalLine:
.if wheels
LC656 = $C656
LC325 = $C325
HLinEnd2 = $aaaa
HLinEnd1 = $aaaa

LC67C:  sta     $10                             ; C67C 85 10                    ..
        lda     #$00                            ; C67E A9 00                    ..
        .byte   $2C                             ; C680 2C                       ,
LC681:  lda     #$80                            ; C681 A9 80                    ..
        sta     LC325                           ; C683 8D 25 C3                 .%.
        lda     $09                             ; C686 A5 09                    ..
        pha                                     ; C688 48                       H
        lda     $08                             ; C689 A5 08                    ..
        pha                                     ; C68B 48                       H
        lda     $0B                             ; C68C A5 0B                    ..
        pha                                     ; C68E 48                       H
        lda     $0A                             ; C68F A5 0A                    ..
        pha                                     ; C691 48                       H
        jsr     LC656                           ; C692 20 56 C6                  V.
        ldy     $08                             ; C695 A4 08                    ..
        lda     $09                             ; C697 A5 09                    ..
        beq     LC69F                           ; C699 F0 04                    ..
        inc     $0D                             ; C69B E6 0D                    ..
        inc     $0F                             ; C69D E6 0F                    ..
LC69F:  lda     $09                             ; C69F A5 09                    ..
        cmp     $0B                             ; C6A1 C5 0B                    ..
        bne     LC6A9                           ; C6A3 D0 04                    ..
        lda     $08                             ; C6A5 A5 08                    ..
        cmp     $0A                             ; C6A7 C5 0A                    ..
LC6A9:  beq     LC6E3                           ; C6A9 F0 38                    .8
        jsr     LC7A3                           ; C6AB 20 A3 C7                  ..
        lda     $12                             ; C6AE A5 12                    ..
        bit     LC325                           ; C6B0 2C 25 C3                 ,%.
        bmi     LC6BB                           ; C6B3 30 06                    0.
        jsr     LC70C                           ; C6B5 20 0C C7                  ..
        clv                                     ; C6B8 B8                       .
        bvc     LC6BD                           ; C6B9 50 02                    P.
LC6BB:  eor     ($0C),y                         ; C6BB 51 0C                    Q.
LC6BD:  bit     LC325                           ; C6BD 2C 25 C3                 ,%.
        bpl     LC6C4                           ; C6C0 10 02                    ..
        eor     #$FF                            ; C6C2 49 FF                    I.
LC6C4:  sta     ($0E),y                         ; C6C4 91 0E                    ..
        sta     ($0C),y                         ; C6C6 91 0C                    ..
        tya                                     ; C6C8 98                       .
        clc                                     ; C6C9 18                       .
        adc     #$08                            ; C6CA 69 08                    i.
        tay                                     ; C6CC A8                       .
        bcc     LC6D3                           ; C6CD 90 04                    ..
        inc     $0D                             ; C6CF E6 0D                    ..
        inc     $0F                             ; C6D1 E6 0F                    ..
LC6D3:  dec     $0A                             ; C6D3 C6 0A                    ..
        beq     LC6EA                           ; C6D5 F0 13                    ..
        lda     $10                             ; C6D7 A5 10                    ..
        bit     LC325                           ; C6D9 2C 25 C3                 ,%.
        bpl     LC6BD                           ; C6DC 10 DF                    ..
        lda     ($0C),y                         ; C6DE B1 0C                    ..
        clv                                     ; C6E0 B8                       .
        bvc     LC6BD                           ; C6E1 50 DA                    P.
LC6E3:  lda     $12                             ; C6E3 A5 12                    ..
        ora     $13                             ; C6E5 05 13                    ..
        clv                                     ; C6E7 B8                       .
        bvc     LC6EC                           ; C6E8 50 02                    P.
LC6EA:  lda     $13                             ; C6EA A5 13                    ..
LC6EC:  bit     LC325                           ; C6EC 2C 25 C3                 ,%.
        bmi     LC6F7                           ; C6EF 30 06                    0.
        jsr     LC70C                           ; C6F1 20 0C C7                  ..
        jmp     LC6FB                           ; C6F4 4C FB C6                 L..

; ----------------------------------------------------------------------------
LC6F7:  eor     #$FF                            ; C6F7 49 FF                    I.
        eor     ($0C),y                         ; C6F9 51 0C                    Q.
LC6FB:  sta     ($0E),y                         ; C6FB 91 0E                    ..
        sta     ($0C),y                         ; C6FD 91 0C                    ..
LC6FF:  pla                                     ; C6FF 68                       h
        sta     $0A                             ; C700 85 0A                    ..
        pla                                     ; C702 68                       h
        sta     $0B                             ; C703 85 0B                    ..
        pla                                     ; C705 68                       h
        sta     $08                             ; C706 85 08                    ..
        pla                                     ; C708 68                       h
        sta     $09                             ; C709 85 09                    ..
        rts                                     ; C70B 60                       `

; ----------------------------------------------------------------------------
LC70C:  sta     $19                             ; C70C 85 19                    ..
        and     ($0E),y                         ; C70E 31 0E                    1.
        sta     $11                             ; C710 85 11                    ..
        lda     $19                             ; C712 A5 19                    ..
        eor     #$FF                            ; C714 49 FF                    I.
        and     $10                             ; C716 25 10                    %.
        ora     $11                             ; C718 05 11                    ..
        rts                                     ; C71A 60                       `

.else
	sta r7L
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr HLineHelp
@2:	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda r7L
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	jsr HLineHelp
HLinEnd1:
	sta (r6),Y
	sta (r5),Y
HLinEnd2:
	PopW r4
	PopW r3
	rts

HLineHelp:
	sta r11H
	and (r6),Y
	sta r7H
	lda r11H
	eor #$FF
	and r7L
	ora r7H
	rts
.endif
;---------------------------------------------------------------
; InvertLine                                              $C11B
;
; Pass:      r3   x pos of left endpoint (0-319)
;            r4   x pos of right endpoint (0-319)
;            r11L y pos (0-199)
; Return:    r3-r4 unchanged
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_InvertLine:
.if wheels
ImprintLine = $aaaa
.else
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	eor (r5),Y
@2:	eor #$FF
	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda (r5),Y
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	eor #$FF
	eor (r5),Y
	jmp HLinEnd1

:
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
	PopB dispBufferOn
	lda r5L
	ldy r6L
	sta r6L
	sty r5L
	lda r5H
	ldy r6H
	sta r6H
	sty r5H
	bra RLin0
.endif

;---------------------------------------------------------------
; RecoverLine                                             $C11E
;
; Pass:      r3   x pos of left endpoint (0-319)
;            r4   x pos of right endpoint (0-319)
;            r11L y pos of line (0-199)
; Return:    copies bits of line from background to
;            foreground sceen
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_RecoverLine:
.if wheels

LC71B:  lda     #$18                            ; C71B A9 18                    ..
        .byte   $2C                             ; C71D 2C                       ,
LC71E:  lda     #$38                            ; C71E A9 38                    .8
        sta     LC73C                           ; C720 8D 3C C7                 .<.
        lda     $09                             ; C723 A5 09                    ..
        pha                                     ; C725 48                       H
        lda     $08                             ; C726 A5 08                    ..
        pha                                     ; C728 48                       H
        lda     $0B                             ; C729 A5 0B                    ..
        pha                                     ; C72B 48                       H
        lda     $0A                             ; C72C A5 0A                    ..
        pha                                     ; C72E 48                       H
        lda     $2F                             ; C72F A5 2F                    ./
        pha                                     ; C731 48                       H
        ora     #$C0                            ; C732 09 C0                    ..
        sta     $2F                             ; C734 85 2F                    ./
        jsr     LC656                           ; C736 20 56 C6                  V.
        pla                                     ; C739 68                       h
        sta     $2F                             ; C73A 85 2F                    ./
LC73C:  clc                                     ; C73C 18                       .
        bcc     LC74F                           ; C73D 90 10                    ..
        lda     $0C                             ; C73F A5 0C                    ..
        ldy     $0E                             ; C741 A4 0E                    ..
        sta     $0E                             ; C743 85 0E                    ..
        sty     $0C                             ; C745 84 0C                    ..
        lda     $0D                             ; C747 A5 0D                    ..
        ldy     $0F                             ; C749 A4 0F                    ..
        sta     $0F                             ; C74B 85 0F                    ..
        sty     $0D                             ; C74D 84 0D                    ..
LC74F:  ldy     $08                             ; C74F A4 08                    ..
        lda     $09                             ; C751 A5 09                    ..
        beq     LC759                           ; C753 F0 04                    ..
        inc     $0D                             ; C755 E6 0D                    ..
        inc     $0F                             ; C757 E6 0F                    ..
LC759:  lda     $09                             ; C759 A5 09                    ..
        cmp     $0B                             ; C75B C5 0B                    ..
        bne     LC763                           ; C75D D0 04                    ..
        lda     $08                             ; C75F A5 08                    ..
        cmp     $0A                             ; C761 C5 0A                    ..
LC763:  beq     LC783                           ; C763 F0 1E                    ..
        jsr     LC7A3                           ; C765 20 A3 C7                  ..
        lda     $12                             ; C768 A5 12                    ..
        jsr     LC792                           ; C76A 20 92 C7                  ..
LC76D:  tya                                     ; C76D 98                       .
        clc                                     ; C76E 18                       .
        adc     #$08                            ; C76F 69 08                    i.
        tay                                     ; C771 A8                       .
        bcc     LC778                           ; C772 90 04                    ..
        inc     $0D                             ; C774 E6 0D                    ..
        inc     $0F                             ; C776 E6 0F                    ..
LC778:  dec     $0A                             ; C778 C6 0A                    ..
        beq     LC78A                           ; C77A F0 0E                    ..
        lda     ($0E),y                         ; C77C B1 0E                    ..
        sta     ($0C),y                         ; C77E 91 0C                    ..
        clv                                     ; C780 B8                       .
        bvc     LC76D                           ; C781 50 EA                    P.
LC783:  lda     $12                             ; C783 A5 12                    ..
        ora     $13                             ; C785 05 13                    ..
        clv                                     ; C787 B8                       .
        bvc     LC78C                           ; C788 50 02                    P.
LC78A:  lda     $13                             ; C78A A5 13                    ..
LC78C:  jsr     LC792                           ; C78C 20 92 C7                  ..
        jmp     LC6FF                           ; C78F 4C FF C6                 L..

; ----------------------------------------------------------------------------
LC792:  sta     $10                             ; C792 85 10                    ..
        and     ($0C),y                         ; C794 31 0C                    1.
        sta     $11                             ; C796 85 11                    ..
        lda     $10                             ; C798 A5 10                    ..
        eor     #$FF                            ; C79A 49 FF                    I.
        and     ($0E),y                         ; C79C 31 0E                    1.
        ora     $11                             ; C79E 05 11                    ..
        sta     ($0C),y                         ; C7A0 91 0C                    ..
        rts                                     ; C7A2 60                       `

; ----------------------------------------------------------------------------
LC7A3:  lda     $0A                             ; C7A3 A5 0A                    ..
        sec                                     ; C7A5 38                       8
        sbc     $08                             ; C7A6 E5 08                    ..
        sta     $0A                             ; C7A8 85 0A                    ..
        lda     $0B                             ; C7AA A5 0B                    ..
        sbc     $09                             ; C7AC E5 09                    ..
        sta     $0B                             ; C7AE 85 0B                    ..
        lsr     $0B                             ; C7B0 46 0B                    F.
        ror     $0A                             ; C7B2 66 0A                    f.
        lsr     $0A                             ; C7B4 46 0A                    F.
        lsr     $0A                             ; C7B6 46 0A                    F.
        rts                                     ; C7B8 60                       `
.else
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
	PopB dispBufferOn

RLin0:
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr RecLineHelp
@2:	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda (r6),Y
	sta (r5),Y
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	jsr RecLineHelp
	jmp HLinEnd2

RecLineHelp:
	sta r7L
	and (r5),Y
	sta r7H
	lda r7L
	eor #$FF
	and (r6),Y
	ora r7H
	sta (r5),Y
	rts
.endif

;---------------------------------------------------------------
; VerticalLine                                            $C121
;
; Pass:      a pattern
;            r3L top of line (0-199)
;            r3H bottom of line (0-199)
;            r4  x position of line (0-319)
; Return:    draw the line
; Destroyed: a, x, y, r4 - r8, r11
;---------------------------------------------------------------
_VerticalLine:
	sta r8L
	PushB r4L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	sta r7H
	lda r4L
	and #%11111000
	sta r4L
	ldy #0
	ldx r3L
@1:	stx r7L
	jsr _GetScanLine
	AddW r4, r5
	AddW r4, r6
	lda r7L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	and r8L
	bne @2
	lda r7H
	eor #$FF
	and (r6),Y
	bra @3
@2:	lda r7H
	ora (r6),Y
@3:	sta (r6),Y
	sta (r5),Y
	ldx r7L
	inx
	cpx r3H
	beq @1
	bcc @1
	PopB r4L
	rts

;---------------------------------------------------------------
; i_Rectangle                                             $C19F
;
; Same as Rectangle with data after the jsr
;---------------------------------------------------------------
_i_Rectangle:
	jsr GetInlineDrwParms
	jsr _Rectangle
	php
	lda #7
	jmp DoInlineReturn

;---------------------------------------------------------------
; Rectangle                                               $C124
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    draws the rectangle
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_Rectangle:
	MoveB r2L, r11L
@1:	lda r11L
	and #$07
	tay
	lda (curPattern),Y
	jsr _HorizontalLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

;---------------------------------------------------------------
; InvertRectangle                                         $C12A
;
; Pass:      r2L top in scanlines (0-199)
;            r2H bottom in scanlines (0-199)
;            r3  left in pixels (0-319)
;            r4  right in pixels (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_InvertRectangle:
	MoveB r2L, r11L
@1:	jsr $C681;xxx_InvertLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

;---------------------------------------------------------------
; i_RecoverRectangle                                      $C1A5
;
; Same as RecoverRectangle with data after the jsr
;---------------------------------------------------------------
_i_RecoverRectangle:
	jsr GetInlineDrwParms
	jsr _RecoverRectangle
.if wheels
	jmp $C81F
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

;---------------------------------------------------------------
; RecoverRectangle                                        $C12D
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    rectangle recovered from backscreen
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_RecoverRectangle:
	MoveB r2L, r11L
@1:	jsr _RecoverLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

;---------------------------------------------------------------
; i_ImprintRectangle                                      $C253
;
; Same as ImprintRectangle with data after the jsr
;---------------------------------------------------------------
_i_ImprintRectangle:
	jsr GetInlineDrwParms
	jsr _ImprintRectangle
.if wheels
	jmp $C81F
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

;---------------------------------------------------------------
; ImprintRectangle                                        $C250
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_ImprintRectangle:
	MoveB r2L, r11L
@1:	jsr LC71E;xxxImprintLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

;---------------------------------------------------------------
; i_FrameRectangle                                        $C1A2
;
; Same as FrameRectangle with data after the jsr
; with the pattern byte the last
;---------------------------------------------------------------
_i_FrameRectangle:
	jsr GetInlineDrwParms
	iny
	lda (returnAddress),Y
	jsr _FrameRectangle
	php
	lda #8
	jmp DoInlineReturn

;---------------------------------------------------------------
; FrameRectangle                                          $C127
;
; Pass:      a   GEOS pattern
;            r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r9, r11
;---------------------------------------------------------------
_FrameRectangle:
	sta r9H
	ldy r2L
	sty r11L
	jsr _HorizontalLine
	MoveB r2H, r11L
	lda r9H
	jsr _HorizontalLine
	PushW r3
	PushW r4
	MoveW r3, r4
	MoveW r2, r3
	lda r9H
	jsr _VerticalLine
	PopW r4
	lda r9H
	jsr _VerticalLine
	PopW r3
	rts

GetInlineDrwParms:
	PopW r5
	PopW returnAddress
.if wheels
        ldy     #$00                            ; C8DE A0 00                    ..
LC8E0:  iny                                     ; C8E0 C8                       .
        lda     ($3D),y                       ; C8E1 B1 3D                    .=
        sta     r1H,y                           ; C8E3 99 05 00                 ...
        cpy     #$06                            ; C8E6 C0 06                    ..
        bne     LC8E0                           ; C8E8 D0 F6                    ..
.else
	ldy #1
	lda (returnAddress),Y
	sta r2L
	iny
	lda (returnAddress),Y
	sta r2H
	iny
	lda (returnAddress),Y
	sta r3L
	iny
	lda (returnAddress),Y
	sta r3H
	iny
	lda (returnAddress),Y
	sta r4L
	iny
	lda (returnAddress),Y
	sta r4H
.endif
	PushW r5
	rts

;---------------------------------------------------------------
; i_GraphicsString                                        $C1A8
;
; Same as GraphicsString with data after the jsr
;---------------------------------------------------------------
_i_GraphicsString:
	PopB r0L
	pla
	inc r0L
	bne @1
	addv 1
@1:	sta r0H
	jsr _GraphicsString
	jmp (r0)

;---------------------------------------------------------------
; GraphicsString                                          $C136
;
; Pass:      r0 ptr to graphics string,0
;            MOVEPENTO     1  .word x, .byte  y
;            LINETO        2  .word x, .byte  y
;            RECTANGLETO   3  .word x, .byte  y
;            NEWPATTERN    5  .byte pattern No.
;            ESC_PUTSTRING 6  see PutString
;            FRAME_RECTO   7  .word x, .byte  y
;          New:
;            MOVEPENRIGHT  8  .word x
;            MOVEPENDOWN   9  .byte y
;            MOVERIGHTDOWN 10 .word x, .byte  y
; Return:    graphics being drawed
; Destroyed: a, x, y, r0 - r15
;---------------------------------------------------------------
_GraphicsString:
	jsr Getr0AndInc
.if wheels
	tay
	beq @1
.else
	beq @1
	tay
.endif
	dey
	lda GStrTL,Y
	ldx GStrTH,Y
	jsr CallRoutine
	bra _GraphicsString
@1:	rts

.define GStrT _DoMovePenTo, _DoLineTo, _DoRectangleTo, _DoNothing, _DoNewPattern, _DoESC_PutString, _DoFrame_RecTo, _DoPenXDelta, _DoPenYDelta, _DoPenXYDelta
GStrTL:
	.lobytes GStrT
GStrTH:
	.hibytes GStrT

_DoMovePenTo:
	jsr GetCoords
	sta GraphPenY
	stx GraphPenXL
	sty GraphPenXH
.if wheels
_DoNothing:
.endif
	rts

_DoLineTo:
	MoveW GraphPenX, r3
	MoveB GraphPenY, r11L
	jsr _DoMovePenTo
	sta r11H
	stx r4L
	sty r4H
	sec
	lda #0
	jmp _DrawLine

_DoRectangleTo:
	jsr GrStSetCoords
	jmp _Rectangle

.if !wheels
_DoNothing:
	rts
.endif

_DoNewPattern:
	jsr Getr0AndInc
	jmp _SetPattern

_DoESC_PutString:
	jsr Getr0AndInc
	sta r11L
	jsr Getr0AndInc
	sta r11H
	jsr Getr0AndInc
	sta r1H
.if wheels
	jmp _PutString
.else
	jsr _PutString
	rts
.endif

_DoFrame_RecTo:
	jsr GrStSetCoords
	lda #$FF
	jmp _FrameRectangle

_DoPenXYDelta:
	ldx #1
.if wheels
	.byte $2c
.else
	bne DPXD0
.endif
_DoPenXDelta:
	ldx #0
DPXD0:
	ldy #0
	lda (r0),Y
	iny
	add GraphPenXL
	sta GraphPenXL
	lda (r0),Y
	iny
	adc GraphPenXH
	sta GraphPenXH
	beqx DPYD1
	bne DPYD0
_DoPenYDelta:
	ldy #0
DPYD0:
	lda (r0),Y
	iny
	add GraphPenY
	sta GraphPenY
	iny
DPYD1:
	tya
	add r0L
	sta r0L
	bcc @1
	inc r0H
@1:	rts

GrStSetCoords:
	jsr GetCoords
	cmp GraphPenY
	bcs @1
	sta r2L
	pha
	lda GraphPenY
	sta r2H
	bra @2
@1:	sta r2H
	pha
	lda GraphPenY
	sta r2L
@2:	PopB GraphPenY
	cpy GraphPenXH
	beq @3
	bcs @5
@3:	bcc @4
	cpx GraphPenXL
	bcs @5
@4:	stx r3L
	sty r3H
	MoveW GraphPenX, r4
	bra @6
@5:	stx r4L
	sty r4H
	MoveW GraphPenX, r3
@6:	stx GraphPenXL
	sty GraphPenXH
	rts

;---------------------------------------------------------------
; SetPattern                                              $C139
;
; Pass:      a pattern nbr (0-33)
; Return:    currentPattern - updated
; Destroyed: a
;---------------------------------------------------------------
_SetPattern:
	asl
	asl
	asl
.if wheels
	.assert <PatternTab = 0, error, "PatternTab must be page-aligned!"
.else
	adc #<PatternTab
.endif
	sta curPattern
	lda #0
	adc #>PatternTab
	sta curPattern+1
	rts

GetCoords:
	jsr Getr0AndInc
	tax
	jsr Getr0AndInc
	sta r2L
	jsr Getr0AndInc
	ldy r2L
	rts ;x/y - x, a - y

Getr0AndInc:
	ldy #0
	lda (r0),Y
	inc r0L
	bne @1
	inc r0H
@1:
.if !wheels
	cmp #0
.endif
	rts

;---------------------------------------------------------------
; GetScanLine                                             $C13C
;
; Function:  Returns the address of the beginning of a scanline

; Pass:      x   scanline nbr
; Return:    r5  add of 1st byte of foreground scr
;            r6  add of 1st byte of background scr
; Destroyed: a
;---------------------------------------------------------------
_GetScanLine:
	txa
	pha
.if !wheels
	pha
.endif
	and #%00000111
	sta r6H
.if wheels
	txa
.else
	pla
.endif
	lsr
	lsr
	lsr
	tax
	bbrf 7, dispBufferOn, @2 ; ST_WR_FORE
	bbsf 6, dispBufferOn, @1 ; ST_WR_BACK
	lda LineTabL,x
	ora r6H
	sta r5L
.if wheels
	sta r6L                             ; CA47 85 0E                    ..
.endif
	lda LineTabH,x
	sta r5H
.if wheels
	sta r6H                             ; CA47 85 0E                    ..
.else
	MoveW r5, r6
.endif
	pla
	tax
	rts
@1:	lda LineTabL,x
	ora r6H
	sta r5L
	sta r6L
	lda $CAAB,x;xxxLineTabH,x
	sta r5H
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
	pla
	tax
	rts
@2:	bbrf 6, dispBufferOn, @3 ; ST_WR_BACK
	lda $CA92,x;xxxLineTabL,x
	ora r6H
	sta r6L
.if wheels
	sta r5L
.endif
	lda $CAAB,x;xxxLineTabH,x
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
.if wheels
	sta r5H
.else
	MoveW r6, r5
.endif
	pla
	tax
	rts
@3:	LoadB r5L, <$AF00
	sta r6L
	LoadB r5H, >$AF00
	sta r6H
	pla
	tax
	rts

.define LineTab SCREEN_BASE+0*320, SCREEN_BASE+1*320, SCREEN_BASE+2*320, SCREEN_BASE+3*320, SCREEN_BASE+4*320, SCREEN_BASE+5*320, SCREEN_BASE+6*320, SCREEN_BASE+7*320, SCREEN_BASE+8*320, SCREEN_BASE+9*320, SCREEN_BASE+10*320, SCREEN_BASE+11*320, SCREEN_BASE+12*320, SCREEN_BASE+13*320, SCREEN_BASE+14*320, SCREEN_BASE+15*320, SCREEN_BASE+16*320, SCREEN_BASE+17*320, SCREEN_BASE+18*320, SCREEN_BASE+19*320, SCREEN_BASE+20*320, SCREEN_BASE+21*320, SCREEN_BASE+22*320, SCREEN_BASE+23*320, SCREEN_BASE+24*320
LineTabL:
	.lobytes LineTab
LineTabH:
	.hibytes LineTab

.segment "graph3"

;---------------------------------------------------------------
; BitOtherClip                                            $C2C5
;
; Pass:      r0   ptr to a 134 bytes buffer
;            r1L  left side of window  in bytes (0-39)
;            r1H  top of window (0-199)
;            r2L  width in bytes of window (0-39)
;            r2H  height in pixels of window (0-199)
;            r11L nbr of bytes to skip from the left side before
;                 printing it
;            r11H the width in pixels of the bitmap to show
;                 within the window
;            r12  nbr of scanline to skip from the top
;            r13  add. of input routine, returns next byte from
;                 bitmap in the accumulator.
;            r14  address of sync routine. Just reload r0 with
;                 buffer address
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r14
;---------------------------------------------------------------
_BitOtherClip:
	ldx #$ff
.if wheels
	.byte $2c
.else
	jmp BitmClp1
.endif

;---------------------------------------------------------------
; BitmapClip                                              $C2AA
;
; Pass:      r0   pointer to bitmap
;            r1L  left side of window in bytes to display the
;                 bitmap (0-39)
;            r1H  top of window in pixels (0-199)
;            r2L  width of window in bytes (0-39)
;            r2H  height of window in pixels (0-39)
;            r11L nbr of bytes to skip from the left side before
;                 printing it
;            r11H the width in pixels of the bitmap to show
;                 within the window
;            r12  nbr of scanline to skip from the top
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r12
;---------------------------------------------------------------
_BitmapClip:
	ldx #0
BitmClp1:
	stx r9H
	lda #0
	sta r3L
	sta r4L
@1:	lda r12L
	ora r12H
	beq @3
	lda r11L
	jsr BitmHelpClp
	lda r2L
	jsr BitmHelpClp
	lda r11H
	jsr BitmHelpClp
	lda r12L
	bne @2
	dec r12H
@2:	dec r12L
	bra @1
@3:	lda r11L
	jsr BitmHelpClp
	jsr $E3D9;xxxBitmapUpHelp
	lda r11H
	jsr BitmHelpClp
	inc r1H
	dec r2H
	bne @3
	rts

BitmHelpClp:
	cmp #0
	beq @1
	pha
	jsr $E40B;xxxBitmapDecode
	pla
	subv 1
	bne BitmHelpClp
@1:	rts

;---------------------------------------------------------------
; i_BitmapUp                                              $C1AB
;
; Same as BitmapUp with data after the jsr
;---------------------------------------------------------------
_i_BitmapUp:
	PopW returnAddress
	ldy #1
	lda (returnAddress),y
	sta r0L
	iny
	lda (returnAddress),y
	sta r0H
	iny
	lda (returnAddress),y
	sta r1L
	iny
	lda (returnAddress),y
	sta r1H
	iny
	lda (returnAddress),y
	sta r2L
	iny
	lda (returnAddress),y
	sta r2H
	jsr _BitmapUp
	php
	lda #7
	jmp DoInlineReturn

;---------------------------------------------------------------
; BitmapUp                                                $C142
;
; Pass:      r0  ptr of bitmap
;            r1L x pos. in bytes (0-39)
;            r1H y pos. in scanlines (0-199)
;            r2L width in bytes (0-39)
;            r2H height in pixels (0-199)
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r9l
;---------------------------------------------------------------
_BitmapUp:
	PushB r9H
	LoadB r9H, NULL
.if !wheels
	lda #0
.endif
	sta r3L
	sta r4L
@1:	jsr BitmapUpHelp
	inc r1H
	dec r2H
	bne @1
	PopB r9H
	rts

BitmapUpHelp:
	ldx r1H
	jsr _GetScanLine
	MoveB r2L, r3H
	CmpBI r1L, $20
	bcc @1
	inc r5H
	inc r6H
@1:	asl
	asl
	asl
	tay
@2:	sty r9L
	jsr BitmapDecode
	ldy r9L
	sta (r5),y
	sta (r6),y
	tya
	addv 8
	bcc @3
	inc r5H
	inc r6H
@3:	tay
	dec r3H
	bne @2
	rts

BitmapDecode:
	lda r3L
	and #%01111111
	beq @2
	bbrf 7, r3L, @1
	jsr $E45F;xxxBitmapDecode2
	dec r3L
	rts
@1:	lda r7H
	dec r3L
	rts
@2:	lda r4L
	bne @3
	bbrf 7, r9H, @3
	jsr $E45C;xxxIndirectR14
@3:	jsr $E45F;xxxBitmapDecode2
	sta r3L
	cmp #$dc
	bcc @4
	sbc #$dc
	sta r7L
	sta r4H
	jsr $E45F;xxxBitmapDecode2
	subv 1
	sta r4L
	MoveW r0, r8
	bra @2
@4:	cmp #$80
	bcs BitmapDecode
	jsr $E45F;xxxBitmapDecode2
	sta r7H
	bra BitmapDecode

.if wheels
IndirectR13:
	jmp (r13)

IndirectR14:
	jmp (r14)
.endif

BitmapDecode2:
	bit r9H
	bpl @1
	jsr IndirectR13
@1:
	ldy #0
	lda (r0),y
	inc r0L
	bne @2
	inc r0H
@2:	ldx r4L
	beq @3
	dec r4H
	bne @3
	ldx r8H
	stx r0H
	ldx r8L
	stx r0L
	ldx r7L
	stx r4H
	dec r4L
@3:	rts

.if !wheels
IndirectR13:
	jmp (r13)

IndirectR14:
	jmp (r14)
.endif

.segment "graph4"

.if wheels
        .byte   $2E,$00,$0C,$00,$C0,$00,$C1,$84 ; E92B 2E 00 0C 00 C0 00 C1 84  ........
        .byte   $00,$C7,$00,$00,$3F,$01,$00,$9B ; E933 00 C7 00 00 3F 01 00 9B  ....?...
        .byte   $84,$1C,$00,$00,$7F,$C3,$00,$00 ; E93B 84 1C 00 00 7F C3 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; E943 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$F0,$CE ; E94B 00 00 00 00 00 00 F0 CE  ........
        .byte   $55,$C8,$0A,$00,$80,$00,$7D,$87 ; E953 55 C8 0A 00 80 00 7D 87  U.....}.
        .byte   $02,$00,$00,$08,$88,$01,$00,$40 ; E95B 02 00 00 08 88 01 00 40  .......@
        .byte   $00,$01,$00,$A7,$88,$01,$05,$F8 ; E963 00 01 00 A7 88 01 05 F8  ........
        .byte   $8F,$08,$28,$29,$2A,$2B,$2C,$2D ; E96B 8F 08 28 29 2A 2B 2C 2D  ..()*+,-
        .byte   $2E,$2F,$00,$00                 ; E973 2E 2F 00 00              ./..
.endif

;---------------------------------------------------------------
; DrawLine                                                $C130
;
; Pass:      signFlg  set to recover from back screen
;                     reset for drawing
;            carryFlg set for drawing in forground color
;                     reset for background color
;            r3       x pos of 1st point (0-319)
;            r11L     y pos of 1st point (0-199)
;            r4       x pos of 2nd point (0-319)
;            r11H     y pos of 2nd point (0-199)
; Return:    line is drawn or recover
; Destroyed: a, x, y, r4 - r8, r11
;---------------------------------------------------------------
_DrawLine:
	php
	LoadB r7H, 0
	lda r11H
	sub r11L
	sta r7L
	bcs @1
	lda #0
	sub r7L
	sta r7L
@1:	lda r4L
	sub r3L
	sta r12L
	lda r4H
	sbc r3H
	sta r12H
	ldx #r12
	jsr Dabs
	CmpW r12, r7
	bcs @2
	jmp @9
@2:	lda r7L
	asl
	sta r9L
	lda r7H
	rol
	sta r9H
	lda r9L
	sub r12L
	sta r8L
	lda r9H
	sbc r12H
	sta r8H
	lda r7L
	sub r12L
	sta r10L
	lda r7H
	sbc r12H
	sta r10H
	asl r10L
	rol r10H
	LoadB r13L, $ff
	CmpW r3, r4
	bcc @4
	CmpB r11L, r11H
	bcc @3
	LoadB r13L, $01
@3:	ldy r3H
	ldx r3L
	MoveW r4, r3
	sty r4H
	stx r4L
	MoveB r11H, r11L
	bra @5
@4:	ldy r11H
	cpy r11L
	bcc @5
	LoadB r13L, 1
@5:	plp
	php
	jsr _DrawPoint
	CmpW r3, r4
	bcs @8
	inc r3L
	bne @6
	inc r3H
@6:	bbrf 7, r8H, @7
	AddW r9, r8
	bra @5
@7:	AddB_ r13L, r11L
	AddW r10, r8
	bra @5
@8:
	plp
	rts

@9:	lda r12L
	asl
	sta r9L
	lda r12H
	rol
	sta r9H
	lda r9L
	sub r7L
	sta r8L
	lda r9H
	sbc r7H
	sta r8H
	lda r12L
	sub r7L
	sta r10L
	lda r12H
	sbc r7H
	sta r10H
	asl r10L
	rol r10H
	LoadW r13, $ffff
	CmpB r11L, r11H
	bcc @B
	CmpW r3, r4
	bcc @A
	LoadW r13, $0001
@A:	MoveW r4, r3
	ldx r11L
	lda r11H
	sta r11L
	stx r11H
	bra @C
@B:	CmpW r3, r4
	bcs @C
	LoadW r13, $0001
@C:	plp
	php
	jsr _DrawPoint
	CmpB r11L, r11H
	bcs @E
	inc r11L
	bbrf 7, r8H, @D
	AddW r9, r8
	bra @C
@D:	AddW r13, r3
	AddW r10, r8
	bra @C
@E:	plp
	rts

;---------------------------------------------------------------
; DrawPoint                                               $C133
;
; Pass:      same as DrawLine with no 2nd point
; Return:    point is drawn or recovered
; Destroyed: a, x, y, r5 - r6
;---------------------------------------------------------------
_DrawPoint:
	php
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	lda r3L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	plp
	bmi @4
	bcc @2
	ora (r6),y
	bra @3
@2:	eor #$ff
	and (r6),y
@3:	sta (r6),y
	sta (r5),y
	rts
@4:	pha
	eor #$ff
	and (r5),y
	sta (r5),y
	pla
	and (r6),y
	ora (r5),y
	sta (r5),y
	rts

;---------------------------------------------------------------
; TestPoint                                               $C13F
;
; Pass:      a    pattern
;            r3   x position of pixel (0-319)
;            r11L y position of pixel (0-199)
; Return:    carry set if bit is set
; Destroyed: a, x, y, r5, r6
;---------------------------------------------------------------
_TestPoint:
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq @1
	inc r6H
@1:	lda r3L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	and (r6),y
	beq @2
	sec
	rts
@2:	clc
	rts
