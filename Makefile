
VARIANT     ?= bsw
DRIVE       ?= drv1541
INPUT       ?= joydrv

AS           = ca65
LD           = ld65
C1541        = c1541
PUCRUNCH     = pucrunch
D64_TEMPLATE = GEOS64.D64
D64_RESULT   = geos.d64
DESKTOP_CVT  = desktop.cvt

ASFLAGS      = -I inc -I .

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
	kernal/ramexp.s \
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
	kernal/wheels/loadb.s \
	kernal/wheels/tobasicb.s \
	kernal/wheels/reux.s \

DRIVER_SOURCES= \
	drv/drv1541.bin \
	drv/drv1571.bin \
	drv/drv1581.bin \
	input/joydrv.bin \
	input/amigamse.bin \
	input/lightpen.bin \
	input/mse1531.bin \
	input/koalapad.bin \
	input/pcanalog.bin

DEPS= \
	config.inc \
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
DRIVER_OBJS=$(DRIVER_SOURCES:.s=.o)
ALL_OBJS=$(KERNAL_OBJS) $(DRIVER_OBJS)

BUILD_DIR=build/$(VARIANT)

PREFIXED_KERNAL_OBJS = $(addprefix $(BUILD_DIR)/, $(KERNAL_OBJS))

ALL_BINS= \
	$(BUILD_DIR)/kernal/kernal.bin \
	$(BUILD_DIR)/drv/drv1541.bin \
	$(BUILD_DIR)/drv/drv1571.bin \
	$(BUILD_DIR)/drv/drv1581.bin \
	$(BUILD_DIR)/input/joydrv.bin \
	$(BUILD_DIR)/input/amigamse.bin \
	$(BUILD_DIR)/input/lightpen.bin \
	$(BUILD_DIR)/input/mse1531.bin \
	$(BUILD_DIR)/input/koalapad.bin \
	$(BUILD_DIR)/input/pcanalog.bin


all: $(BUILD_DIR)/$(D64_RESULT)

regress:
	@echo "********** Building variant 'bsw'"
	@$(MAKE) VARIANT=bsw all
	./regress.sh bsw
	@echo "********** Building variant 'wheels'"
	@$(MAKE) VARIANT=wheels all
	./regress.sh wheels

clean:
	rm -rf build

$(BUILD_DIR)/$(D64_RESULT): $(BUILD_DIR)/kernal_compressed.prg
	@if [ -e $(D64_TEMPLATE) ]; then \
		cp $(D64_TEMPLATE) $@; \
		echo delete geos geoboot | $(C1541) $@ >/dev/null; \
		echo write $< geos | $(C1541) $@ >/dev/null; \
		echo \*\*\* Created $@ based on $(D64_TEMPLATE).; \
	else \
		echo format geos,00 d64 $@ | $(C1541) >/dev/null; \
		echo write $< geos | $(C1541) $@ >/dev/null; \
		if [ -e $(DESKTOP_CVT) ]; then echo geoswrite $(DESKTOP_CVT) | $(C1541) $@; fi >/dev/null; \
		echo \*\*\* Created fresh $@.; \
	fi;

$(BUILD_DIR)/kernal_compressed.prg: $(BUILD_DIR)/kernal_combined.prg
	@echo Creating $@
	$(PUCRUNCH) -f -c64 -x0x5000 $< $@ 2> /dev/null

$(BUILD_DIR)/kernal_combined.prg: $(ALL_BINS)
	@echo Creating $@ from kernal.bin $(DRIVE).bin $(INPUT).bin
	@printf "\x00\x50" > $(BUILD_DIR)/tmp.bin
	@dd if=$(BUILD_DIR)/kernal/kernal.bin bs=1 count=16384 >> $(BUILD_DIR)/tmp.bin 2> /dev/null
	@cat $(BUILD_DIR)/drv/$(DRIVE).bin /dev/zero | dd bs=1 count=3456 >> $(BUILD_DIR)/tmp.bin 2> /dev/null
	@cat $(BUILD_DIR)/kernal/kernal.bin /dev/zero | dd bs=1 count=24832 skip=19840 >> $(BUILD_DIR)/tmp.bin 2> /dev/null
	@cat $(BUILD_DIR)/input/$(INPUT).bin >> $(BUILD_DIR)/tmp.bin 2> /dev/null
	@mv $(BUILD_DIR)/tmp.bin $(BUILD_DIR)/kernal_combined.prg

$(BUILD_DIR)/drv/drv1541.bin: $(BUILD_DIR)/drv/drv1541.o drv/drv1541.cfg $(DEPS)
	$(LD) -C drv/drv1541.cfg $(BUILD_DIR)/drv/drv1541.o -o $@

$(BUILD_DIR)/drv/drv1571.bin: $(BUILD_DIR)/drv/drv1571.o drv/drv1571.cfg $(DEPS)
	$(LD) -C drv/drv1571.cfg $(BUILD_DIR)/drv/drv1571.o -o $@

$(BUILD_DIR)/drv/drv1581.bin: $(BUILD_DIR)/drv/drv1581.o drv/drv1581.cfg $(DEPS)
	$(LD) -C drv/drv1581.cfg $(BUILD_DIR)/drv/drv1581.o -o $@

$(BUILD_DIR)/input/amigamse.bin: $(BUILD_DIR)/input/amigamse.o input/amigamse.cfg $(DEPS)
	$(LD) -C input/amigamse.cfg $(BUILD_DIR)/input/amigamse.o -o $@

$(BUILD_DIR)/input/joydrv.bin: $(BUILD_DIR)/input/joydrv.o input/joydrv.cfg $(DEPS)
	$(LD) -C input/joydrv.cfg $(BUILD_DIR)/input/joydrv.o -o $@

$(BUILD_DIR)/input/lightpen.bin: $(BUILD_DIR)/input/lightpen.o input/lightpen.cfg $(DEPS)
	$(LD) -C input/lightpen.cfg $(BUILD_DIR)/input/lightpen.o -o $@

$(BUILD_DIR)/input/mse1531.bin: $(BUILD_DIR)/input/mse1531.o input/mse1531.cfg $(DEPS)
	$(LD) -C input/mse1531.cfg $(BUILD_DIR)/input/mse1531.o -o $@

$(BUILD_DIR)/input/koalapad.bin: $(BUILD_DIR)/input/koalapad.o input/koalapad.cfg $(DEPS)
	$(LD) -C input/koalapad.cfg $(BUILD_DIR)/input/koalapad.o -o $@

$(BUILD_DIR)/input/pcanalog.bin: $(BUILD_DIR)/input/pcanalog.o input/pcanalog.cfg $(DEPS)
	$(LD) -C input/pcanalog.cfg $(BUILD_DIR)/input/pcanalog.o -o $@

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(AS) -D $(VARIANT)=1 -D $(DRIVE)=1 -D $(INPUT)=1 $(ASFLAGS) $< -o $@

$(BUILD_DIR)/kernal/kernal.bin: $(PREFIXED_KERNAL_OBJS) kernal/kernal_$(VARIANT).cfg
	@mkdir -p $$(dirname $@)
	$(LD) -C kernal/kernal_$(VARIANT).cfg $(PREFIXED_KERNAL_OBJS) -o $@ -m $(BUILD_DIR)/kernal/kernal.map

# a must!
love:	
	@echo "Not war, eh?"
