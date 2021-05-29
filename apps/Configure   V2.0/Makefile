
configure.cvt: *.s geos.cfg
	ca65 "Configure   V2.0.s"
	ca65 boot.s
	ca65 binaries.s
	ld65 -o configure.cvt -Ln configure.lab -m configure.map -C geos.cfg "Configure   V2.0.o" boot.o binaries.o

clean:
	@rm *.o configure.cvt configure.lab configure.map
