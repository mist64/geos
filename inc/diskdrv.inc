; GEOS Disk Driver JumpTab
; reassembled by Maciej 'YTM/Alliance' Witkowiak

;pointers
_InitForIO              =       $9000
_DoneWithIO             =       $9002
_ExitTurbo              =       $9004
_PurgeTurbo             =       $9006
_EnterTurbo             =       $9008
_ChangeDiskDevice       =       $900a
_NewDisk                =       $900c
_ReadBlock              =       $900e
_WriteBlock             =       $9010
_VerWriteBlock          =       $9012
_OpenDisk               =       $9014
_GetBlock               =       $9016
_PutBlock               =       $9018
_GetDirHead             =       $901a
_PutDirHead             =       $901c
_GetFreeDirBlk          =       $901e
_CalcBlksFree           =       $9020
_FreeBlock              =       $9022
_SetNextFree            =       $9024
_FindBAMBit             =       $9026
_NxtBlkAlloc            =       $9028
_BlkAlloc               =       $902a
_ChkDkGEOS              =       $902c
_SetGEOSDisk            =       $902e

;jump table
Get1stDirEntry          =       $9030
GetNxtDirEntry          =       $9033
GetBorder               =       $9036
AddDirBlock             =       $9039
ReadBuff                =       $903c
WriteBuff               =       $903f
SendTSBytes             =       $9042
CheckErrors             =       $9045
AllocateBlock           =       $9048
ReadLink                =       $904b

; Wheels only
ddriveType              =       $904e
driverVersion           =       $904f
OpenRoot                =       $9050
OpenDirectory           =       $9053
GetBamBlock             =       $9056
PutBamBlock             =       $9059
dirHeadTrack            =       $905c
dirHeadSector           =       $905d
curBamBlock             =       $905e
lastBamByte             =       $905f
lastBamSector           =       $9060
bamAltered              =       $9061
highestTrack            =       $9062
GetHeadTS               =       $9063
PutHeadTS               =       $9066
GetLink                 =       $9069
GetSysDirBlk            =       $906c
startBank               =       $906f
startPage               =       $9070
pagesUsed               =       $9071
cableType               =       $9073
ckdBrdrYet              =       $9074 ; $ff means GetNxtDirEntry is working
                                      ; in the system directory. (read only)
dir3Head                =       $9c80 ; to be used by the disk drivers only.
                                      ; It resides within each driver.
                                      ; ($9c80-$9d7f)
