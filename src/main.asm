; This is the main assembly code for the "ruhrOS" project.
; It starts at the address 0x7C00 and operates in 16-bit mode.

org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A


start:
	jmp main

; prints a string to the screen
; Parameters:
;   ds:si - pointer to the string
;

puts:
	; save registers to modify
	push si
	push ax

.loop:
	lodsb ; load next byte from ds:si into al and increment si
	or al, al ; check if al is null
	jz .done ; if al is null, we are done

	mov ah, 0x0E
	int 0x10
	jmp .loop


.done:
	pop ax
	pop si
	ret


main:
	; setup data segments
	mov ax, 0 ; cant write to ds/es directlu
	mov ds, ax
	mov es, ax

	; setup stack
	mov ss, ax
	mov sp, 0x7C00 ; stack grows downwards

	; print hello world
	mov si, msg_hello_world
	call puts


	hlt


.halt:
	jmp .halt


msg_hello_world: db 'Hello, world!', ENDL, 0

; Fill the remaining bytes of the boot sector with zeross
times 510-($-$$) db 0

; Boot signature
dw 0AA55h