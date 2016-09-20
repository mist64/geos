.include "config.inc"

; Commodore Kernal equates
tapeBuffVec     =       $b2
curScrLine      =       $d1
curPos          =       $d3
kbdQuePos       =       $c6
kbdQue          =       $0277
BASICMemBot     =       $0282
BASICMemTop     =       $0284
scrAddrHi       =       $0288
.ifdef bsw128
PALNTSCFLAG     =       $0A03
BASICspace      =       $1C00
.else
PALNTSCFLAG     =       $02a6
BASICspace      =       $0800
.endif
BASIC_START     =       $a000
curScrLineColor =       $d8f0
KERNALVecTab    =       $fd30
KERNALCIAInit   =       $fda3
KERNALVICInit   =       $ff81
KERNALSETMSG    =       $ff90

;
vicbase                 =       $d000
sidbase                 =       $d400
mmu                     =       $d500
VDC                     =       $d600
ctab                    =       $d800
cia1base                =       $dc00
cia2base                =       $dd00
;
mob0xpos                =       $d000
mob0ypos                =       $d001
mob1xpos                =       $d002
mob1ypos                =       $d003
mob2xpos                =       $d004
mob2ypos                =       $d005
mob3xpos                =       $d006
mob3ypos                =       $d007
mob4xpos                =       $d008
mob4ypos                =       $d009
mob5xpos                =       $d00a
mob5ypos                =       $d00b
mob6xpos                =       $d00c
mob6ypos                =       $d00d
mob7xpos                =       $d00e
mob7ypos                =       $d00f
msbxpos                 =       $d010
grcntrl1                =       $d011
rasreg                  =       $d012
lpxpos                  =       $d013
lpypos                  =       $d014
mobenble                =       $d015
grcntrl2                =       $d016
grmemptr                =       $d018
grirq                   =       $d019
grirqen                 =       $d01a
moby2                   =       $d017
mobprior                =       $d01b
mobmcm                  =       $d01c
mobx2                   =       $d01d
mobmobcol               =       $d01e
mobbakcol               =       $d01f
extclr                  =       $d020
bakclr0                 =       $d021
bakclr1                 =       $d022
bakclr2                 =       $d023
bakclr3                 =       $d024
mcmclr0                 =       $d025
mcmclr1                 =       $d026
mob0clr                 =       $d027
mob1clr                 =       $d028
mob2clr                 =       $d029
mob3clr                 =       $d02a
mob4clr                 =       $d02b
mob5clr                 =       $d02c
mob6clr                 =       $d02d
mob7clr                 =       $d02e
keyreg                  =       $d02f
clkreg                  =       $d030

scpu_base               =       $d074
scpu_turbo              =       $d07b
scpu_hwreg_enable       =       $d07e
scpu_hwreg_disable      =       $d07f

;
vdcreg                  =       $d600
vdcdata                 =       $d601
;

;RamExpansions CR
PLUS60K_CR              =       $d100
RAMC_BASE               =       $de00
RAMC_WINDOW             =       $df00

; C128
rcr = $D506
