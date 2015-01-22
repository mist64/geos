AS=~/Documents/cc65/bin/ca65
LD=~/Documents/cc65/bin/ld65

ASFLAGS=--include-dir inc

KERNAL_SOURCES= \
kernal/init.s \
kernal/bswfont.s \
kernal/icons.s \
kernal/lokernal.s \
kernal/patterns.s \
kernal/unknown.s \
kernal/conio.s \
kernal/dlgbox.s \
kernal/files.s \
kernal/fonts.s \
kernal/graph.s \
kernal/icon.s \
kernal/main.s \
kernal/math.s \
kernal/memory.s \
kernal/menu.s \
kernal/mouseio.s \
kernal/process.s \
kernal/sprites.s \
kernal/system.s

DEPS=inc/const.inc inc/diskdrv.inc inc/equ.inc inc/geosmac.inc inc/geossym.inc inc/kernal.inc inc/printdrv.inc

KERNAL_OBJECTS=$(KERNAL_SOURCES:.s=.o)

ALL_BINS=kernal.bin drv1541.bin drv1571.bin drv1581.bin amigamse.bin joydrv.bin lightpen.bin mse1531.bin combined.prg compressed.prg geos.d64

all: geos.d64

clean:
	rm -f $(KERNAL_OBJECTS) drv/*.o input/*.o $(ALL_BINS) combined.prg

geos.d64: compressed.prg
	c1541 <c1541.in >/dev/null

compressed.prg: combined.prg
	pucrunch -f -c64 -x0x5000 $< $@

combined.prg: $(ALL_BINS)
	printf "\x00\x50" > tmp.bin
	dd if=kernal.bin bs=1 count=16384 >> tmp.bin
	cat drv1541.bin /dev/zero | dd bs=1 count=3456 >> tmp.bin
	cat kernal.bin /dev/zero | dd bs=1 skip=19840 count=24832 >> tmp.bin
	cat joydrv.bin >> tmp.bin
	mv tmp.bin combined.prg

kernal.bin: $(KERNAL_OBJECTS) kernal/kernal.cfg
	$(LD) -C kernal/kernal.cfg $(KERNAL_OBJECTS) -o $@

drv1541.bin: drv/drv1541.o drv/drv1541.cfg
	$(LD) -C drv/drv1541.cfg drv/drv1541.o -o $@

drv1571.bin: drv/drv1571.o drv/drv1571.cfg
	$(LD) -C drv/drv1571.cfg drv/drv1571.o -o $@

drv1581.bin: drv/drv1581.o drv/drv1581.cfg
	$(LD) -C drv/drv1581.cfg drv/drv1581.o -o $@

amigamse.bin: input/amigamse.o input/amigamse.cfg
	$(LD) -C input/amigamse.cfg input/amigamse.o -o $@

joydrv.bin: input/joydrv.o input/joydrv.cfg
	$(LD) -C input/joydrv.cfg input/joydrv.o -o $@

lightpen.bin: input/lightpen.o input/lightpen.cfg
	$(LD) -C input/lightpen.cfg input/lightpen.o -o $@

mse1531.bin: input/mse1531.o input/mse1531.cfg
	$(LD) -C input/mse1531.cfg input/mse1531.o -o $@

%.o: %.s $(DEPS)
	$(AS) $(ASFLAGS) $< -o $@

# a must!
love:	
	@echo "Not war, eh?"
