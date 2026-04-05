
SUBDIRS = "Configure   V2.0"
APPSDIR = "../$(BUILD_DIR)/apps/"

.EXPORT_ALL_VARIABLES:
	export

all:
	mkdir -p $(APPSDIR)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C "$$dir"; \
	done

regress:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C "$$dir" regress; \
	done

clean:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C "$$dir" clean; \
	done

