
.include "config.inc"

.segment "OVERLAY1"
.incbin "11-chain01-gui.bin"

.segment "OVERLAY2"
.ifdef regress
.incbin "12-chain02-drv1541.bin"
.else
.incbin "drv/drv1541.bin"
.endif

.segment "OVERLAY3"
.ifdef regress
.incbin "13-chain03-drv1571.bin"
.else
.incbin "drv/drv1571.bin"
.endif

.segment "OVERLAY4"
.ifdef regress
.incbin "14-chain04-drv1581.bin"
.else
.incbin "drv/drv1581.bin"
.endif

.segment "OVERLAY5"
.incbin "15-chain05-drvram.bin" ; should come from ../../drv/
