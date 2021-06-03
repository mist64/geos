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


;ProgStart
		jmp Init			;MOUSE_JMP
		jmp Exit			;SlowMouse
		jmp Update			;UpdateMouse

lastF		.byte 0				;last status of Fire
xlow		.byte 40			;less than this are 'left' 
xav		.byte 46			;middle POTX
xhigh		.byte 52			;higher than this are 'right'
xlostp		.byte 6				;step in middle-low X
xhstep		.byte 5				;step in middle-high X
ylow		.byte 44			;same as x but for POTY
yav		.byte 49
yhigh		.byte 54
ylstep		.byte 6
yhstep		.byte 6

Init		#LoadW mouseXPos, NULL		;init mouse=init position
		#LoadB mouseYPos, NULL
Exit		rts

;UpdateMouse is called by IRQ routine

Update		#bbrf MOUSEON_BIT, mouseOn, Exit
		#PushB CPU_DATA
		#LoadB CPU_DATA, $35		;turn on I/O
		#PushB cia1base+0		;preserve keyboard port
		#PushB cia1base+2
		#PushB cia1base+3
		#LoadB cia1base+2, $ff
		#LoadB cia1base+0, %01000000	;select paddle 1 (out of 4)

		ldx #$66
Here		nop				;delay for SID for loading
		nop				;POT capacitors
		nop
		dex
		bne Here

		#CmpB sidbase+$19, xlow		;read X register
		bmi XLO
		cmp xhigh
		bpl XHI
		jmp ReadY		

XLO		sta r0L				;proceed with left
		lda xav
		#sub r0L
		sta r0L
		#MoveB xlostp, r1L
		#LoadB r0H, NULL
		sta r1H

		ldx #r0L
		ldy #r1L
		jsr Ddiv

		#SubB r0L, mouseXPos
		lda mouseXPos+1
		beq Hi0
		sbc #0
		sta mouseXPos+1

yread		jmp ReadY
Hi0		bcs yread
		#LoadB mouseXPos, NULL
		jmp ReadY

XHI		#sub xav			;proceed with right
		sta r0L
		#MoveB xhstep, r1L
		#LoadB r0H, NULL
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		#AddB r0L, mouseXPos
		lda mouseXPos+1
		adc #0
		sta mouseXPos+1
		beq yread

		#CmpBI mouseXPos, (320-256)
		bmi yread
		#LoadB mouseXPos, (319-256)

ReadY		#CmpB sidbase+$1a, ylow		;read Y register
		bmi YLO
		cmp yhigh
		bpl YHI
		jmp ReadF

YLO		sta r0L				;proceed with up
		lda yav
		#sub r0L
		sta r0L
		#MoveB ylstep, r1L
		#LoadB r0H, NULL
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		lda mouseYPos
		#sub r0L
		bcc YZe
		sta mouseYPos
		jmp ReadF

YZe		#LoadB mouseYPos, NULL
		jmp ReadF

YHI		#sub yav			;proceed with down
		sta r0L
		#MoveB yhstep, r1L
		#LoadB r0H, NULL
		sta r1H
		ldx #r0L
		ldy #r1L
		jsr Ddiv

		lda mouseYPos
		#add r0L
		cmp #199
		bcs YMax
		sta mouseYPos
		jmp ReadF

YMax		#LoadB mouseYPos, 199

ReadF		#LoadB cia1base+2, NULL		;read fire status
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
Fire2		sta mouseData
		#smbf MOUSE_BIT, pressFlag

Finish		#PopB cia1base+3
		#PopB cia1base+2
		#PopB cia1base+0
		#PopB CPU_DATA
		rts

;ProgEnd
