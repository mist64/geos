#
# Make it all go round...
#
# Maciej Witkowiak

all:
	@echo "Compiling system..."
	acme -vv geos.tas
	@echo "You now have geoskernal.bin file, we'll PUCrunch it..."
	pucrunch -f -c64 -x0x5000 geoskern.bin geoskern.puc
	@echo "And we'll try to make a .d64 image using c1541"
	c1541 <c1541.in >/dev/null

clean:
	rm geosboot.d64
	rm geoskern.*

# a must!
love:	
	@echo "Not war, eh?"
