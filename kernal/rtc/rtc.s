; GEOS KERNAL by Berkeley Softworks
;
; RTC support by Maciej Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.ifdef useRTC
.global RTCSetupDateAndTime
.endif

.segment "rtc"

.ifdef rtc_Ultimate2Plus
; Ultimate2+ code based on https://github.com/rhalkyard/ultimateRTC

CIA1_TODHR  = cia1base+11
CIA1_TODMIN = cia1base+10
CIA1_TODSEC = cia1base+9
CIA1_TOD10  = cia1base+8

U2_CONTROL_STATUS   := $df1c ; Write: control register / Read: status register
U2_COMMAND_ID       := $df1d ; Write: command register / Read: ID register
U2_RESPONSE_DATA    := $df1e ; Read-only: data channel
U2_STATUS_DATA      := $df1f ; Read-only: status channel

U2_DEVICEID     = $c9

U2_PUSH         = (1 << 0)
U2_ACCEPT       = (1 << 1)
U2_ABORT        = (1 << 2)
U2_ERROR        = (1 << 3)

U2_STATEMASK    = ((1 << 4) | (1 << 5))
U2_STATE_IDLE   = 0
U2_STATE_BUSY   = (1 << 4)
U2_STATE_DLAST  = (1 << 5)
U2_STATE_DMORE  = ((1 << 4) | (1 << 5))

U2_STATUS_AVAIL = (1 << 6)
U2_DATA_AVAIL   = (1 << 7)

; Check for presence of Ultimate II hardware
; Returns: A - zero if Ultimate II was detected, nonzero otherwise
.proc u2_check
        lda U2_COMMAND_ID
        cmp #U2_DEVICEID
        rts  
.endproc

; Start a command by making sure the ultimate is in the correct state
; Destroys: A
.proc u2_start_cmd
        lda #U2_ERROR
        bit U2_CONTROL_STATUS   ; check error flag
        beq @check_idle         ; no error, do idle check
        sta U2_CONTROL_STATUS   ; error flag is set; clear it
@check_idle:
        lda #U2_STATEMASK       ; check state machine state
        bit U2_CONTROL_STATUS
        beq @finished           ; state is idle, good to go

        ; otherwise, abort current command
        lda #U2_ABORT           ; set the abort bit, returning the
        sta U2_CONTROL_STATUS   ; ultimate to idle state
        lda #U2_STATEMASK       ; check if idle state is reached
@wait_idle:
        bit U2_CONTROL_STATUS
        beq @finished           ; yes. return.
        jmp @wait_idle          ; keep waiting.
@finished:
        rts
.endproc

; Finish a command and return
; Destroys: A
; Returns:  C flag indicates success/failure
;               0 - command was written sucessfully
;               1 - error
.proc u2_finish_cmd
        lda #U2_ERROR
        bit U2_CONTROL_STATUS   ; check error flag
        bne @err                ; error flag is set, return failure
        lda #U2_PUSH            ; push the command
        sta U2_CONTROL_STATUS
@wait_push:                     ; wait for command push to be acknowledged
        bit U2_CONTROL_STATUS
        bne @wait_push
@wait_busy:
        lda #U2_STATEMASK       ; wait for command-busy state to finish
        and U2_CONTROL_STATUS
        cmp #U2_STATE_BUSY
        beq @wait_busy
        clc
        rts
@err:   sec
        rts
.endproc

; Accept received data
; Destroys: A
.proc u2_accept
        lda #U2_ACCEPT          ; set the data-accepted flag
        sta U2_CONTROL_STATUS
@wait:  bit U2_CONTROL_STATUS   ; wait for acknowledgement
        bne @wait
        rts
.endproc

; Read one byte from data channel into A
; Automatically accepts data (and checks for more data) when a block is
; exhausted.
; Returns: A - byte read from data channel (only valid if C is 0 - see below)
;          C flag indicates success/failure:
;               0 = data was successfully read
;               1 = error/no data available     
.proc u2_get_data
        lda #U2_DATA_AVAIL
        bit U2_CONTROL_STATUS   ; is there data?
        beq @nodata             ; no.
        lda U2_RESPONSE_DATA    ; yes. load it.
        clc                     ; return success
        rts
@nodata:
        jsr u2_accept           ; acknowledge current data block
@wait_busy:
        lda U2_CONTROL_STATUS
        and #U2_STATEMASK
        cmp #U2_STATE_BUSY      ; wait for busy state to end
        beq @wait_busy

        cmp #U2_STATE_IDLE      ; have we entered idle state?
        bne u2_get_data         ; no - more data is available
        sec                     ; yes - no more data
        rts
.endproc

