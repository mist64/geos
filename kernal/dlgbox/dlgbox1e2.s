; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: default icon callbacks

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.ifdef wheels
.import ChDiskDirectory
.import DBDefIconsTabRoutine
.import DBDefIconsTab
.import defIconTab
.import CallRoutine
.endif

.import RstrFrmDialogue

.global DBIcCANCEL
.global DBIcDISK
.global DBIcYES
.global DBIcNO
.global DBIcOK
.global DBIcOPEN
.global DBKeyVector

.ifdef wheels
.global DBKeyVector2
.global DBStringFaultVec2
.global DoKeyboardShortcut
.endif

.segment "dlgbox1e2"

DBKeyVector:
.ifdef wheels_button_shortcuts
	lda keyData
	ldy #ShortcutKeysEnd - ShortcutKeys - 1
@1:	cmp ShortcutKeys,y
	beq DoKeyboardShortcut
	dey
	bpl @1
	rts

DoKeyboardShortcut:
	tya
	asl
	asl
	asl
	tay
	lda #0
	sta r0L
LF4AC:	tax
	lda defIconTab+4,x
	cmp DBDefIconsTab,y
	bne LF4BD
	lda defIconTab+4+1,x
	cmp DBDefIconsTab+1,y
	beq LF4CC
LF4BD:	inc r0L
	lda r0L
	cmp defIconTab
	bcs LF4CB
	asl
	asl
	asl
	bne LF4AC
LF4CB:	rts
LF4CC:	lda DBDefIconsTabRoutine,y
	ldx DBDefIconsTabRoutine+1,y
	jmp CallRoutine

ShortcutKeys:
	.byte 13, "cynod"; ok, cancel, yes, no, open, disk
ShortcutKeysEnd:
.else
	CmpBI keyData, CR
	beq DBIcOK
	rts
.endif

.ifdef wheels_size
DBIcDISK:
.ifdef wheels_dialog_chdir ; "Disk" button can change directory
; Maurice says: If your application includes a dialogue box
; with the "DISK" icon, that's all you really need to let the
; user select any partition or subdirectory on a CMD device or
; a subdirectory on a native ramdisk.
; ATTN: *requires* wheels_size!!!
.import GetNewKernal
.import RstrKernal
	lda #$40 + 5
	jsr GetNewKernal
	jsr ChDiskDirectory
	jsr RstrKernal
.endif
	lda #DISK
	.byte $2c
DBIcOK:
	lda #OK
	.byte $2c
DBIcCANCEL:
	lda #CANCEL
	.byte $2c
DBIcYES:
	lda #YES
	.byte $2c
DBIcNO:
	lda #NO
	.byte $2c
DBIcOPEN:
	lda #OPEN
	.byte $2c
DBStringFaultVec2:
	lda #DBSYSOPV
	.byte $2c
DBKeyVector2:
	lda #DBGETSTRING
.else
DBIcOK:
	lda #OK
	bne DBKeyVec1
DBIcCANCEL:
	lda #CANCEL
	bne DBKeyVec1
DBIcYES:
	lda #YES
	bne DBKeyVec1
DBIcNO:
	lda #NO
	bne DBKeyVec1
DBIcOPEN:
	lda #OPEN
	bne DBKeyVec1
DBIcDISK:
	lda #DISK
	bne DBKeyVec1 ; XXX
DBKeyVec1:
.endif
	sta sysDBData
	jmp RstrFrmDialogue

