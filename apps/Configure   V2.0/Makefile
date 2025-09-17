
AS	?= ca65
LD	?= ld65
APPSDIR ?= ..

ASFLAGS	+=-I../../inc -I../../

configure.cvt: *.s geos.cfg
	$(AS) "Configure   V2.0.s"
	$(AS) -D $(VARIANT)=1 -D $(DRIVE)=1 $(ASFLAGS) 10-chain00-boot.s -o boot.o
	$(AS) -D $(VARIANT)=1 -D $(DRIVE)=1 $(ASFLAGS) --bin-include-dir ../$(APPSDIR)/../ binaries.s
	$(LD) -o configure.cvt -Ln configure.lab -m configure.map -C geos.cfg "Configure   V2.0.o" boot.o binaries.o
	cp *.cvt "../$(APPSDIR)"

all: configure.cvt

regress: configure.cvt
	$(AS) "Configure   V2.0.s"
	$(AS) -D bsw=1 -D drv1541=1 -D regress=1 $(ASFLAGS) 10-chain00-boot.s -o boot.o
	$(AS) -D bsw=1 -D drv1541=1 -D regress=1 $(ASFLAGS) binaries.s
	$(LD) -o configure.cvt -Ln configure.lab -m configure.map -C geos.cfg "Configure   V2.0.o" boot.o binaries.o
	hexdump -Cv configure.cvt > configure.hex
	-diff --suppress-common-lines -y configure.hex configure-reference.hex > configure.diff || true
	diff --suppress-common-lines -y configure.diff configure-expected.diff


expecteddiff:
	hexdump -Cv "../../reference/bsw/Configure   V2.0.cvt" > configure-reference.hex

clean:
	-rm *.o configure.cvt configure.lab configure.map
