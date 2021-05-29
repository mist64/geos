
.segment "OVERLAY1"
.incbin "11-chain01-gui.bin"

.segment "OVERLAY2"
.incbin "12-chain02-drv1541.bin" ; should come from ../../drv/

.segment "OVERLAY3"
.incbin "13-chain03-drv1571.bin" ; should come from ../../drv/

.segment "OVERLAY4"
.incbin "14-chain04-drv1581.bin" ; should come from ../../drv/

.segment "OVERLAY5"
.incbin "15-chain05-drvram.bin" ; should come from ../../drv/
