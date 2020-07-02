BUILD=build/

KERNEL_SOURCES=$(wildcard kernel/*.c drivers/*.c)
OBJ=${KERNEL_SOURCES:.c=.o}

C_FLAGS=-ffreestanding
# LD_FLAGS=-melf_i386
NASMFLAGS=-f elf64

QEMU=qemu-system-x86_64 -drive file=build/dirty-os,format=raw,index=0,media=disk

all: 
	kernel.bin boot.bin os-image

run:os-image
	$(QEMU) 

%kernel_entry.o: kernel/kernel_entry.asm
	nasm $< $(NASMFLAGS) -o kernel/kernel_entry.o

%.o: %.c
	gcc $(C_FLAGS) -c $< -o $@

kernel.bin: kernel/kernel_entry.o $(OBJ)
	ld -o ${BUILD}$@ -Ttext 0x1000 $^ --oformat binary

boot.bin: boot/14_boot_sect.asm
	nasm $(NASM_FLAGS) $< -f bin -I 'boot/' -o ${BUILD}$@

os-image: kernel.bin boot.bin
	cat ${BUILD}boot.bin ${BUILD}kernel.bin > ${BUILD}dirty-os

dir:
	mkdir -p $(BUILD)

clean:
	@rm -f kernel/*.o kernel/drivers/*.o
	@rm -r $(BUILD)
