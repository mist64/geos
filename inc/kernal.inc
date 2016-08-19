; GEOS system variables
; by Maciej Witkowiak

;addresses defined so-so
Z45             =       $45
Z46             =       $46
Z47             =       $47

z8b             =       $8b
z8c             =       $8c
z8d             =       $8d
z8e             =       $8e
z8f             =       $8f

; GEOS Kernal internal zpage vectors (not for use by apps)
IconDescVec     =       $3f
IconDescVecH    =       $40
CallRLo         =       $41
CallRHi         =       $42
DBoxDesc        =       $43
DBoxDescL       =       $43
DBoxDescH       =       $44

; GEOS Kernal internal vars (not for use by apps)

savedmoby2      =       $88bb ; ---
scr80polar      =       $88bc ; ---
scr80colors     =       $88bd ; ---
vdcClrMode      =       $88be ; ---
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

; locations to be defined later
E87FC           =       $87fc
E87FD           =       $87fd
E87FE           =       $87fe
E87FF           =       $87ff
E8800           =       $8800
A885D           =       $885d
A885E           =       $885e
A885F           =       $885f
A8860           =       $8860
e88b7           =       $88b7   ;4 bytes indexed by curDrive, 1571 disk type (SS/DS)
A8FE8           =       $8fe8
A8FF0           =       $8ff0

; RamExp stats block structure
DACC_ST_ADDR    =       $80     ;deskAccessory load addr
DACC_LGH        =       $82     ;deskAccessory lenght
DTOP_CHNUM      =       $83     ;DeskTop # of chains
RAM_EXP_1STFREE =       $84     ;# of 1st free block
DTOP_CHAIN      =       $85     ;# of DTop chains, (=6) up to $98

