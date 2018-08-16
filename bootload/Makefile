# configure
ADDNAME = llvm-

AR      = $(ADDNAME)ar
AS 			= $(ADDNAME)as  -target aarch64-elf 
CC 			= clang  -target aarch64-elf 
LD 			= ld.lld
NM      = $(ADDNAME)nm
OBJCOPY = $(ADDNAME)objcopy-6.0
OBJDUMP = $(ADDNAME)objdump
RANLIB  = $(ADDNAME)ranlib
STRIP = 	$(OBJCOPY) -strip-all

QEMU = qemu-system-aarch64
GDB  = aarch64-elf-gdb

OBJS  = vector.o startup.o intr.o main.o interrupt.o
OBJS += lib.o serial.o xmodem.o elf.o

TARGET = kzload

CFLAGS = -Wall -mcpu=cortex-a53 -marm -nostdinc -nostdlib -fno-builtin
CFLAGS += -I.
#CFLAGS += -g
CFLAGS += -Os
CFLAGS += -DKZLOAD

LFLAGS = -static -T ld.scr -L.

.SUFFIXES: .c .o
.SUFFIXES: .s .o
.SUFFIXES: .S .o

all :		$(TARGET)

$(TARGET) :	$(OBJS)
		$(CC) $(OBJS) -o $(TARGET) $(CFLAGS) $(LFLAGS)
		cp $(TARGET) $(TARGET).elf
		$(STRIP) $(TARGET)

.c.o :		$<
		$(CC) -c $(CFLAGS) $<

.s.o :		$<
		$(CC) -c $(CFLAGS) $<

.S.o :		$<
		$(CC) -c $(CFLAGS) $<

$(TARGET).img :	$(TARGET)
		$(OBJCOPY) -O binary $(TARGET) $(TARGET).img

image :		$(TARGET).img

run: $(TARGET).elf
	$(QEMU) \
	-m 512 -M raspi3 -kernel $(TARGET).elf \
	-serial null -serial stdio \
	-accel tcg,thread=single -smp 4

qemu: $(TARGET).elf
	$(QEMU) \
	-m 512 -M raspi3 -kernel $(TARGET).elf \
	-serial null -serial stdio \
	-gdb tcp::12345 -S \
	-accel tcg,thread=single -smp 1

gdb: $(TARGET).elf
	$(AARCH64-GDB) $(TARGET).elf -x gdb.src

clean :
		rm -f $(OBJS) $(TARGET) $(TARGET).elf $(TARGET).img
