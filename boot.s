
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

kernel_offset      := $2F40
kernal_start       := $BF40
kernal_end         := $FFFF

disk_driver_offset := $7000
disk_driver_start  := $9000
disk_driver_end    := $9FFF

init_offset        := $2E8D
init_start         := $5000
init_end           := $50AE

.segment "boot"

L2C98:
	jsr CheckJiffyDOS
	sei
	cld
	ldx #$FF
	txs
	lda #RAM_64K
	sta CPU_DATA
	lda #$00
	tax
L2CA7:
	sta $8400,x
	sta $8500,x
	sta $8600,x
	sta $8700,x
	sta $8800,x
	dex
	bne L2CA7
	LoadW r0, kernel_offset
	LoadW r1, kernal_start
	LoadW r2, kernal_end - kernal_start + 1
	jsr $3E97
	lda #>disk_driver_offset
	sta r0H
	lda #>disk_driver_start
	sta r1H
	lda #>(disk_driver_end - disk_driver_start + 1)
	sta r2H
	lda #0
	sta r0L
	sta r1L
	sta r2L
	jsr MoveData
	lda #IO_IN
	sta CPU_DATA
	LoadW r0, SCREEN_BASE
	ldx #$7D
L2CF9:
	ldy #$3F
L2CFB:
	lda #$55
	sta (r0),y
	dey
	lda #$AA
	sta (r0),y
	dey
	bpl L2CFB
	lda #$40
	clc
	adc r0L
	sta r0L
	bcc L2D12
	inc r0H
L2D12:
	dex
	bne L2CF9
	lda $DC0F
	and #$7F
	sta $DC0F
	lda #$81
	sta $DC0B
	lda #$00
	sta $DC0A
	sta $DC09
	sta $DC08
	lda #RAM_64K
	sta CPU_DATA
	ldx #$07
	lda #$BB
L2D35:
	sta A8FE8,x
	dex
	bpl L2D35
	lda #$BF
	sta A8FF0
	jsr FirstInit
	jsr MOUSE_JMP
	lda #$08
	sta interleave
	lda #23
	sta day
	lda #3
	sta month
	lda #92
	sta year
	lda #$01
	sta NUMDRV
	ldy $BA
	sty curDrive
	lda #$01
	sta curType
	sta driveType-8,y
	jsr L2DAB
	jsr $C247
	LoadW r0, init_offset
	LoadW r1, init_start
	LoadW r2, init_end - init_start + 1
	jsr MoveData
	jmp init_start + 13

CheckJiffyDOS:
	lda $E0A9
	cmp #$78
	beq :+
	rts
:	ldx #<DisableParallelCommand
	ldy #>DisableParallelCommand
	stx $7A ; CHRGET pointer
	sty $7B
	ldx #$0B
	pha
	pha
	jmp ($0300)

DisableParallelCommand:
	.byte "@P0", 0 ; Jiffy DOS: disable parallel cable

L2DAB:
	cmp #$23
	beq :+
	rts
:	lda #$83
	sta driveType-8,y
	jsr L2DCB
	bcc L2DCA
	ldy $8489
	sta $88BF,y
	txa
	sta $88C2
	sec
	lda #$FF
	sta $88C3
L2DCA:
	rts

L2DCB:
	lda #$00
	sta r5L
	lda #$00
	sta r9L
	lda #$01
	sta L2E88
	lda #$00
L2DDA:
	sta L2E89
	lda #$FF
	sta L2E8A
	lda #$80
	sta L2E8C
	lda #$00
	sta L2E8B
L2DEC:
	jsr L2E44
	lda #$00
	sta r0L
L2DF3:
	lda r0L
	asl a
	asl a
	asl a
	asl a
	asl a
	tay
	lda $8002,y
	cmp #$04
	beq L2E20
L2E02:
	inc r0L
	lda r0L
	cmp #$08
	bne L2DF3
	inc L2E89
	lda L2E89
	cmp #$05
	bne L2DEC
	lda r9L
	beq :+
	lda r8L
	ldx r8H
	sec
	rts
:	clc
	rts

L2E20:
	lda $8004,y
	cmp $0C
	beq L2E3C
	lda r9L
	bne L2E02
	lda $8016,y
	sta r8L
	lda $8017,y
	sta r8H
	lda #$01
	sta r9L
	clv
	bvc L2E02
L2E3C:
	lda $8016,y
	ldx $8017,y
	sec
	rts

L2E44:
	php
	sei
	lda CPU_DATA
	pha
	lda #KRNL_IO_IN
	sta CPU_DATA
	jsr $E0A9
	lda L2E88
	sta $DE21
	lda L2E89
	sta $DE22
	lda L2E8C
	sta $DE24
	lda L2E8B
	sta $DE23
	lda L2E8A
	sta $DE25
	lda #$01
	sta $DE26
	lda #$80
	sta $DE20
	lda #$00
	sta $DE1A
	jsr $FE09
	jsr $FE0F
	pla
	sta CPU_DATA
	plp
	rts

L2E88:
	brk
L2E89:
	brk
L2E8A:
	brk
L2E8B:
	brk
L2E8C:
	brk
