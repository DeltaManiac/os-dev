; 
; A boot sector that prints a string using an external function 
;

;[org 0x7c00] ; Tell the assembler where the code will be loaded
bits 16
mov ah, 0x0e ; int  10/ah = 0eh -> scrolling  teletype  BIOS  routine

main:
    mov bx, HELLO_MSG ; We use the BX register as the parameter so we can 
    call print_string  ; Specify the address of the string
 
    mov bx, GOODBYE_MSG
    call print_string

	mov dx, 0x12BC
	call print_hex
	call print_string
    jmp $

%include "print_string.asm"
%include "print_hex.asm"

; DATA
HELLO_MSG:
    db 'Hello, World!',0; We use 0 to indicate the string has terminated

GOODBYE_MSG:
    db 'Goodbye!',0

times 510-($-$$) db 0
dw 0xaa55
