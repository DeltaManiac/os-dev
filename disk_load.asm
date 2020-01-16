; Load DH sectors to ES:BX from DL

disk_load:
	push dx
	mov ah,0x02 ; BIOS READ SECTOR
	mov al,dh ; Read Sector : DH 
	mov ch,0x00 ; Select cylinder 0
	mov dh,0x00 ; Select head 0
	mov cl,0x02 ; Start reading from second sector
	int 0x13
	jc disk_error 

	pop dx
	cmp dh,al
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

disk_error2:
	mov bx, DISK_ERROR_MSG2
	call print_string
	jmp $
DISK_ERROR_MSG db "Disk read error!", 0
DISK_ERROR_MSG2 db "Disk read error222!", 0
