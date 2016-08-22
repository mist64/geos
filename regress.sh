reference=$1

for file in kernal joydrv drv1541; do
	if [ -e reference/$reference/$file.bin ]; then
		hexdump -C $file.bin > /tmp/$file.txt
		hexdump -C reference/$reference/$file.bin > /tmp/reference_$file.txt
		diff -u /tmp/reference_$file.txt /tmp/$file.txt | head -n 90
	fi
done
