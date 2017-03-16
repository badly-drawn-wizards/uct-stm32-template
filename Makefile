$(shell mkdir -p dist)
$(shell mkdir -p dist/vendor)

# Listing of source files
PROJECT_FILES = main.c

# Directories to configure
OPENOCD_DIR = /usr/share/openocd
STM_PERIPH_DIR = vendor/STM32F0xx_StdPeriph_Lib_V1.5.0

TOOLCHAIN_LIBS_ARCH_LINUX = -L/usr/arm-none-eabi/lib/armv6-m -L/usr/lib/gcc/arm-none-eabi/6.3.0/armv6-m
TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS_ARCH_LINUX)

# Dark Magic
PROJECT_LIBS =
LIBS = $(TOOLCHAIN_LIBS) -lgcc $(PROJECT_LIBS)

OTHER_FILES = system_stm32f0xx.c startup_stm32f051.s
C_FILES = $(OTHER_FILES) $(PROJECT_FILES)
OBJ_FILES = $(patsubst %.s,dist/%.o,$(patsubst %.c,dist/%.o,$(C_FILES)))

LINKER_FILE = linker.ld
ELF_FILE = dist/main.elf

STM_PERIPH_INCLUDES = -I"$(STM_PERIPH_DIR)/Libraries/CMSIS/Include" -I"$(STM_PERIPH_DIR)/Libraries/CMSIS/Device/ST/STM32F0xx/Include"
INCLUDES = -Isrc $(STM_PERIPH_INCLUDES)

CPU_FLAGS = -mcpu=cortex-m0 -mthumb -DSTM32F051
C_FLAGS = $(CPU_FLAGS) -g
LD_FLAGS = -T $(LINKER_FILE) -nostartfiles
OPENOCD_FLAGS = -f $(OPENOCD_DIR)/scripts/interface/stlink-v2.cfg -f $(OPENOCD_DIR)/scripts/target/stm32f0x.cfg
GDB_FLAGS = -x gdb.txt

CC = arm-none-eabi-gcc $(C_FLAGS)
LD = arm-none-eabi-ld $(LD_FLAGS)
OPENOCD = openocd $(OPENOCD_FLAGS)
GDB = arm-none-eabi-gdb $(GDB_FLAGS)

.PHONY: all clean build openocd debug

all: clean build debug

$(ELF_FILE): $(OBJ_FILES)
	$(LD) $(INCLUDES) -o $@ $^ $(LIBS)

dist/%.o: src/%.c
	$(CC) $(INCLUDES) -o $@ -c $<
dist/%.o: src/%.s
	$(CC) $(INCLUDES) -o $@ -c $<
dist/system_stm32f0xx.o: vendor/STM32F0xx_StdPeriph_Lib_V1.5.0/Projects/STM32F0xx_StdPeriph_Templates/system_stm32f0xx.c
	$(CC) $(INCLUDES) -o $@ -c $<
dist/startup_stm32f051.o: vendor/STM32F0xx_StdPeriph_Lib_V1.5.0/Libraries/CMSIS/Device/ST/STM32F0xx/Source/Templates/gcc_ride7/startup_stm32f051.s
	$(CC) $(INCLUDES) -o $@ -c $<

clean:
	-rm -r dist/*

build: $(ELF_FILE)

openocd:
	$(OPENOCD)

debug: $(ELF_FILE)
	$(GDB) $<
