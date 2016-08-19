# GEOS Source Code

by Berkeley Softworks, reverse engineered by Maciej 'YTM/Elysium' Witkowiak; Michael Steil

## Description

This is the reverse engineered source code of the KERNAL as well as disk and input drivers of the English version of GEOS 2.0 for Commodore 64.

The source has been heavily reorganized and modularized, nevertheless, a standard compile will generate binaries that are identical with the GEOS 2.0 distrbution binaries.


## Requirements

* make, bash, dd
* [cc65](https://github.com/cc65/cc65) for assembling and linking
* [pucrunch](https://github.com/mist64/pucrunch) for generating a compressed executable
* [c1541](http://vice-emu.sourceforge.net) for generating the disk image

Without pucrunch/c1541, you can still build an uncompressed KERNAL binary image.

## Building

Run `make` to build GEOS. This will create the following files:

* raw KERNAL components: `kernal.bin`, `lokernal.bin`, `init.bin`
* disk drive drivers: `drv1541.bin`, `drv1571.bin`, `drv1581.bin`
* input drivers: `amigamse.bin`, `joydrv.bin`, `lightpen.bin`, `mse1531.bin`, `koalapad.bin`, `pcanalog.bin`
* combined KERNAL image (`SYS 49155`): `combined.prg`
* compressed KERNAL image (`RUN`): `compressed.prg`
* disk image containing compressed kernel and, optionally, deskTop.: `geos.d64`

## Customization

Look into inc/equ.inc file - there are many true/false defines, you are free
to change them. But read the comments. You can compile-in input and disk
drivers so right after boot you will have your drivers (and you can boot from
1571/81 without any problems). In case that input driver is compiled into
KERNAL you have to delete all input driver files from boot disk, because
DeskTop will try to load the first one overriding compiled driver.
If you have C128 it is worth to enable 2MHz support - CPU is warped into 2MHz
on the border. This is better than add-on that I saw somewhere, because my
version will not flicker anytime and that add-on will not work with this
kernal. (not a single application that modifies GEOS KERNAL directly will not
work).




## Source Tree

* `./drv`: disk drive driver source
* `./inc`: include files: macros and symbols
* `./init`: purgeable KERNAL init source
* `./input`: input driver source
* `./kernal`: kernal source
* `./reference`: original binaries from the cbmfiles.com version

## Copy protection

The original GEOS was copy protected in three ways:

* The original loader [decrypted the KERNAL at load time](http://www.root.org/%7Enate/c64/KrackerJax/pg106.htm) and refused to do so if the floppy disk was a copy. Like the cbmfiles.com version, this version doesn't use the original loader, and the kernel is available in plaintext.
* deskTop assigned a random serial number to the kernel on first boot and keyed all major applications to itself. This version comes with a serial number of 0x58B5 pre-filled, which matches the cbmfiles.com version.
* To counter tampering with the serial number logic, the KERNAL contained [two traps](http://www.pagetable.com/?p=865) that could sabotage the kernel. The code is included in this version, but can be removed by setting trap = 0.

# References

* Farr, M.: [The Official GEOS Programmer's Reference Guide](http://lyonlabs.org/commodore/onrequest/The_Official_GEOS_Programmers_Reference_Guide.pdf) (1987)
* Berkeley Softworks: [The Hitchhiker's Guide to GEOS](http://lyonlabs.org/commodore/onrequest/geos-manuals/The_Hitchhikers_Guide_to_GEOS.pdf) (1988)
* Boyce, A. D.; Zimmerman, B.: [GEOS Programmer's Reference Guide ](http://www.zimmers.net/geos/docs/geotech.txt) (2000)

# Authors

The original reverse-engineering was done by [Maciej Witkowiak](mailto:ytm@elysium.pl) in 1999-2002, targeted the ACME assembler and was released as [GEOS 2000](https://github.com/ytmytm/c64-GEOS2000), which included several code optimizations and code layout differences.

In 2015/2016, [Michael Steil](mailto:mist64@mac.com) ported the sources to cc65, reconstructed the original code layout, did some more reverse-engineering and cleanups, and modularized the code aggressively.