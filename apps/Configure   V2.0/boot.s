
.import __STARTUP_RUN__
.global APP_START

.segment "STARTUP"
APP_START = __STARTUP_RUN__+5
.incbin "10-chain00-boot.bin"
