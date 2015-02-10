hexdump -C lokernal.bin > /tmp/lokernal.txt
hexdump -C reference/lokernal.bin > /tmp/reference_lokernal.txt
diff -u /tmp/reference_lokernal.txt /tmp/lokernal.txt

hexdump -C kernal.bin > /tmp/kernal.txt
hexdump -C reference/kernal.bin > /tmp/reference_kernal.txt
diff -u /tmp/reference_kernal.txt /tmp/kernal.txt

hexdump -C joydrv.bin > /tmp/joydrv.txt
hexdump -C reference/joydrv.bin > /tmp/reference_joydrv.txt
diff -u /tmp/reference_joydrv.txt /tmp/joydrv.txt

hexdump -C drv1541.bin > /tmp/drv1541.txt
hexdump -C reference/drv1541.bin > /tmp/reference_drv1541.txt
diff -u /tmp/reference_drv1541.txt /tmp/drv1541.txt
