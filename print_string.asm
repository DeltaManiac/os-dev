;
; String Printer
; Accepts a pointer to a '0' terminated string in BX
; Prints the string and the returns to the caller
;

print_string:
	pusha ; Push all the registers
	loop: 
		mov al,[bx] ; Copy the value pointed by bx to al, only the lower 8-bits
					; are copied
		cmp al,0	; Check if al is '0', if no jump to 'print'
		jne print 
		popa ; Popback all the registers
		ret  ; Return
print:
	add bx,1 ; increment 'bx' to move on to the next character
	int 0x10
	jmp loop
