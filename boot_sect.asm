; 
; Demonstrate stack 
;
mov ah, 0x0e

mov bp, 0x8000
mov sp,bp

; The stack only allows 16 bit values
; However we push 8bit values as 16-bit values
; 'A' - 0x00XX
push 'A'
push 'B'
push 'C'

; Since we have pop 16-bit values onto bx
; we take the lower 8 bits and print those
pop bx
mov al,bl
int 0x10

pop bx
mov al,bl
int 0x10

mov al,[0x7ffe]
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
