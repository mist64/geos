; GEOS System build configuration
; by Maciej Witkowiak

;------------------------
; which variant to build
;------------------------
; use "make TARGET=<variant>" to build a specific variant

;------------------------
; the Berkeley Softworks GEOS 64 2.0 variant
;------------------------
.ifdef bsw
	; BSW traps to counter tampering
	trap = 1
.endif

;------------------------
; the cbmfiles.com variant of GEOS 64 2.0
;------------------------
.ifdef cbmfiles
	trap = 1

	; additionally, there are ".ifdef cbmfiles" checks
	; throughout the code
.endif

;------------------------
; the gateWay 2.51 variant
;------------------------
.ifdef gateway
	trap = 1
	gateway_font = 1

	; additionally, there are ".ifdef gateway" checks
	; throughout the code
.endif

;------------------------
; the Wheels 64 variant
;------------------------
.ifdef wheels
	; size optimizations that have no significant speed impact
	wheels_size = 1

	; optimizations that benefit both size and speed
	wheels_size_and_speed = 1

	; fixes for bugs in the BSW version
	wheels_fixes = 1

	; dialog box buttons can be selected using "o" for
	; "Open" etc.
	wheels_button_shortcuts = 1

	; misc dialog box features, requires RAM extension
	wheels_dlgbox_features = 1

	; dialog box double click support
	wheels_dlgbox_dblclick = 1

	; support for chdir in dialogs
	wheels_dialog_chdir = 1

	; screensaver support
	wheels_screensaver = 1

	; ReadFile and WriteFile are in a "NewKernal" group
	wheels_external_readwrite_file = 1

	; allows applications to check whether modifier keys are pressed
	wheels_expose_mod_keys = 1

	; changes that are actually bad ideas
	wheels_bad_ideas = 1

	; German keyboard layout
	german_keyboard = 1

	; additionally, there are ".ifdef wheels" checks
	; throughout the code
.endif

.ifdef custom
	wheels_size = 1
	wheels_size_and_speed = 1
	wheels_fixes = 1
.endif

; general code generation/optimization control:
onlyVLIR        =       0               ; only VLIR and SEQ supported
removeToBASIC   =       0               ; shorter code if you don't use BASIC rebooter


; RAM expansions configuration
; (only one value may be '1', if all are 0 then REU is utililzed)
usePlus60K      =       0               ; for +60K expansion users
; XXX these are untested and probably broken XXX
useRamCart64    =       0               ; for Ram Cart 64K
useRamCart128   =       0               ; for Ram Cart 128K


; runtime speedup
use2MHz                 =       0               ; for 2MHz-on-border on C128 in 64 mode


; Feel (almost) free to change values below:
iniMaxMouseSpeed        = $7f                           ; range from $00-$7f
iniMinMouseSpeed        = $1e                           ;
iniMouseAccel           = $7f                           ;

currentInterleave       = 8                             ; 8 for 1541, 6 for 1571
SelectFlashDelay        = 10                            ; 10 in 1/50 s

; makes drawing dialog boxes much faster, might cause visual mess
; takes more bytes
speedupDlgBox           = 0

oldMenu_5               = 1                             ; bug - when 0 no blinking in menu

; if both menu separator patterns are null, then kernal menu code
; will be a bit optimized for speed and space
menuVSeparator  = %10101010                     ; %10101010 ;both=0 -> speed&space
menuHSeparator  = %01010101                     ; %01010101

; these are overriden by DeskTop, changing to null gives nothing
backPattern1    = %01010101                     ; %01010101 ;overriden by DeskTop
backPattern2    = %10101010                     ; %10101010

; better do not change below
REUOsVarBackup  =    $7900                      ; base for OS_VARS_LGH bytes for reboot
REUDskDrvSPC    =    $8300                      ; base for 4*DISK_DRV_LGH disk drivers

; do not change two values below - it's automatic
useRamExp       =       usePlus60K | useRamCart64 | useRamCart128
.if (useRamExp)
REUPresent = 0
.else
REUPresent = 1
.endif
