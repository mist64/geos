
;GEOS System various equations
;by Maciej 'YTM/Elysium' Witkowiak
;19-20,30.3, 3,5,18,20.4, 4.6, 17-19.8


;select the driver for the boot drive from the list:
;(only one value may be 'true')
!set use1541		=	true
!set use1571		=	false
!set use1581		=	false


;select generic input driver from the list:
;(only one value may be 'true')
!set useJoystick	=	true		; classical digital joystick
!set use1531		=	false		; 1531 mouse
!set useKoalaPad	=	false		; Koala Pad whatever it is...
!set useLightPen	=	false		; lightpen (rocks!)
!set usePCAnalogJoy	=	false		; analog PC joystick connected like paddles (kixx!)
!set useAmigaMouse	=	false		; Amiga style mouse

;general code generation/optimization control:
!set onlyVLIR		=	true		; only VLIR and SEQ supported
!set removeToBASIC	=	true		; shorter code if you don't use BASIC rebooter


;RAM expansions configuration
;(only one value may be 'true', if all are false then REU is utililzed)
!set usePlus60K		=	false		; for +60K expansion users
!set useRamCart64	=	false		; for Ram Cart 64K
!set useRamCart128	=	false		; for Ram Cart 128K


;runtime speedup
!set use2MHz 		=	false		; for 2MHz-on-border on C128 in 64 mode


;unsupported right now
!set useParallel1541 	=	false		; parallel cable - (only 8 data lines, no handshake)
						; all 1541 drives in system have to be parallel then

;Feel (almost) free to change values below:
!set currentYear	= 99		;88
!set currentMonth	= 7		;7
!set currentDay		= 3		;6
!set AMPM		= 1		;1		; 0 - AM/1-PM
!set currentHour	= $14		;1		; BCD! 14:31 = $14/$31
!set currentMinute	= $11		;0		; BCD! 21:08 = $21/$08

!set iniMaxMouseSpeed	= $7f				; range from $00-$7f
!set iniMinMouseSpeed	= $1e				;
!set iniMouseAccel	= $7f				;

!set currentInterleave	= 8				; 8 for 1541, 6 for 1571
!set SelectFlashDelay	= 10				; 10 in 1/50 s
!set SerialNumber	= $1cd5 			; $1cd5

;makes drawing dialog boxes much faster, might cause visual mess
;takes more bytes
!set speedupDlgBox	= true

!set oldMenu_5		= false				; bug - when false no blinking in menu

;if both menu separator patterns are null, then kernal menu code
;will be a bit optimized for speed and space
!set menuVSeparator	= %#.#.#.#.			; %10101010 ;both=0 -> speed&space
!set menuHSeparator	= %.#.#.#.#			; %01010101

;these are overriden by DeskTop, changing to null gives nothing
!set backPattern1	= %.#.#.#.#			; %01010101 ;overriden by DeskTop
!set backPattern2	= %#.#.#.#.			; %10101010

;better do not change below
!set REUOsVarBackup	=    $7900			; base for OS_VARS_LGH bytes for reboot
!set REUDskDrvSPC	=    $8300			; base for 4*DISK_DRV_LGH disk drivers

;do not change two values below - it's automatic
!set useRamExp	=	usePlus60K | useRamCart64 | useRamCart128
    !if (useRamExp) {
	!set REUPresent = false
    } else {
	!set REUPresent = true
    }
