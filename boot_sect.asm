; 
; A boot sector that prints a string using an external function 
;

[org 0x7c00] ; Tell the assembler where the code will be loaded

main:
    mov bp, 0x9000
    mov sp,bp
    mov bx, MSG_REAL_MODE
    call print_string
    call switch_to_pm
    jmp $

%include "./string/print_string.asm"
%include "./string/print_string_pm.asm"
; %include "./hex/print_hex.asm"
; %include "disk_load.asm"
%include "gdt.asm"
%include "switch_pm.asm"

[bits 32]

BEGIN_PM:
     mov bx,MSG_IN_MODE
     call print_string_pm
     mov bx,MSG_PROT_MODE
     call print_string_pm
     jmp $


MSG_REAL_MODE db 'Started in 16 bit real mode',0
MSG_PROT_MODE db 'Started in 32 bit protected mode',0
MSG_IN_MODE db '                                                                                ',0

times 510-($-$$) db 0
dw 0xaa55
