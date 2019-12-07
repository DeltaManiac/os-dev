; 
; Demonstrate Conditional operations
; Converting the follwing condition to asm
;
;   mov bx, 30
;   if (bx  <= 4) 
;       {mov al, ’A’} 
;   else if (bx < 40) 
;       {mov al, ’B’} 
;   else
;       {mov al, ’C’}
;
mov ah, 0x0e

;mov bx,00
mov bx,30
;mov bx,60

cmp bx, 4 
    ; if comparison is lesser than or equal 
    ; jump to print_A
    jle print_A ;
cmp bx, 40
    ; if comparison is lesser than 
    ; jump to print_B
    jl print_B
; if nothing passes then 
; jump to print_B
jmp print_C

print_A:
    mov al, 'A'
    jmp finish

print_B:
    mov al, 'B'
    jmp finish

print_C:
    mov al, 'C'

finish:
    int 0x10
    jmp $

times 510-($-$$) db 0
dw 0xaa55
