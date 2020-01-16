build_run: build run

build: 
	nasm -f elf32 -g3 -F dwarf boot_sect.asm -o main.o
	ld -Ttext=0x7c00 -melf_i386 main.o -o main.elf
	objcopy -O binary main.elf main.img
run:
	qemu-system-x86_64 -hda main.img

debug:
	qemu-system-x86_64 -hda main.img -S -s

build_run_bin: build_bin run_bin
build_bin:
	nasm boot_sect.asm -f bin -o boot_sect.bin
run_bin:
	qemu-system-x86_64 -fda boot_sect.bin 
