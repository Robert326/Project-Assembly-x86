%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;


struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc
    
    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov esi, [ebp + 16] ;pun ca esi sa imi indice spre adresa de la proc_avg
    mov edi, [ebp + 8] ;pun edi sa imi indice catre procese 
                       ; le voi parcurge cu acest registru
    xor ecx, ecx ; golesc ecx pt a putea parcurge sirul cu el
    
    parcurge_procese:
    cmp ecx,ebx ;compar daca am ajuns la sfarsitul vectorului processes
    je eticheta_pun_rezultatele ;in caz afirmativ sar la eticheta
                                ;unde pun rezultatele in celalalt vector

    mov al, [edi + proc.prio]
    cmp al, 1
    je eticheta_prio_1
    cmp al, 2
    je eticheta_prio_2
    cmp al, 3
    je eticheta_prio_3
    cmp al, 4
    je eticheta_prio_4
    cmp al, 5
    je eticheta_prio_5

    eticheta_prio_1:
    add word [prio_result], 1 ;incrementez nr de elem cu prio 1
                              ; din vectorul prio result
    mov ax, [edi + proc.time] ;adaug la pozitia "prio" 
                              ;in cazul meu 1, cuanta de timp
    add [time_result] ,ax
    jmp increment

    eticheta_prio_2:
    add word [prio_result + 4], 1 ;incrementez nr de elem cu prio 2 
                                  ;din vectorul prio result
    mov ax, [edi + proc.time] ;adaug la pozitia "prio" in cazul meu 2
                              ; cuanta de timp
    add [time_result + 4], ax
    jmp increment

    eticheta_prio_3:
    add word [prio_result + 8], 1 ;incrementez nr de elem cu prio 3 
                                  ;din vectorul prio result
    mov ax, [edi + proc.time] ;adaug la pozitia "prio" in cazul meu 3
                              ; cuanta de timp
    add [time_result + 8], ax
    jmp increment

    eticheta_prio_4:    
    add word [prio_result + 12], 1 ;incrementez nr de elem cu prio 4
                                   ; din vectorul prio result
    mov ax, [edi + proc.time] ;adaug la pozitia "prio" in cazul meu 4
                              ; cuanta de timp
    add [time_result + 12], ax
    jmp increment

    eticheta_prio_5:
    add word [prio_result + 16], 1 ; incrementez nr de elem cu prio 5
                                   ; din vectorul prio result
    mov ax, [edi + proc.time] ; adaug la pozitia "prio" in cazul meu 5
                              ; cuanta de timp
    add [time_result + 16], ax

    increment:
    add edi, proc_size
    inc ecx
    jmp parcurge_procese 

    eticheta_pun_rezultatele:
    xor ecx, ecx
    eticheta_parcurg_vectorul_avg:
    cmp ecx,5
    je end
    
    mov  ax, [time_result + ecx * 4]
    xor dx, dx
    mov bx, [prio_result + ecx * 4]
    cmp bx, 0
    je skip
    div bx
    
    skip:

    mov [esi + avg.quo], ax
    mov [esi + avg.remain], dx
    inc ecx
    add esi, avg_size
    jmp eticheta_parcurg_vectorul_avg
    end:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY