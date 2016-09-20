; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: inline syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import __GetInlineDrwParms
.import DoInlineReturn
.import _Rectangle
.import _RecoverRectangle
.import _ImprintRectangle
.import _FrameRectangle
.import _GraphicsString
.import _BitmapUp

.global _i_Rectangle
.global _i_RecoverRectangle
.global _i_ImprintRectangle
.global _i_FrameRectangle
.global _i_GraphicsString
.global _i_BitmapUp

.segment "graph2b"

;---------------------------------------------------------------
; i_Rectangle                                             $C19F
;
; Same as Rectangle with data after the jsr
;---------------------------------------------------------------
_i_Rectangle:
	jsr __GetInlineDrwParms
	jsr _Rectangle
.ifdef wheels_size
.global DoInlineReturn7
DoInlineReturn7:
.endif
	php
	lda #7
	jmp DoInlineReturn

.segment "graph2d"

;---------------------------------------------------------------
; i_RecoverRectangle                                      $C1A5
;
; Same as RecoverRectangle with data after the jsr
;---------------------------------------------------------------
_i_RecoverRectangle:
	jsr __GetInlineDrwParms
	jsr _RecoverRectangle
.ifdef wheels_size
	jmp DoInlineReturn7
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

.segment "graph2f"

;---------------------------------------------------------------
; i_ImprintRectangle                                      $C253
;
; Same as ImprintRectangle with data after the jsr
;---------------------------------------------------------------
_i_ImprintRectangle:
	jsr __GetInlineDrwParms
	jsr _ImprintRectangle
.ifdef wheels_size
	jmp DoInlineReturn7
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

.segment "graph2h"

;---------------------------------------------------------------
; i_FrameRectangle                                        $C1A2
;
; Same as FrameRectangle with data after the jsr
; with the pattern byte the last
;---------------------------------------------------------------
_i_FrameRectangle:
	jsr __GetInlineDrwParms
	iny
	lda (returnAddress),Y
	jsr _FrameRectangle
	php
	lda #8
	jmp DoInlineReturn

.segment "graph2j"

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

.segment "graph3b"

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
