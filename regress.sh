reference=$1

dd if=/dev/zero bs=1 count=48960 of=tmp.bin
cat kernal.bin >> tmp.bin

dd if=/dev/zero bs=1 count=48960 of=reference/$reference/tmp.bin
cat reference/$reference/kernal.bin >> reference/$reference/tmp.bin

for file in tmp; do
	if [ -e reference/$reference/$file.bin ]; then
		hexdump -C $file.bin > /tmp/$file.txt
		hexdump -C reference/$reference/$file.bin > /tmp/reference_$file.txt
		diff --suppress-common-lines -y /tmp/reference_$file.txt /tmp/$file.txt | head -n 10
	fi
done
