
;GEOS macros
;reassembled for 6502TASM/MMS by Maciej 'YTM/Alliance' Witkowiak
;4-2-99

;16.06.1999 - ACME port
;17.08.1999 - ACME revision (v0.07)

	!macro LoadB .dest, .value {
	    lda #.value
	    sta .dest
	}
	
	!macro LoadW .dest, .value {
	    +LoadB .dest+1, >.value
	    !if (>.value)!=(<.value) {
		lda #<.value }
	    sta .dest+0
	}
	
	!macro MoveB .source, .dest {
	    lda .source
	    sta .dest
	}
	
	!macro MoveW .source, .dest {
	    +MoveB .source+1, .dest+1
	    +MoveB .source+0, .dest+0
	}

	!macro add .source {
	    clc
	    adc .source
	}
	
	!macro AddB .source, .dest {
	    lda .source
	    +add .dest
	    sta .dest
	}
	
	!macro AddW .source, .dest {
	    +AddB .source+0, .dest+0
	    lda .source+1
	    adc .dest+1
	    sta .dest+1
	}
	
	!macro AddVB .value, .dest {
	    lda .dest
	    clc
	    adc #.value
	    sta .dest
	}
	
	!macro AddVW .value, .dest {
	    +AddVB <.value, .dest+0
	    !if (>.value)=0 {
		bcc .j
		inc .dest+1
		.j
	    } else { 	 
		lda #>.value
		adc .dest + 1
		sta .dest + 1
		}
	}

	!macro sub .source {
	    sec
	    sbc .source
	}
	
	!macro SubB .source, .dest {
	    lda .dest
	    +sub .source
	    sta .dest
	}
	
	!macro SubW .source, .dest {
	    +SubB .source+0, .dest+0
	    lda .dest+1
	    sbc .source+1
	    sta .dest+1
	}
	
	!macro SubVW .value, .dest {
	    sec
	    lda .dest+0
	    sbc #<.value
	    sta .dest+0
	    lda .dest+1
	    sbc #>.value
	    sta .dest+1
	}
	
	!macro CmpB .source, .dest {
	    lda .source
	    cmp .dest
	}
	
	!macro CmpBI .source, .immed {
	    lda .source
	    cmp #.immed
	}
	
	!macro CmpW .source, .dest {
	    +CmpB .source+1, .dest+1
	    bne .j
	    +CmpB .source+0, .dest+0
	.j
	}
	    
	!macro CmpWI .source, .immed {
	    +CmpBI .source+1, >.immed
	    bne .j
	    +CmpBI .source+0, <.immed
	.j
	}
	
	!macro PushB .source {
	    lda .source
	    pha
	}
	
	!macro PushW .source {
	    +PushB .source+1
	    +PushB .source+0
	}
	
	!macro PopB .dest {
	    pla
	    sta .dest
	}
	
	!macro PopW .dest {
	    +PopB .dest+0
	    +PopB .dest+1
	}
	
	!macro bra .addr {
	    clv
	    bvc .addr
	}
	
	!macro smb .bitN, .dest {
	    pha
	    lda #1 << .bitN
	    ora .dest
	    sta .dest
	    pla
	}
	
	!macro smbf .bitN, .dest {
	    lda #1 << .bitN
	    ora .dest
	    sta .dest
	}
	
	!macro rmb .bitN, .dest {
	    pha
	    lda #(1 << .bitN) XOR $ff
	    and .dest
	    sta .dest
	    pla
	}
	
	!macro rmbf .bitN, .dest {
	    lda #(1 << .bitN) XOR $ff
	    and .dest
	    sta .dest
	}
	
	!macro bbs .bitN, .source, .addr {
	    php
	    pha
	    lda .source
	    and #1 << .bitN
	    beq .j
	    pla
	    plp
	    +bra .addr
	.j	
	    pla
	    plp
	}
	
	!macro bbsf .bitN, .source, .addr {
	    !if (.bitN = 7) {
		bit .source
		bmi .addr 
		} else {
		!if (.bitN = 6) {
		        bit .source
			bvs .addr
		    } else {
			lda .source
			and #1 << .bitN
			bne .addr
			}
		    }
	}
	
	!macro bbr .bitN, .source, .addr {
	    php
	    pha
	    lda .source
	    and #1 << .bitN
	    bne .j
	    pla
	    plp
	    +bra .addr
	.j	
	    pla
	    plp
	}
	
	!macro bbrf .bitN, .source, .addr {
	    !if (.bitN = 7) {
		bit .source
		bpl .addr
		} else {
		!if (.bitN = 6) {
			bit .source
			bvc .addr
		} else {
		        lda .source
			and #1 << .bitN
			beq .addr
			}
		}
	}
	
;not part of original macro set
;03.03.1999 by Maciej Witkowiak

	!macro addv .value {
	    clc
	    adc #.value
	}
	
	!macro subv .value {
	    sec
	    sbc #.value
	}
	
	!macro bnex .addr {
	    txa
    	    bne .addr
	}
	
	!macro beqx .addr {
	    txa
	    beq .addr
	}