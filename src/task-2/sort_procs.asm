	%include "../include/io.mac"
	
	struc proc
.pid: resw 1
.prio: resb 1
.time: resw 1
	endstruc
	
	section .text
	global sort_procs
	
sort_procs:
	;; DO NOT MODIFY
	enter 0, 0
	pusha
	
	mov edx, [ebp + 8]           ; processes
	mov eax, [ebp + 12]          ; length
	;; DO NOT MODIFY
	
	;; Your code starts here
	mov ecx, [ebp + 12]          ; pun size - ul in ecx
	;; SORTAT = 0
	;; NESORTAT = 1
next_pass:
	dec ecx     ; daca numarul de comparatii e 0
	jz sort_done  ;am terminat
	mov edi, ecx    ;in caz contrar incep un alt loop
	
	mov dl, 0    ;setez statusul ca fiind sortat
	
	mov esi, [ebp + 8]  ;incarc adresa vectorului de structuri in esi
pass:
	
compar_prioritati:
	mov al, [esi + proc.prio]
	mov bl, [esi + proc_size + proc.prio]
	cmp al, bl    ;compar daca prio este sortat crescator
	jg swap        ;daca nu, interscimb valorile
	je compar_timp    ;daca sunt egale compar cuanta de timp
	jl increment       ;daca e mai mic inseamna ca e sortat
                       ; dupa acest criteriu si incrementez
compar_timp:
	mov ax, [esi + proc.time]
	mov bx, [esi + proc_size + proc.time]
	cmp ax, bx    ;compar daca cuanta de timp este sortata crescator
	jg swap         ;daca nu este voi interschimba valorile
	je compar_id      ;daca sunt egale voi sari la sortarea id - ului
	jl increment       ;daca e mai mic atunci voi sari la increment
                       ; pentru ca este sortat dupa acest criteriu
	
compar_id:
	mov ax, [esi + proc.pid]
	mov bx, [esi + proc_size + proc.pid]
	cmp ax, bx
	jg swap    ; compar id - ul si daca nu este sortat crescator
               ; voi interschimba valorile
increment:
	;incrementez esi cu proc_size pt a compara urmatoarele elemente
	add esi, proc_size
	dec edi
	jnz pass
	
	cmp edx, 0                   ;verific daca a ramas sortat
	je sort_done                 ;se termina sortarea daca da
	jmp next_pass                ;in caz contrar initiez alt ciclu

swap:
	;mut elementele de la [esi] si [esi + proc_size]
	;de fiecare data voi pune valoarea de la adresa esi + informatia mea
	;si voi folosi xchg pt a intershimba informatiile de la adrese
	;dupa aceea voi pune inapoi in esi valoarea pe care o am in ax
	;imediat dupa ce am facut xchg iar in el este prezenta valoarea
	;de la esi + proc_size + informatia
	mov ax, [esi + proc.pid]
	xchg [esi + proc_size + proc.pid], ax
	mov [esi + proc.pid], ax
	
	mov ax, [esi + proc.time]
	xchg [esi + proc_size + proc.time], ax
	mov [esi + proc.time], ax
	
	mov al, [esi + proc.prio]
	xchg [esi + proc_size + proc.prio], al
	mov [esi + proc.prio], al
	
	mov edx, 1
	jmp increment
sort_done:
	;; Your code ends here
	
	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
