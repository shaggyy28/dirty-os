BUILD=build/

KERNEL_SOURCES=$(wildcard kernel/*.c kernel/driver/*.c)
OBJ=${KERNEL_SOURCES:.c=.o}

C_FLAGS=-ffreestanding -m32 -g
LD_FLAGS=-melf_i386
NASMFLAGS=-f elf32

QEMU=qemu-system-i386 -drive file=build/dirty-os,format=raw,index=0,media=disk

all: dir kernel.bin boot.bin os-image

dir:
	mkdir -p $(BUILD)

%kernel_entry.o: kernel/kernel_entry.asm
	nasm $< $(NASMFLAGS) -o $@

%.o: %.c
	gcc $(C_FLAGS) -c $< -o $@

kernel.bin: kernel/kernel_entry.o $(OBJ)
	ld ${LD_FLAGS} -o ${BUILD}$@ -Ttext 0x1000 $^ --oformat binary

boot.bin: boot/14_boot_sect.asm
	nasm $(NASM_FLAGS) $< -f bin -I 'boot/' -o ${BUILD}$@

os-image: kernel.bin  boot.bin 
	cat ${BUILD}boot.bin ${BUILD}kernel.bin > ${BUILD}dirty-os


run:all
	$(QEMU) 

clean:
	@rm -f kernel/*.o kernel/driver/*.o
	@rm -r $(BUILD)
