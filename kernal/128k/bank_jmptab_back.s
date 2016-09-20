; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Jump table to dispatch back bank functions

.include "config.inc"

.global _HorizontalLine, _InvertLine, _RecoverLine, _VerticalLine, _Rectangle, _FrameRectangle, _InvertRectangle, _RecoverRectangle, _DrawLine, _DrawPoint, _GetScanLine, _TestPoint, _BitmapUp, _UseSystemFont, _GetRealSize, _GetCharWidth, _LoadCharSet, _ImprintRectangle, _BitmapClip, _BitOtherClip, _InitTextPrompt, _PromptOn, _PromptOff, _BackBankFunc_23, FontPutChar, _TempHideMouse, _SetMsePic, _BldGDirEntry, _SetColorMode, _ColorCard, _ColorRectangle, _SwapDiskDriver, _MoveBData, _CopyCmdToBack, ToBASIC2, _SwapBData, _VerifyBData, _DoBOp, _AccessCache, _HideOnlyMouse

.segment "bank_jmptab_back"

	.assert * = $E000, error, "This code must be placed at $E000 in back RAM."

	jmp _HorizontalLine
	jmp _InvertLine
	jmp _RecoverLine
	jmp _VerticalLine
	jmp _Rectangle
	jmp _FrameRectangle
	jmp _InvertRectangle
	jmp _RecoverRectangle
	jmp _DrawLine
	jmp _DrawPoint
	jmp _GetScanLine
	jmp _TestPoint
	jmp _BitmapUp
	jmp _UseSystemFont
	jmp _GetRealSize
	jmp _GetCharWidth
	jmp _LoadCharSet
	jmp _ImprintRectangle
	jmp _BitmapClip
	jmp _BitOtherClip
	jmp _InitTextPrompt
	jmp _PromptOn
	jmp _PromptOff
	jmp _BackBankFunc_23
	jmp FontPutChar
	jmp _TempHideMouse
	jmp _SetMsePic
	jmp _BldGDirEntry
	jmp _SetColorMode
	jmp _ColorCard
	jmp _ColorRectangle
	jmp _SwapDiskDriver
	jmp _MoveBData
	jmp _CopyCmdToBack
	jmp ToBASIC2
	jmp _SwapBData
	jmp _VerifyBData
	jmp _DoBOp
	jmp _AccessCache
	jmp _HideOnlyMouse
