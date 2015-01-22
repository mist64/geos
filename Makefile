AS=~/Documents/cc65/bin/ca65
LD=~/Documents/cc65/bin/ld65

ASFLAGS=--include-dir inc

KERNAL_SOURCES= \
src/kernal/init.s \
src/kernal/bswfont.s \
src/kernal/icons.s \
src/kernal/lokernal.s \
src/kernal/patterns.s \
src/kernal/unknown.s \
src/kernal/conio.s \
src/kernal/dlgbox.s \
src/kernal/files.s \
src/kernal/fonts.s \
src/kernal/graph.s \
src/kernal/icon.s \
src/kernal/main.s \
src/kernal/math.s \
src/kernal/memory.s \
src/kernal/menu.s \
src/kernal/mouseio.s \
src/kernal/process.s \
src/kernal/sprites.s \
src/kernal/system.s

DEPS=inc/const.inc inc/diskdrv.inc inc/equ.inc inc/geosmac.inc inc/geossym.inc inc/kernal.inc inc/printdrv.inc

KERNAL_OBJECTS=$(KERNAL_SOURCES:.s=.o)

all: kernal.bin drv1541.bin drv1571.bin drv1581.bin amigamse.bin joydrv.bin lightpen.bin mse1531.bin

clean:
	rm -f $(KERNAL_OBJECTS) kernal.bin drv1541.bin drv1571.bin drv1581.bin amigamse.bin joydrv.bin lightpen.bin mse1531.bin

kernal.bin: $(KERNAL_OBJECTS) src/kernal/kernal.cfg
	$(LD) -C src/kernal/kernal.cfg $(KERNAL_OBJECTS) -o $@

drv1541.bin: src/drv/drv1541.o src/drv/drv1541.cfg
	$(LD) -C src/drv/drv1541.cfg src/drv/drv1541.o -o $@

drv1571.bin: src/drv/drv1571.o src/drv/drv1571.cfg
	$(LD) -C src/drv/drv1571.cfg src/drv/drv1571.o -o $@

drv1581.bin: src/drv/drv1581.o src/drv/drv1581.cfg
	$(LD) -C src/drv/drv1581.cfg src/drv/drv1581.o -o $@

amigamse.bin: src/input/amigamse.o src/input/amigamse.cfg
	$(LD) -C src/input/amigamse.cfg src/input/amigamse.o -o $@

joydrv.bin: src/input/joydrv.o src/input/joydrv.cfg
	$(LD) -C src/input/joydrv.cfg src/input/joydrv.o -o $@

lightpen.bin: src/input/lightpen.o src/input/lightpen.cfg
	$(LD) -C src/input/lightpen.cfg src/input/lightpen.o -o $@

mse1531.bin: src/input/mse1531.o src/input/mse1531.cfg
	$(LD) -C src/input/mse1531.cfg src/input/mse1531.o -o $@

%.o: %.s $(DEPS)
	$(AS) $(ASFLAGS) $< -o $@

