; pcanalog input driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "jumptab.inc"
.include "c64.inc"

.segment "inputdrv"

; Analog PC joystick input driver by Maciej Witkowiak

; original comment header - 1999-06-23
;
;Input driver for analogue PC joystick connected to C64/128 Control Port #1
;as paddles
;it could be fairly optimized, I must have been blind when I
;coded this :)
;screen ranges checking are unnecessary - Kernal does it

;this code is for GEOS 64 v2.0

;Maciej 'YTM/Alliance' Witkowiak
;back in '97
;rewritten for GNU, TASM version with macros
;I hope that it still works
;23.6.99

; end of original comment header
;
; adapted for cc65 on 2021-06-03 by Maciej Witkowiak


MouseInit:
		jmp Init			;MOUSE_JMP
SlowMouse:
		jmp Exit			;SlowMouse
UpdateMouse:
		jmp Update			;UpdateMouse

.ifdef bsw128
SetMouse:
		jmp Exit
		jmp Exit			; ??? why it's here?
.endif

lastF:		.byte 0				;last status of Fire

; calibration values
; [xlow,xav] and [xav,xhigh] are ignored, this is center joystick jitter
xlow:		.byte $2d			;less than this are 'left' 
xav:		.byte $33			;middle POTX
xhigh:		.byte $39			;higher than this are 'right'
xlostp:		.byte $07				;step in middle-low X
xhstep:		.byte $05				;step in middle-high X
ylow:		.byte $39			;same as x but for POTY
yav:		.byte $3e
yhigh:		.byte $43
ylstep:		.byte $08
yhstep:		.byte $04

Init:		LoadW mouseXPos, 0		;init mouse=init position
		sta mouseYPos
Exit:		rts

;UpdateMouse is called by IRQ routine

Update:		bbrf MOUSEON_BIT, mouseOn, Exit
		START_IO
		PushB cia1base+0		;preserve keyboard port
		PushB cia1base+2
		PushB cia1base+3
		LoadB cia1base+2, $ff
		LoadB cia1base+0, %01000000	;select paddle 1 (out of 4)

		ldx #$66
:		nop				;delay for SID for loading
		nop				;POT capacitors
		nop
		dex
		bne :-

		CmpB sidbase+$19, xlow		;read X register
		bmi XLO
		cmp xhigh
		bpl XHI
		jmp ReadY		

XLO:		sta r0L				;proceed with left
		lda xav
		sub r0L
		sta r0L
		MoveB xlostp, r1L
		LoadB r0H, 0
		sta r1H

		ldx #r0L
		ldy #r1L
		jsr Ddiv

		SubB r0L, mouseXPos
		lda mouseXPos+1
		beq Hi0
		sbc #0
		sta mouseXPos+1

yread:		jmp ReadY
Hi0:		bcs yread
		LoadB mouseXPos, 0
		jmp ReadY

XHI:		sub xav			;proceed with right
		sta r0L
		lda xhstep
.ifdef bsw128
		bbrf 7, graphMode, XHok	;check 40/80 mode
		lsr
XHok:
.endif
		sta r1L
		LoadB r0H, 0
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		AddB r0L, mouseXPos
		lda mouseXPos+1
		adc #0
		sta mouseXPos+1
		beq yread
.ifndef bsw128
		CmpBI mouseXPos, (320-256)
		bmi yread
		LoadB mouseXPos, (319-256)
.endif

ReadY:		CmpB sidbase+$1a, ylow		;read Y register
		bmi YLO
		cmp yhigh
		bpl YHI
		jmp ReadF

YLO:		sta r0L				;proceed with up
		lda yav
		sub r0L
		sta r0L
		MoveB ylstep, r1L
		LoadB r0H, 0
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		lda mouseYPos
		sub r0L
		bcc YZe
		sta mouseYPos
		jmp ReadF

YZe:		LoadB mouseYPos, 0
		jmp ReadF

YHI:		sub yav			;proceed with down
		sta r0L
		MoveB yhstep, r1L
		LoadB r0H, 0
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		lda mouseYPos
		add r0L
.ifdef bsw128
		sta mouseYPos
.else
		cmp #199
		bcs YMax
		sta mouseYPos
		jmp ReadF

YMax:		LoadB mouseYPos, 199
.endif

ReadF:		LoadB cia1base+2, 0		;read fire status
		sta cia1base+3
		lda cia1base+1
		and #%00001100			;read both fire buttons
		cmp lastF
		beq Finish
		sta lastF
		asl a
		asl a
		asl a
		asl a
		bpl Fire2
		asl a
Fire2:		sta mouseData
		smbf MOUSE_BIT, pressFlag

Finish:		PopB cia1base+3
		PopB cia1base+2
		PopB cia1base+0
		END_IO
		rts

