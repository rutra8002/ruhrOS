; This is the main assembly code for the "ruros" project.
; It starts at the address 0x7C00 and operates in 16-bit mode.

org 0x7C00
bits 16

main:
	hlt

.halt:
	jmp .halt

; Fill the remaining bytes of the boot sector with zeross
times 510-($-$$) db 0

; Boot signature
dw 0AA55h