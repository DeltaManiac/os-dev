; 
; Demonstrate addressing
; Here we store a value and try to use
; the address to refer to the value
;
mov ah, 0x0e

;Does not resolve the value
mov al, the_value
int 0x10

;Does not resolve the value
mov al, [the_value]
int 0x10

; Resolves the value as 0x7c00 + offset of the_value
mov bx, the_value
add bx, 0x7c00
mov al,[bx]
int 0x10

; Resolves the value as 0x7c00 + offset of the_value = 0x7c1e
; Directly addressing the value
mov al, [0x7c1e]
int 0x10

jmp $

the_value:
	db "X"
times 510-($-$$) db 0
dw 0xaa55
