; 
; A boot sector that prints a string using an external function 
;

[org 0x7c00] ; Tell the assembler where the code will be loaded
; bits 16
; mov ah, 0x0e ; int  10/ah = 0eh -> scrolling  teletype  BIOS  routine

main:
    mov [BOOT_DRIVE], dl  
	mov bp,0x8000
	mov sp,bp

	mov bx,0x9000
	mov dh,5
	mov dl,[BOOT_DRIVE]
	call disk_load

	mov dx,[0x9000]
	call print_hex

	mov dx,[0x9000 + 512]
	call print_hex

    jmp $

%include "./string/print_string.asm"
%include "./hex/print_hex.asm"
%include "disk_load.asm"

; DATA
BOOT_DRIVE:
	db 0

;Boot Sector Padding
times 510-($-$$) db 0
dw 0xaa55


times 256 dw 0xdada
times 256 dw 0xface
