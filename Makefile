TARGET=i686-elf
TARGET_PATH=~/opt/cross/bin
ASM=$(TARGET_PATH)/$(TARGET)-as
CC=$(TARGET_PATH)/$(TARGET)-gcc
ENAME=myos

all: kernel 
	@cp $(ENAME).bin isodir/boot/$(ENAME).bin
	@cp grub.cfg isodir/boot/grub/grub.cfg
	@grub-mkrescue -o $(ENAME).iso isodir

run-iso: all
	@qemu-system-i386 -cdrom $(ENAME).iso

run-bin: kernel 
	@qemu-system-i386 -kernel $(ENAME).bin

kernel: boot.o
	@$(CC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	@$(CC) -T linker.ld -o $(ENAME).bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o: boot.s
	@$(ASM) boot.s -o boot.o

clean:
	@rm -f *.o *.bin *.iso isodir/boot/$(ENAME).bin
