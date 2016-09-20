; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Jump table for front-to-back bank calls
;
; Jump table to call back bank functions from the front bank
; There is a jump table at the same location at the back bank.

.include "config.inc"

.import CallBackBank

.global _HorizontalLine, _InvertLine, _RecoverLine, _VerticalLine, _Rectangle, _FrameRectangle, _InvertRectangle, _RecoverRectangle, _DrawLine, _DrawPoint, _GetScanLine, _TestPoint, _BitmapUp, _UseSystemFont, _GetRealSize, _GetCharWidth, _LoadCharSet, _ImprintRectangle, _BitmapClip, _BitOtherClip, _InitTextPrompt, _PromptOn, _PromptOff, _BackBankFunc_23, FontPutChar, _TempHideMouse, _SetMsePic, _BldGDirEntry, _SetColorMode, _ColorCard, _ColorRectangle, _SwapDiskDriver, _MoveBData, _CopyCmdToBack, ToBASIC2, _SwapBData, _VerifyBData, _DoBOp, _AccessCache, _HideOnlyMouse

.segment "bank_jmptab_front"

	.assert * = $E000, error, "This code must be placed at $E000 in front RAM."

_HorizontalLine:	jsr CallBackBank
_InvertLine:		jsr CallBackBank
_RecoverLine:		jsr CallBackBank
_VerticalLine:		jsr CallBackBank
_Rectangle:		jsr CallBackBank
_FrameRectangle:	jsr CallBackBank
_InvertRectangle:	jsr CallBackBank
_RecoverRectangle:	jsr CallBackBank
_DrawLine:		jsr CallBackBank
_DrawPoint:		jsr CallBackBank
_GetScanLine:		jsr CallBackBank
_TestPoint:		jsr CallBackBank
_BitmapUp:		jsr CallBackBank
_UseSystemFont:		jsr CallBackBank
_GetRealSize:		jsr CallBackBank
_GetCharWidth:		jsr CallBackBank
_LoadCharSet:		jsr CallBackBank
_ImprintRectangle:	jsr CallBackBank
_BitmapClip:		jsr CallBackBank
_BitOtherClip:		jsr CallBackBank
_InitTextPrompt:	jsr CallBackBank
_PromptOn:		jsr CallBackBank
_PromptOff:		jsr CallBackBank
_BackBankFunc_23:	jsr CallBackBank
FontPutChar:		jsr CallBackBank
_TempHideMouse:		jsr CallBackBank
_SetMsePic:		jsr CallBackBank
_BldGDirEntry:		jsr CallBackBank
_SetColorMode:		jsr CallBackBank
_ColorCard:		jsr CallBackBank
_ColorRectangle:	jsr CallBackBank
_SwapDiskDriver:	jsr CallBackBank
_MoveBData:		jsr CallBackBank
_CopyCmdToBack:		jsr CallBackBank
ToBASIC2:		jsr CallBackBank
_SwapBData:		jsr CallBackBank
_VerifyBData:		jsr CallBackBank
_DoBOp:			jsr CallBackBank
_AccessCache:		jsr CallBackBank
_HideOnlyMouse:		jsr CallBackBank
