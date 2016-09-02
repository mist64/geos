reference=$1

dd if=/dev/zero bs=1 count=40320 of=tmp.bin
cat lokernal.bin /dev/zero | dd bs=1 count=8640 >> tmp.bin
cat kernal.bin >> tmp.bin

dd if=/dev/zero bs=1 count=40320 of=reference/$reference/tmp.bin
cat reference/$reference/lokernal.bin /dev/zero | dd bs=1 count=8640 >> reference/$reference/tmp.bin
cat reference/$reference/kernal.bin >> reference/$reference/tmp.bin

for file in tmp reu0 reu1 reu2 reu3 reu4 reu5 reu6 reu7 reu8 reu9 reu10 reu11; do
	if [ -e reference/$reference/$file.bin ]; then
		echo $file
		hexdump -C $file.bin > /tmp/$file.txt
		hexdump -C reference/$reference/$file.bin > /tmp/reference_$file.txt
		diff --suppress-common-lines -y /tmp/reference_$file.txt /tmp/$file.txt | head -n 10
	fi
done
