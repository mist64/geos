AS=~/Documents/cc65/bin/ca65
LD=~/Documents/cc65/bin/ld65

ASFLAGS=--include-dir inc

BASE_SOURCES= \
src/booter.s \
src/bswfont.s \
src/icons.s \
src/lokernal.s \
src/patterns.s \
src/unknown.s \
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

DRIVE=src/drv/drv1541.s
#DRIVE=src/drv/drv1571.s
#DRIVE=src/drv/drv1581.s

INPUT=src/input/joydrv.s
#INPUT=src/input/amigamse.s
#INPUT=src/input/lightpen.s
#INPUT=src/input/mse1531.s

SOURCES=$(BASE_SOURCES) $(DRIVE) $(INPUT)

DEPS=inc/const.inc inc/diskdrv.inc inc/equ.inc inc/geosmac.inc inc/geossym.inc inc/kernal.inc inc/printdrv.inc

OBJECTS=$(SOURCES:.s=.o)

all: kernal.bin

clean:
	rm -f $(OBJECTS) kernal.bin

kernal.bin: $(OBJECTS) kernal.cfg
	$(LD) -C kernal.cfg $(OBJECTS) -o $@

%.o: %.s $(DEPS)
	$(AS) $(ASFLAGS) $< -o $@

