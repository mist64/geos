; GEOS system variables
; by Maciej Witkowiak

.include "config.inc"

;addresses defined so-so
.ifdef bsw128
Z45             =       $46
Z46             =       $47
Z47             =       $48
.else
Z45             =       $45
Z46             =       $46
Z47             =       $47
.endif

z8b             =       $8b
z8c             =       $8c
z8d             =       $8d
z8e             =       $8e
z8f             =       $8f

; GEOS Kernal internal zpage vectors (not for use by apps)
.ifdef bsw128
IconDescVec     =       $40
IconDescVecH    =       $41
CallRLo         =       $42
CallRHi         =       $43
DBoxDesc        =       $44
DBoxDescL       =       $44
DBoxDescH       =       $45
.else
IconDescVec     =       $3f
IconDescVecH    =       $40
CallRLo         =       $41
CallRHi         =       $42
DBoxDesc        =       $43
DBoxDescL       =       $43
DBoxDescH       =       $44
.endif

; Wheels internal vars

; bit 7    = time out, run the screensaver.
; bit 6    = saver blocked, don't run it yet.
; bit 5    = stop the timer.
; bit 4    = timer off. Screensaver will never run.
; bits 2,3 = unused.
; bit 1    = if set then ignore mouse movement.
; bit 0    = screensaver is running.
saverStatus     =       $88b4
saverTimer      =       $88b5 ; time remaining before screensaver.
saverCount      =       $88b7 ; user defined countdown to screensaver.
saverBank       =       $88b9 ; bank in reu holding screensaver.
vdcRamType      =       $88ba ; bit7 1=64K VDC ram, 0=16K ram.

; GEOS Kernal internal vars (not for use by apps)

savedmoby2      =       $88bb ; ---
scr80polar      =       $88bc ; ---
scr80colors     =       $88bd ; ---
vdcClrMode      =       $88be ; --- (used with 128 only)
driveData       =       $88bf ; drv
ramExpSize      =       $88c3 ; reu
sysRAMFlg       =       $88c4 ; drv, filesys, memory, tobasic
firstBoot       =       $88c5 ; filesys
curType         =       $88c6 ; drv, filesys, boot
ramBase         =       $88c7 ; ---
inputDevName    =       $88cb ; ---
memBase         =       $88cf ; ---
DrCCurDkNm      =       $88dc ; files
DrDCurDkNm      =       $88ee ; files

dir2Head        =       $8900 ; drv
;
spr0pic         =       SPRITE_PICS+0*64 ; sprites
spr1pic         =       SPRITE_PICS+1*64 ; sprites
spr2pic         =       SPRITE_PICS+2*64 ; sprites
spr3pic         =       SPRITE_PICS+3*64 ; sprites
spr4pic         =       SPRITE_PICS+4*64 ; sprites
spr5pic         =       SPRITE_PICS+5*64 ; sprites
spr6pic         =       SPRITE_PICS+6*64 ; sprites
spr7pic         =       SPRITE_PICS+7*64 ; sprites
;
obj0Pointer     =       $8ff8 ; init
obj1Pointer     =       $8ff9 ; ---
obj2Pointer     =       $8ffa ; ---
obj3Pointer     =       $8ffb ; ---
obj4Pointer     =       $8ffc ; ---
obj5Pointer     =       $8ffd ; ---
obj6Pointer     =       $8ffe ; ---
obj7Pointer     =       $8fff ; ---

; GEOS BOOT and REU reboot adresses
BVBuff          =       $0400
RunREU          =       $6000

keyScanChar     =       $87ea ; character fetched during the last interrupt. (Wheels)
.ifdef bsw128
E87FC           =       $8802
E87FD           =       $8803
E87FE           =       $8804
E87FF           =       $8805
E8800           =       $8806
.else
E87FC           =       $87fc
E87FD           =       $87fd
E87FE           =       $87fe
E87FF           =       $87ff
E8800           =       $8800
.endif
;A8860           =       $8860 ; XXX unused

