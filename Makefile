AS=ca65
LD=ld65

ASFLAGS=-I inc -I .

KERNAL_SOURCES= \
init/init.s \
kernal/init.s \
kernal/misc.s \
kernal/bitmask.s \
kernal/bswfont.s \
kernal/mouseptr.s \
kernal/patterns.s \
kernal/conio.s \
kernal/dlgbox.s \
kernal/files.s \
kernal/fonts.s \
kernal/graph.s \
kernal/hw.s \
kernal/icon.s \
kernal/jumptable.s \
kernal/keyboard.s \
kernal/header.s \
kernal/mainloop.s \
kernal/math.s \
kernal/memory.s \
kernal/menu.s \
kernal/mouse.s \
kernal/panic.s \
kernal/process.s \
kernal/reu.s \
kernal/serial.s \
kernal/sprites.s \
kernal/irq.s \
kernal/time.s \
kernal/tobasic.s

DEPS=inc/const.inc inc/diskdrv.inc inc/equ.inc inc/geosmac.inc inc/geossym.inc inc/kernal.inc inc/printdrv.inc

KERNAL_OBJECTS=$(KERNAL_SOURCES:.s=.o)

ALL_BINS=boot.bin kernal.bin lokernal.bin init.bin drv1541.bin drv1571.bin drv1581.bin amigamse.bin joydrv.bin lightpen.bin mse1531.bin koalapad.bin pcanalog.bin combined.prg compressed.prg geos.d64

all: geos.d64 boot.bin

clean:
	rm -f $(KERNAL_OBJECTS) drv/*.o input/*.o $(ALL_BINS) combined.prg

geos.d64: compressed.prg
	c1541 <c1541.in >/dev/null

compressed.prg: combined.prg
	pucrunch -f -c64 -x0x5000 $< $@

combined.prg: $(ALL_BINS)
	printf "\x00\x50" > tmp.bin
	cat init.bin /dev/zero | dd bs=1 count=16384 >> tmp.bin
	cat drv1541.bin /dev/zero | dd bs=1 count=3456 >> tmp.bin
	cat lokernal.bin /dev/zero | dd bs=1 count=8640 >> tmp.bin
	cat kernal.bin /dev/zero | dd bs=1 count=16192 >> tmp.bin
	cat joydrv.bin >> tmp.bin
	mv tmp.bin combined.prg

kernal.bin: $(KERNAL_OBJECTS) kernal/kernal.cfg
	$(LD) -C kernal/kernal.cfg $(KERNAL_OBJECTS) -o $@ -m kernal.map

lokernal.bin: kernal.bin

init.bin: kernal.bin

boot.bin: boot.o boot.cfg
	ld65 -C boot.cfg boot.o -o boot.bin

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

koalapad.bin: input/koalapad.o input/koalapad.cfg
	$(LD) -C input/koalapad.cfg input/koalapad.o -o $@

pcanalog.bin: input/pcanalog.o input/pcanalog.cfg
	$(LD) -C input/pcanalog.cfg input/pcanalog.o -o $@

%.o: %.s $(DEPS)
	$(AS) $(ASFLAGS) $< -o $@

# a must!
love:	
	@echo "Not war, eh?"
