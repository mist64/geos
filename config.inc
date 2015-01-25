; GEOS System build configuration
; by Maciej 'YTM/Elysium' Witkowiak

; select the driver for the boot drive from the list:
; (only one value may be '1')
use1541         =       1
use1571         =       0
use1581         =       0


; general code generation/optimization control:
onlyVLIR        =       0               ; only VLIR and SEQ supported
removeToBASIC   =       0               ; shorter code if you don't use BASIC rebooter


; RAM expansions configuration
; (only one value may be '1', if all are 0 then REU is utililzed)
usePlus60K      =       0               ; for +60K expansion users
useRamCart64    =       0               ; for Ram Cart 64K
useRamCart128   =       0               ; for Ram Cart 128K


; runtime speedup
use2MHz                 =       0               ; for 2MHz-on-border on C128 in 64 mode


; unsupported right now
useParallel1541         =       0               ; parallel cable - (only 8 data lines, no handshake)
; all 1541 drives in system have to be parallel then

; Feel (almost) free to change values below:
currentYear     = 99            ;88
currentMonth    = 7             ;7
currentDay      = 3             ;6
AMPM            = 1             ;1              ; 0 - AM/1-PM
currentHour     = $14           ;1              ; BCD! 14:31 = $14/$31
currentMinute   = $11           ;0              ; BCD! 21:08 = $21/$08

iniMaxMouseSpeed        = $7f                           ; range from $00-$7f
iniMinMouseSpeed        = $1e                           ;
iniMouseAccel           = $7f                           ;

currentInterleave       = 8                             ; 8 for 1541, 6 for 1571
SelectFlashDelay        = 10                            ; 10 in 1/50 s
SerialNumber            = $1cd5                         ; $1cd5

; makes drawing dialog boxes much faster, might cause visual mess
; takes more bytes
speedupDlgBox           = 0

oldMenu_5               = 0                             ; bug - when 0 no blinking in menu

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
