; Wheels
; these are addresses to routines that are in the extended
; kernal that get loaded in at $5000 in groups.

; group 0
GetRAMBam               =       $5000
PutRAMBam               =       $5003
AllocAllRAM             =       $5006
AllocRAMBlock           =       $5009
FreeRAMBlock            =       $500c
GetRAMInfo              =       $500f
RamBlkAlloc             =       $5012
RemoveDrive             =       $5015
SvRamDevice             =       $5018
DelRamDevice            =       $501b
RamDevInfo              =       $501e

; group 1
DevNumChange            =       $5000
SwapDrives              =       $5003

; group 2
NSetGEOSDisk            =       $5000
DBFormat                =       $5000+3
FormatDisk              =       $5000+6
DBEraseDisk             =       $5000+9
EraseDisk               =       $5000+12

; group 3
OReadFile               =       $5000

; group 4
OWriteFile              =       $5000

; group 5
ChgParType              =       $5000
ChPartition             =       $5000+3
ChSubdir                =       $5000+6
ChDiskDirectory         =       $5000+9
GetFEntries             =       $5000+12
TopDirectory            =       $5000+15
UpDirectory             =       $5000+18
DownDirectory           =       $5000+21
GoPartition             =       $5000+24
ChPartOnly              =       $5000+30
FindRamLink             =       $5000+39

; group 6
MakeDirectory           =       $5000
MakeSysDir              =       $5003

; group 7
ValDisk                 =       $5000

; group 8
CopyDisk                =       $5000
TestCompatibility       =       $5003

; group 9
CopyFile                =       $5000

; group 10
NewDesktop              =       $5000
OEnterDesktop           =       $5003
InstallDriver           =       $5006
FindDesktop             =       $5009
FindAFile               =       $500c

; group 11
KToBasic                =       $5000
