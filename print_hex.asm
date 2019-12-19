;
; Hex Printer
; Accepts a pointer to a '0' terminated string in DX
; Prints the value in Hexadecimal and the returns to the caller
; We use AX as a temporary register to do operations on the value

print_hex:
;	mov dx,0x1fba
	mov bx,HEX_OUT
	pusha

;BYTE 1
	add bx,2
	mov ax,dx
	shr ax,12
	and ax,0x000F ; Extract the last byte
	push bx ; Push the index pointer
	mov bx,HEX_STRING ; Point the index pointer to the char list
	add bx,ax ; Offset to the character
	mov cl,[bx]; Store the temp value
	pop bx ; Reset the index pointer
	mov [bx],cl; Store the character to string pinter

;BYTE 2
	add bx,1
	mov ax,dx
	shr ax,8
	and ax,0x000F
	push bx
	mov bx,HEX_STRING 
	add bx,ax
	mov cl,[bx]
	pop bx
	mov [bx],cl

;BYTE 3
	add bx,1
	mov ax,dx
	shr ax,4
	and ax,0x000F
	push bx
	mov bx,HEX_STRING 
	add bx,ax
	mov cl,[bx]
	pop bx
	mov [bx],cl

;BYTE 4
	add bx,1
	mov ax,dx
	and ax,0x000F
	push bx
	mov bx,HEX_STRING 
	add bx,ax
	mov cl,[bx]
	pop bx
	mov [bx],cl

	popa
	ret

HEX_OUT:
	db '0x0000',0

HEX_STRING:
	db '0123456789ABCDEF',0
