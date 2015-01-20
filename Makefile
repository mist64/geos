AS=~/Documents/cc65/bin/ca65
LD=~/Documents/cc65/bin/ld65

ASFLAGS=--include-dir inc

BASE_SOURCES= \
src/booter.tas \
src/bswfont.tas \
src/icons.tas \
src/lokernal.tas \
src/patterns.tas \
src/unknown.tas \
src/kernal/conio.tas \
src/kernal/dlgbox.tas \
src/kernal/files.tas \
src/kernal/fonts.tas \
src/kernal/graph.tas \
src/kernal/icon.tas \
src/kernal/main.tas \
src/kernal/math.tas \
src/kernal/memory.tas \
src/kernal/menu.tas \
src/kernal/mouseio.tas \
src/kernal/process.tas \
src/kernal/sprites.tas \
src/kernal/system.tas

DRIVE=src/drv/drv1541.tas
#DRIVE=src/drv/drv1571.tas
#DRIVE=src/drv/drv1581.tas

INPUT=src/input/joydrv.tas
#INPUT=src/input/amigamse.tas
#INPUT=src/input/lightpen.tas
#INPUT=src/input/mse1531.tas

SOURCES=$(BASE_SOURCES) $(DRIVE) $(INPUT)

DEPS=inc/const.inc inc/diskdrv.inc inc/equ.inc inc/geosmac.inc inc/geossym.inc inc/kernal.inc inc/printdrv.inc

OBJECTS=$(SOURCES:.tas=.o)

all: kernal.bin

clean:
	rm -f $(OBJECTS) kernal.bin

kernal.bin: $(OBJECTS) kernal.cfg
	$(LD) -C kernal.cfg $(OBJECTS) -o $@

%.o: %.tas $(DEPS)
	$(AS) $(ASFLAGS) $< -o $@

