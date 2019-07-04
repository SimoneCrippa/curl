
ifdef CONFIG_EXTERNAL_CURL

# Targets provided by this project
.PHONY: curl clean_curl

# Add this to the "external" target
external: curl
clean_external: clean_curl

MODULE_DIR_CURL=external/optional/curl
VERSION_CURL="7.65.0"

curl:
	@cd ${MODULE_DIR_CURL} && autoreconf -i
	@echo
	@echo "==== Installing curl Library ($(VERSION_CURL)) ===="
	@echo " Using GCC    : $(CC)"
	@echo " Target flags : $(TARGET_FLAGS)"
	@echo " Sysroot      : $(PLATFORM_SYSROOT)"
	@echo " BOSP Options : $(CMAKE_COMMON_OPTIONS)"
	@cd $(MODULE_DIR_CURL) && ./configure --prefix=$(shell pwd)/out
	@cd $(MODULE_DIR_CURL) && \
	    make -j$(CPUS) install || \
	    exit 1

clean_curl:
	@echo "==== Clean-up curl library ===="
	@[ ! -f $(BUILD_DIR)/lib/libcurl.so ] || \
		rm -f $(BUILD_DIR)/lib/libcurl*
		rm -f $(BUILD_DIR)/lib/libcurl-d.so
	@cd $(MODULE_DIR_CURL) && \
		make distclean
else # CONFIG_EXTERNAL_CURL

curl:
	$(warning $(MODULE_DIR_CURL) module disabled by BOSP configuration)
	$(error BOSP compilation failed)

endif # CONFIG_EXTERNAL_CURL