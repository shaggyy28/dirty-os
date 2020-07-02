BUILD=build/

KERNEL_SOURCES=$(wildcard kernel/*.c kernel/drivers/*.c)
OBJ=${KERNEL_SOURCES:.c=.o}

C_FLAGS=-ffreestanding
# LD_FLAGS=-melf_i386
NASMFLAGS=-f elf64

QEMU=qemu-system-x86_64

all: 
	kernel.bin boot.bin os-image

run:
	$(QEMU) $(BUILD)dirty-os

%kernel_entry.o: kernel/kernel_entry.asm
	nasm $< $(NASMFLAGS) -o kernel/kernel_entry.o

%.o: %.c
	gcc $(C_FLAGS) -c $< -o $@

kernel.bin: kernel/kernel_entry.o $(OBJ)
	ld -o ${BUILD}$@ -Ttext 0x1000 $^ --oformat binary

boot.bin: boot/14_boot_sect.asm
	nasm $(NASM_FLAGS) $< -f bin -I 'boot/' -o ${BUILD}$@

os-image:
	cat ${BUILD}boot.bin ${BUILD}kernel.bin > ${BUILD}dirty-os

dir:
	mkdir -p $(BUILD)

clean:
	@rm -f kernel/*.o kernel/drivers/*.o
	@rm -r $(BUILD)
