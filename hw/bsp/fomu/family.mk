CFLAGS += \
  -flto \
  -march=rv32i \
  -mabi=ilp32 \
  -nostdlib \
  -DCFG_TUSB_MCU=OPT_MCU_VALENTYUSB_EPTRI

# Cross Compiler for RISC-V
CROSS_COMPILE = riscv-none-embed-

# All source paths should be relative to the top level.
LD_FILE = $(FAMILY_PATH)/fomu.ld

SRC_S += $(FAMILY_PATH)/crt0-vexriscv.S

INC += \
	$(TOP)/$(FAMILY_PATH)/include

# For TinyUSB port source
VENDOR = valentyusb
CHIP_FAMILY = eptri

# For freeRTOS port source
FREERTOS_PORT = RISC-V

# flash using dfu-util
$(BUILD)/$(PROJECT).dfu: $(BUILD)/$(PROJECT).bin
	@echo "Create $@"
	python $(TOP)/hw/bsp/$(BOARD)/dfu.py -b $^ -D 0x1209:0x5bf0 $@
	
flash: $(BUILD)/$(PROJECT).dfu
	dfu-util -D $^
