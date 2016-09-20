variant=$1

rm -rf build/compare
mkdir -p build/compare

#
# create a RAM image with KERNAL in $9d80-9fff and $bf40-$fe7f
#
# from our version
dd if=/dev/zero bs=1 count=40320 of=build/compare/kernal.bin 2> /dev/null
cat build/$variant/kernal/kernal.bin /dev/zero | dd bs=1 count=25216 skip=19840 >> build/compare/kernal.bin 2> /dev/null
# from reference version
dd if=/dev/zero bs=1 count=40320 of=build/compare/kernal_reference.bin 2> /dev/null
cat reference/$variant/lokernal.bin /dev/zero | dd bs=1 count=8640 >> build/compare/kernal_reference.bin 2> /dev/null
cat reference/$variant/kernal.bin >> build/compare/kernal_reference.bin

dd if=/dev/zero bs=1 count=49152 of=build/compare/kernal2.bin 2> /dev/null
cat build/$variant/kernal/kernal2.bin >> build/compare/kernal2.bin
dd if=/dev/zero bs=1 count=49152 of=build/compare/kernal2_reference.bin 2> /dev/null
cat reference/$variant/kernal2.bin >> build/compare/kernal2_reference.bin

#
# create RAM images of Wheels "new kernal" extensions at $5000
#
for i in 0 1 2 3 4 5 6 7 8 9 10 11 x; do
	if [ -e build/$variant/kernal/reu$i.bin ]; then
		# from our version
		dd if=/dev/zero bs=1 count=16192 of=build/compare/reu$i.bin 2> /dev/null
		cat build/$variant/kernal/reu$i.bin >> build/compare/reu$i.bin
		# from reference version
		dd if=/dev/zero bs=1 count=16192 of=build/compare/reu${i}_reference.bin 2> /dev/null
		cat reference/$variant/reu$i.bin >> build/compare/reu${i}_reference.bin
	fi
done


for file in kernal kernal2 reu0 reu1 reu2 reu3 reu4 reu5 reu6 reu7 reu8 reu9 reu10 reu11 reux; do
	if [ -e build/compare/$file.bin ]; then
		echo $file
		hexdump -v -C build/compare/$file.bin > build/compare/$file.txt
		hexdump -v -C build/compare/${file}_reference.bin > build/compare/${file}_reference.txt
		diff --suppress-common-lines -y build/compare/${file}_reference.txt build/compare/${file}.txt | head -n 40
		#diff --suppress-common-lines -y build/compare/${file}_reference.txt build/compare/${file}.txt
	fi
done
