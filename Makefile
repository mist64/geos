
TARGET ?= bsw

AS=ca65
LD=ld65

ASFLAGS=-I inc -I .

KERNAL_SOURCES= \
	kernal/bitmask.s \
	kernal/bswfont.s \
	kernal/conio.s \
	kernal/dlgbox.s \
	kernal/filesys.s \
	kernal/fonts.s \
	kernal/graph.s \
	kernal/header.s \
	kernal/hw.s \
	kernal/icon.s \
	kernal/init.s \
	kernal/irq.s \
	kernal/jumptable.s \
	kernal/keyboard.s \
	kernal/load.s \
	kernal/mainloop.s \
	kernal/math.s \
	kernal/memory.s \
	kernal/menu.s \
	kernal/misc.s \
	kernal/mouse.s \
	kernal/panic.s \
	kernal/patterns.s \
	kernal/process.s \
	kernal/reu.s \
	kernal/serial.s \
	kernal/sprites.s \
	kernal/start.s \
	kernal/time.s \
	kernal/tobasic.s \
	kernal/vars.s \
	kernal/wheels/wheels.s \
	kernal/wheels/ram.s \
	kernal/wheels/devnum.s \
	kernal/wheels/format.s \
	kernal/wheels/partition.s \
	kernal/wheels/directory.s \
	kernal/wheels/validate.s \
	kernal/wheels/copydisk.s \
	kernal/wheels/copyfile.s \
	kernal/wheels/load2.s \
	kernal/wheels/tobasic2.s \
	kernal/wheels/reux.s \

DEPS= \
	inc/c64.inc \
	inc/const.inc \
	inc/diskdrv.inc \
	inc/geosmac.inc \
	inc/geossym.inc \
	inc/inputdrv.inc \
	inc/jumptab.inc \
	inc/kernal.inc \
	inc/printdrv.inc

KERNAL_OBJS=$(KERNAL_SOURCES:.s=.o)

BUILD_DIR=build/$(TARGET)

OBJS = $(addprefix $(BUILD_DIR)/, $(KERNAL_OBJS))

ALL_BINS= \
	$(BUILD_DIR)/kernal/kernal.bin \

#	drv1541.bin \
#	drv1571.bin \
#	drv1581.bin \
#	amigamse.bin \
#	joydrv.bin \
#	lightpen.bin \
#	mse1531.bin \
#	koalapad.bin \
#	pcanalog.bin


all: geos.d64

all_targets:
	$(MAKE) TARGET=bsw all
	$(MAKE) TARGET=wheels all

clean:
	rm -rf build

geos.d64: compressed.prg
	if [ -e GEOS64.D64 ]; then \
		cp GEOS64.D64 geos.d64; \
		echo delete geos geoboot | c1541 geos.d64 >/dev/null; \
		echo write compressed.prg geos | c1541 geos.d64 >/dev/null; \
		echo \*\*\* Created geos.d64 based on GEOS64.D64.; \
	else \
		echo format geos,00 d64 geos.d64 | c1541 >/dev/null; \
		echo write compressed.prg geos | c1541 geos.d64 >/dev/null; \
		if [ -e desktop.cvt ]; then echo geoswrite desktop.cvt | c1541 geos.d64; fi >/dev/null; \
		echo \*\*\* Created fresh geos.d64.; \
	fi;

compressed.prg: combined.prg
	pucrunch -f -c64 -x0x5000 $< $@

combined.prg: $(ALL_BINS)
	printf "\x00\x50" > tmp.bin
	cat build/bin/start.bin /dev/zero | dd bs=1 count=16384 >> build/bin/tmp.bin 2> /dev/null
	cat build/bin/drv1541.bin /dev/zero | dd bs=1 count=3456 >> build/bin/tmp.bin 2> /dev/null
	cat build/bin/lokernal.bin /dev/zero | dd bs=1 count=8640 >> build/bin/tmp.bin 2> /dev/null
	cat build/bin/kernal.bin /dev/zero | dd bs=1 count=16192 >> build/bin/tmp.bin 2> /dev/null
	cat build/bin/joydrv.bin >> build/bin/tmp.bin 2> /dev/null
	mv build/bin/tmp.bin build/bin/combined.prg

build/bin/drv1541.bin: drv/drv1541.o drv/drv1541.cfg $(DEPS)
	$(LD) -C drv/drv1541.cfg drv/drv1541.o -o $@

build/bin/drv1571.bin: drv/drv1571.o drv/drv1571.cfg $(DEPS)
	$(LD) -C drv/drv1571.cfg drv/drv1571.o -o $@

build/bin/drv1581.bin: drv/drv1581.o drv/drv1581.cfg $(DEPS)
	$(LD) -C drv/drv1581.cfg drv/drv1581.o -o $@

build/bin/amigamse.bin: input/amigamse.o input/amigamse.cfg $(DEPS)
	$(LD) -C input/amigamse.cfg input/amigamse.o -o $@

build/bin/joydrv.bin: input/joydrv.o input/joydrv.cfg $(DEPS)
	$(LD) -C input/joydrv.cfg input/joydrv.o -o $@

build/bin/lightpen.bin: input/lightpen.o input/lightpen.cfg $(DEPS)
	$(LD) -C input/lightpen.cfg input/lightpen.o -o $@

build/bin/mse1531.bin: input/mse1531.o input/mse1531.cfg $(DEPS)
	$(LD) -C input/mse1531.cfg input/mse1531.o -o $@

build/bin/koalapad.bin: input/koalapad.o input/koalapad.cfg $(DEPS)
	$(LD) -C input/koalapad.cfg input/koalapad.o -o $@

build/bin/pcanalog.bin: input/pcanalog.o input/pcanalog.cfg $(DEPS)
	$(LD) -C input/pcanalog.cfg input/pcanalog.o -o $@

$(BUILD_DIR)/%.o $(BSW_BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(AS) -D $(TARGET)=1 $(ASFLAGS) $< -o $@

$(BUILD_DIR)/kernal/kernal.bin: $(OBJS) kernal/kernal_$(TARGET).cfg
	@mkdir -p $$(dirname $@)
	$(LD) -C kernal/kernal_$(TARGET).cfg $(OBJS) -o $@ -m $(BUILD_DIR)/kernal/kernal.map

# a must!
love:	
	@echo "Not war, eh?"