.ifdef bsw128
FontTVar1 = $880E
FontTVar2 = $880F
.elseif .defined(wheels)
FontTVar1 = $8886
FontTVar2 = $8887
.endif

; bsw128
L888D = $888D
L888E = $888E
L888F = $888F
L8890 = $8890
L8891 = $8891
L8892 = $8892
L8893 = $8893
krnlSaveRcr = $8894
krnlSaveConfig = $8895
L8896 = $8896
bank0SaveRcr = $8897
bank0SaveA = $8898
bank0SavePS = $8899
L8A7F = $8A7F ; only written to once

fileHeadMemBuff	= $d8c0		;$0100 len
prntDrvMemBuff	= $d9c0		;$0640 len -> $e000


dblDBData       =       $88a7   ; icon number used for double clicking
                                ; in the file requestor. Default is OPEN.
minKeyRepeat    =       $88b0   ; minimum key repeat value during accel. (Wheels)
keyAccFlag      =       $88b1   ; zero turns off key acceleration. (Wheels)
keyAccel        =       $88b2   ; used during key acceleration. (Wheels)
keyRptCount     =       $88b3   ; user defined key repeat delay. (Wheels)
e88b7           =       $88b7   ; 4 bytes indexed by curDrive, 1571 disk type (SS/DS)
A8FE8           =       $8fe8
A8FF0           =       $8ff0

; Wheels
prtHdrStorage   =       $f700   ; print driver header stored here.
prtCodeStorage  =       $f800   ; print driver code stored here.

; RamExp stats block structure
DACC_ST_ADDR    =       $80     ;deskAccessory load addr
DACC_LGH        =       $82     ;deskAccessory lenght
DTOP_CHNUM      =       $83     ;DeskTop # of chains
RAM_EXP_1STFREE =       $84     ;# of 1st free block
DTOP_CHAIN      =       $85     ;# of DTop chains, (=6) up to $98

; C128 back RAM
; Screen pointer where the back buffer came from.
backBufPtr      = $131b
; For each sprite, there is one byte here for how many bytes wide the
; corresponding sprite is. Used by soft sprite routines.
backXBufNum     = $132b
; For each sprite, there is one byte here for how many scanlines high the
; corresponding sprite is. Used by soft sprite routines.
backYBufNum     = $1333
; This is an image of the C64 mobenble register. Used soft sprites.
curEnble        = $1300
; Image of of C64 moby2 register.
curmoby2        = $1301
; Image of of C64 mobx2 register.
curmobx2        = $1302
; The current X positions of the soft sprites.
curXpos0        = $1303
; The current Y positions of the soft sprites.
curYpos0        = $1313
; Flag needed because of overlapping soft sprite problens on C128 and Apple.
; Set to TRUE if we see a sprite that needs to be redrawn and therefore all
; higher nunbered sprites need to be redrawn as well.
doRestFlag      = $1b54
; Buffer area used to speed up the 80 colunn InvertLine routine.
invertBuffer    = $1ced
; Screen data for what is beneath mouse soft sprite.
mouseSave       = $1b55
; Buffer for shifting/doubling sprites.
shiftBuf        = $1b45
; Buffer for shifting/doubling/oring sprites.
shiftOutBuf     = $1b4c
sizeFlag        = $1b53 ; XXX unused?
; Buffer used for putting sprite bitmaps upon screen without disturbing
; background.
softZeros       = $1b6d
; Buffer used for putting sprite bitmaps upon screen without disturbing
; background.
softOnes        = $1c2d

sspr1back = $133b
sspr2back = $1461
sspr3back = $1587
sspr4back = $16ad
sspr5back = $17d3
sspr6back = $18f9
sspr7back = $1a1f

;--------------
; VDC memory
COLOR_MATRIX_80_1	= $3880
COLOR_MATRIX_80_2	= $4080
; Bank0 memory
TRACK_CACHE		= $ac00
DISK_SWAPBASE		= $d000
SWAP_PAGE 	        = $fc00 ; memory swap page
