section .data
	
section .text
	global checkers
	
checkers:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp + 8]           ; x
	mov ebx, [ebp + 12]          ; y
	mov ecx, [ebp + 16]          ; table
	
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	cmp eax, 0   ;;compar x - ul cu 0 si iau cazurile in care este 0
	je caz_x_0
	
	cmp eax, 7   ;;compar x - ul cu 7 si iau cazurile in care sunt pe ultima linie
	je ultima_linie
	
	cmp ebx, 0   ;;compar y si verific cazul in care sunt pe prima coloana
	je prima_coloana
	
	cmp ebx, 7   ;;verific daca sunt cu y pe ultima coloana
	je ultima_coloana
	
cazul_nespecial:
	;;pun 1 pe toate diagonalele
	
	;;pun 1 pe dreapta sus
	add eax, 1
	add ebx, 1
	;;adaug cate 1 sa merg pe elementul de pe diagonala dreapta
	push ecx    ;;pun pe stiva valoarea lui ecx pt ca il voi folosi la inmultire
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	add eax, ebx     ;;eax =lineIndex * n + columnIndex
	
	pop ecx           ;; ii pun valoarea inapoi lui ecx
	add ecx, eax      ;;ma mut pe element
	mov byte [ecx], 1    ;;si pun 1
	
	;;pun 1 pe diag stanga sus
	sub ecx, 2
	mov byte [ecx], 1
	
	;;pun 1 pe diag dreapta jos
	sub ecx, 14
	mov byte [ecx], 1
	
	;;pun 1 pe diag stanga jos
	sub ecx, 2
	mov byte [ecx], 1
	jmp end
	
caz_x_0:
	
stanga_jos?:
	cmp ebx, 0
	je colt_stanga_jos
	
dreapta_jos?:
	cmp ebx, 7
	je colt_dreapta_jos
	
linie_jos_normal?:
	cmp ebx, 7
	jl linie_jos_normal
	
colt_stanga_jos:
	;;pun 1 pe diagonala dreapta sus
	add eax, 1
	add ebx, 1
	;;adaug cate 1 sa merg pe elementul de pe diagonala dreapta
	push ecx   ;;pun pe stiva valoarea lui ecx
               ;; pt ca il voi folosi la inmultire
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	add eax, ebx    ;;eax =lineIndex * n + columnIndex
	
	pop ecx        ;; ii pun valoarea inapoi lui ecx
	add ecx, eax     ;;ma mut pe element
	mov byte [ecx], 1      ;;si pun 1
	mov ecx, [ebp + 16]
	jmp end
	
colt_dreapta_jos:
	add eax, 1
	dec ebx
	push ecx
	
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	add eax, ebx
	
	pop ecx
	add ecx, eax
	mov byte [ecx], 1
	mov ecx, [ebp + 16]
	jmp end
	
linie_jos_normal:
	;;pun 1 pe diag stanga sus
	add eax, 1
	dec ebx
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	
	
	;;pun 1 pe diag dreapta sus
	add ecx, 2
	mov byte [ecx], 1
	jmp end
	
prima_coloana:
	cmp eax, 7   
     ;;verific sa nu fiu in coltul stanga sus
	je colt_stanga_sus
	
	;;pun 1 pe diagonala dreapta sus
	add eax, 1
	add ebx, 1
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	
	;;pun 1 pe diagonala dreapta jos
	sub ecx, 16
	mov byte [ecx], 1
	jmp end
	
colt_stanga_sus:
	;;pun 1 pe diagonala dreapta jos
	sub eax, 1
	add ebx, 1
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	jmp end
	
ultima_coloana:
	cmp eax, 7    ;;verific daca sunt in coltul dreapta sus
	je colt_dreapta_sus
	;;daca nu sunt pe coltul din dreapta de sus
	;;pun 1 pe diagonala stanga jos si diagonala stanga sus
	
	;;pun 1 pe diagonala stanga sus
	add eax, 1
	sub ebx, 1
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	
	;;pun 1 pe diagonala dreapta jos
	sub ecx, 16
	mov byte [ecx], 1
	jmp end
colt_dreapta_sus:
	;;pun 1 pe diagonala stanga jos
	sub eax, 1
	sub ebx, 1
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	jmp end
	
ultima_linie:
	
	cmp ebx, 7   ;;verific daca sunt pe elemntul din coltul dreapta sus
	je colt_dreapta_sus
	
	cmp ebx, 0   ;;verific daca sunt pe elementul din contul stanga sus
	je colt_stanga_sus
	
	;;in cazul in care nu ma aflu pe colturi pun 1 
    ;;pe diag stanga jos si diag dreapta jos
	sub eax, 1
	sub ebx, 1
	push ecx
	
	xor edx, edx
	mov ecx, 8
	mul ecx
	
	pop ecx
	add eax, ebx
	add ecx, eax
	mov byte [ecx], 1
	
	add ecx, 2
	mov byte [ecx], 1
	jmp end
	
end:
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
