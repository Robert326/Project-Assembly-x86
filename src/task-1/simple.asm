%include "../include/io.mac"
	
	
section .text
	global simple
	extern printf
	
simple:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	
	mov ecx, [ebp + 8]           ; len
	mov esi, [ebp + 12]          ; plain
	mov edi, [ebp + 16]          ; enc_string
	mov edx, [ebp + 20]          ; step
	
	;; DO NOT MODIFY
	
	;; Your code starts here
	
	mov byte [ebp + 24], 0       ; index
parcurg_sir:
	mov ebx, [ebp + 24]      ; mutam valoarea din index in ebx.
	cmp ebx, [ebp + 8]       ; verific daca am trecut de ultimul caracter
	je exit                  ; si ies din parcurgere daca da
	
	mov al, [esi + ebx]      ; mut in eax litera
	movzx eax, al            ; cum caracterul ocupa un octet am extins al la eax
	sub eax, 65
	add eax, [ebp + 20]      ; adaug step - ul
	xor edx, edx             ; golesc edx - ul
	mov ecx, 26
	div ecx                  ; fac impartirea si restul este in edx
	
	add edx, 65
	mov [edi + ebx], edx     ; adaug pozitia din edi restul impartirii
	inc byte [ebp + 24]
	jmp parcurg_sir
	
exit:
	;; Your code ends here
	
	;; DO NOT MODIFY
	
	popa
	leave
	ret
	
	;; DO NOT MODIFY
