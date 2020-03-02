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
	# qemu-system-x86_64  boot_sect.bin

kernel.bin : kernel_entry.o kernel.o
	# ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
	#	
	# $^ is  substituted  with  all of the  target ’s dependancy  files
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o : kernel.c
	#gcc -ffreestading -c kernel.c -o kernel.o
	#	
	# $< is the  first  dependancy  and $@ is the  target  file
	gcc -ffreestading -c $< -o $@

kernel_entry.o : kernel_entry.asm
	#nasm kernel_entry.asm -f elf64 -o kernel_entry.o
	#
	# $< is the  first  dependancy  and $@ is the  target  file
	nasm $< -f elf64 -o $@