; Read one byte from data channel into A
; Returns: A - byte read from status channel (only valid if C is 0 - see below)
;          C flag indicates success/failure:
;               0 = data was successfully read
;               1 = error/no data available   
.proc u2_get_status
        lda #U2_STATUS_AVAIL    ; is there a status?
        bit U2_CONTROL_STATUS
        beq @nostatus           ; no
        lda U2_STATUS_DATA      ; yes. load it.
        clc
        rts
@nostatus:
        sec
        rts
.endproc

        ; like MoveB from geosmac.inc, but converts a BCD source value to a
        ; regular byte
        .macro MoveBCD_B source, dest
            lda source
            jsr fromBCD
            sta dest
        .endmacro

; boot code interface
; this will be called with I/O enabled and IRQ disabled

RTCSetupDateAndTime:
        php
        sei
        START_IO
        jsr RTC_Ultimate2Plus
        END_IO
        plp
        rts

        ; Size of status/date-string buffer. Must be <= 255 bytes
        BUFSIZE         = 64

RTC_Ultimate2Plus:
        ; check if 1541U2 is present
        jsr u2_check
        beq :+
        ; No 1541U detected
        rts

:       jsr get_time
        bcc :+          ; get_time returns with C=0 if command was successful
        ; Status channel indicated an error - print error message and bail out.
        rts

:       jsr parse_time
        cpy #6
        beq :+
        ; parsing error
        rts

:
        ; setup CIA#1 time-of-day clock
        lda mhour
        cmp #$13
        bcc :+
        php
        sei
        sed
        sbc #$12
        plp
        ora #$80                ; high bit of CIA hour register is AM/PM flag
:       sta CIA1_TODHR
        MoveB mmin, CIA1_TODMIN
        MoveB msec, CIA1_TODSEC
        LoadB CIA1_TOD10, 0     ; restart clock

        ; convert from BCD and setup local time
        MoveBCD_B msec, seconds
        MoveBCD_B mmin, minutes
        MoveBCD_B mhour, hour
        MoveBCD_B mday, day
        MoveBCD_B mmonth, month
        MoveBCD_B myear, year
        rts

; read time and date from 1541U2
; If command was successful, returns with carry flag clear, buf contains
; the time/date string.
; If an error occurred, returns with carry flag set, buf contains the error
; message.
.proc get_time
        jsr u2_start_cmd
        lda #$01
        sta U2_COMMAND_ID
        lda #$26            ; 0x26 = DOS_CMD_GET_TIME
        sta U2_COMMAND_ID
        lda #$00            ; 0x00 = format = YYYY/MM/DD HH:MM:SS
        sta U2_COMMAND_ID
        jsr u2_finish_cmd

        ; read from status channel first
        ldx #0
@loop1: jsr u2_get_status
        bcs @end1
        sta buf, x
        inx
        cpx #BUFSIZE-1
        bcc @loop1
@end1:  lda #0
        sta buf, x
        
        ; first 2 bytes of status are the return code as ASCII digits. Anything
        ; other than '00' is an error
        lda buf
        cmp #'0'
        bne @bad
        lda buf+1
        cmp #'0'
        beq @ok
@bad:   sec
        rts

        ; All good, read the data channel
@ok:    ldx #0
@loop2: jsr u2_get_data
        bcs @end2
        sta buf, x
        inx
        cpx #BUFSIZE-1
        bcc @loop2
        clc
@end2:  lda #0
        sta buf, x
        clc
        rts
.endproc

; Parse a YYYY/MM/DD HH:MM:SS string in buf, into consecutive BCD bytes
; Destroys a0L
; Returns number of characters consumed in X, number of values read in Y
.proc parse_time
        ldx #2                  ; first 2 chars of date string are the century, skip them
        ldy #0
@loop:
        lda buf, x
        beq @end                ; give up if we hit a NULL
        sec
        sbc #'0'
        bmi :+                  ; skip character if not a digit
        cmp #10
        bcs :+
        asl                             ; first char is tens, shift to upper nibble
        asl
        asl
        asl
        sta a0L
        inx
        lda buf, x              ; assume second char is a digit
        sec
        sbc #'0'
        ora a0L                 ; OR in saved upper nibble
        sta myear, y    ; store value 
        iny
:       inx
        cpy #6                  ; read 6 values
        bne @loop
@end:   rts
.endproc

; convert BCD in A, output in A. Destroys Y
.proc fromBCD
        pha
        lsr
        lsr
        lsr
        lsr
        tay
        pla
        and #$0f
        clc
:       dey
        bmi :+
        adc #10
        bne :-
:       rts
.endproc

myear:  .byte 0
mmonth: .byte 0
mday:   .byte 0
mhour:  .byte 0
mmin:   .byte 0
msec:   .byte 0

buf:    .res BUFSIZE

.endif  ; rtc_Ultimate2Plus

