; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/C128 keyboard driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global KbdDecodeTab1
.global KbdDecodeTab2
.global KbdTab1
.global KbdTab2
.global KbdTestTab

.segment "keyboard2"

.ifdef bsw128
KbdTestTab:
	.byte $fe, $fd, $fb, $f7, $ef, $df, $bf, $7f
.endif
KbdTab1:
.ifdef german_keyboard
	.byte $bb, $bb, $bb, $bb, $bb, $bb, $bb, $ba, $e0
.else
	.byte $db, $dd, $de, $ad, $af, $aa, $c0, $ba, $bb
.endif
KbdTab2:
.ifdef german_keyboard
	.byte $3c, $3c, $3c, $3c, $3c, $3c, $3c, $3e, $5e
.else
	.byte $7b, $7d, $7c, $5f, $5c, $7e, $60, $7b, $7d
.endif
.ifndef bsw128
KbdTestTab:
	.byte $fe, $fd, $fb, $f7, $ef, $df, $bf, $7f
.endif
KbdDecodeTab1:
.ifdef german_keyboard
	.byte KEY_DELETE, CR, KEY_RIGHT, KEY_F7, KEY_F1, KEY_F3, KEY_F5, KEY_DOWN
	.byte "3", "w", "a", "4", "y", "s", "e", KEY_INVALID
	.byte "5", "r", "d", "6", "c", "f", "t", "x"
	.byte "7", "z", "g", "8", "b", "h", "u", "v"
	.byte "9", "i", "j", "0", "m", "k", "o", "n"
	.byte "~", "p", "l", "'", ".", "|", "}", ","
	.byte KEY_INVALID, "+", "{", KEY_HOME, KEY_INVALID, "#", KEY_INVALID, "-"
	.byte "1", KEY_LARROW, KEY_INVALID, "2", " ", KEY_INVALID, "q", KEY_STOP
.else
	.byte KEY_DELETE, CR, KEY_RIGHT, KEY_F7, KEY_F1, KEY_F3, KEY_F5, KEY_DOWN
	.byte "3", "w", "a", "4", "z", "s", "e", KEY_INVALID
	.byte "5", "r", "d", "6", "c", "f", "t", "x"
	.byte "7", "y", "g", "8", "b", "h", "u", "v"
	.byte "9", "i", "j", "0", "m", "k", "o", "n"
	.byte "+", "p", "l", "-", ".", ":", "@", ","
	.byte KEY_BPS, "*", ";", KEY_HOME, KEY_INVALID, "=", "^", "/"
	.byte "1", KEY_LARROW, KEY_INVALID, "2", " ", KEY_INVALID, "q", KEY_STOP
.endif

.ifdef bsw128
	.byte KEY_HELP, "8", "5", KEY_TAB, "2", "4", "7", "1"
	.byte KEY_ESC, "+", "-", KEY_LF, KEY_ENTER, "6", "9", "3"
	.byte KEY_ALT, "0", ".", KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_NOSCRL
.endif

KbdDecodeTab2:
.ifdef german_keyboard
	.byte KEY_INSERT, CR, BACKSPACE, KEY_F8, KEY_F2, KEY_F4, KEY_F6, KEY_UP
	.byte "@", "W", "A", "$", "Y", "S", "E", KEY_INVALID
	.byte "%", "R", "D", "&", "C", "F", "T", "X"
	.byte "/", "Z", "G", "(", "B", "H", "U", "V"
	.byte ")", "I", "J", "=", "M", "K", "O", "N"
	.byte "?", "P", "L", "`", ":", "\", "]", ";"
	.byte "^", "*", "[", KEY_CLEAR, KEY_INVALID, "'", KEY_INVALID, "_"
	.byte "!", KEY_LARROW, KEY_INVALID, $22, " ", KEY_INVALID, "Q", KEY_RUN
.else
	.byte KEY_INSERT, CR, BACKSPACE, KEY_F8, KEY_F2, KEY_F4, KEY_F6, KEY_UP
	.byte "#", "W", "A", "$", "Z", "S", "E", KEY_INVALID
	.byte "%", "R", "D", "&", "C", "F", "T", "X"
	.byte "'", "Y", "G", "(", "B", "H", "U", "V"
	.byte ")", "I", "J", "0", "M", "K", "O", "N"
	.byte "+", "P", "L", "-", ">", "[", "@", "<"

	.byte KEY_BPS, "*", "]", KEY_CLEAR, KEY_INVALID, "=", "^", "?"
	.byte "!", KEY_LARROW, KEY_INVALID, $22, " ", KEY_INVALID, "Q", KEY_RUN
.endif

.ifdef bsw128
	.byte KEY_HELP, "8", "5", KEY_TAB, "2", "4", "7", "1"
	.byte KEY_ESC, "+", "-", KEY_LF, KEY_ENTER, "6", "9", "3"
	.byte KEY_ALT, "0", ".", KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_NOSCRL
.endif

