; GEOS System build configuration
; by Maciej Witkowiak

.ifndef config_inc
config_inc = 1

;------------------------
; which variant to build
;------------------------
; use "make TARGET=<variant>" to build a specific variant

;------------------------
; the Berkeley Softworks GEOS 64 2.0 variant
;------------------------
.ifdef bsw
	; BSW traps to counter tampering
	traps = 1
.endif

;------------------------
; the Berkeley Softworks GEOS 128 2.0 variant
;------------------------
.ifdef bsw128
	; BSW traps to counter tampering
	traps = 1
	trap2_alternate_location = 1
.endif

;------------------------
; the cbmfiles.com variant of GEOS 64 2.0
;------------------------
.ifdef cbmfiles
	; BSW traps to counter tampering
	traps = 1

	; additionally, there are ".ifdef cbmfiles" checks
	; throughout the code
.endif

;------------------------
; the gateWay 2.51 variant
;------------------------
.ifdef gateway
	traps = 1
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

	; remove "BootGEOS" ($C000) code to save some size
	wheels_remove_BootGEOS = 1

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
	; make use of all reusable Wheels optimizations and fixes
	wheels_size = 1
	wheels_size_and_speed = 1
	wheels_remove_BootGEOS = 1
	wheels_fixes = 1

	remove_dead_bytes = 1

	; replace BASIC reboot code with trivial version (+200 bytes)
	removeToBASIC = 1

	; for 2MHz-on-border on C128 in 64 mode
	use2MHz = 1

	; only VLIR and SEQ supported
	;onlyVLIR = 1

	; RAM expansions configuration
	; (only one may be defined, if all are undefined, then REU is utililzed)
	; for +60K expansion users
	;usePlus60K = 1
	; for Ram Cart 64K
	;useRamCart64 = 1
	; for Ram Cart 128K
	;useRamCart128 = 1

	; GEOS2000
	; makes drawing dialog boxes much faster, might cause visual mess
	; takes more bytes
	;speedupDlgBox = 1

	; GEOS2000
	; bug - when 0 no blinking in menu
	;newMenu_5 = 1
.endif

; Feel (almost) free to change values below:
iniMaxMouseSpeed        = $7f                           ; range from $00-$7f
iniMinMouseSpeed        = $1e                           ;
iniMouseAccel           = $7f                           ;

currentInterleave       = 8                             ; 8 for 1541, 6 for 1571
SelectFlashDelay        = 10                            ; 10 in 1/50 s

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
.if .defined(usePlus60K) || .defined(useRamCart64) || .defined(useRamCart128)
useRamExp = 1
.else
REUPresent = 1
.endif

.ifdef traps
	trap1 = 1
	trap2 = 1
.endif

.if .defined(drv1541)
DRV_TYPE = 1 ; DRV_1541
.elseif .defined(drv1571)
DRV_TYPE = 2; DRV_1571
.elseif .defined(drv1581)
DRV_TYPE = 3; DRV_1581
.else
.error "Unknown drive type!"
.endif

.endif
