
configure.cvt: *.s geos.cfg
	ca65 "Configure   V2.0.s"
	ca65 -I../../inc -I../../ 10-chain00-boot.s -o boot.o
	ca65 binaries.s
	ld65 -o configure.cvt -Ln configure.lab -m configure.map -C geos.cfg "Configure   V2.0.o" boot.o binaries.o

regress: configure.cvt
	hexdump -Cv configure.cvt > configure.hex
	-diff --suppress-common-lines -y configure.hex configure-reference.hex > configure.diff
	diff --suppress-common-lines -y configure.diff configure-expected.diff


expecteddiff:
	hexdump -Cv "../../reference/bsw/Configure   V2.0.cvt" > configure-reference.hex

clean:
	-rm *.o configure.cvt configure.lab configure.map
