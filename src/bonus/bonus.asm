section .data
	
section .text
    global bonus
	
bonus:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp + 8]           ; x
	mov ebx, [ebp + 12]          ; y
	mov ecx, [ebp + 16]          ; board
	
	
	;; 0 0 0 0 0 0 0 0 ecx + 3
	;; 0 0 0 0 0 0 0 0 ecx + 2
	;; 0 0 0 0 0 0 0 0 ecx + 1
	;; 0 0 0 0 0 0 0 0 ecx
	;; 0 0 0 0 0 0 0 0 ecx + 7
	;; 0 0 0 0 0 0 0 0 ecx + 6
	;; 0 0 0 0 0 0 0 0 ecx + 5
	;; 0 0 0 0 0 0 0 0 ecx + 4
	
	;; x = 1 => ecx + 4
	;; x = 2 => ecx + 5
	;; etc
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;;am comparat pe ce linie ar trebui sa ma duc
	;;liniie 4, 5 si 6 le - am considerat cazuri speciale
	;;deoarece nu ma pot intoarce sa pun o valoare pe unde am trecut
	;;deja asa ca am pus valorile odata ce am trecut prin linii
	;;o explicatie scurta ar fi ca sar pana la linia de sub element
	;;pun pe ea numarul in functie de coloana pe care ma aflu
	;;mai cresc ecx cu 2 pt a putea pune aceeasi valoare deasupra elementului
	;;la cazurile speciale cresc ecx in alta ordine
    ;; pt a putea pune valorile pe linii
	
	;;verific linia
	cmp eax, 0
	je linia_1
	
	cmp eax, 1
	je linia_2
	
	cmp eax, 2
	je linia_3
	
	cmp eax, 3
	je linia_4
	
	cmp eax, 4
	je linia_5
	
	cmp eax, 5
	je linia_6
	
	cmp eax, 6
	je linia_7
	
	cmp eax, 7
	je linia_8
	
	
	;;la cazurile speciale sar direct la verificarea coloanei
	;;in caz contrar adaug la ecx 
    ;;astfel incat sa ajung cu 1 linie sub elementul meu
linia_1:
	add ecx, 3
	jmp skip
	
linia_2:
	add ecx, 4
	jmp skip
	
linia_3:
	add ecx, 5
	jmp skip
	
linia_4:        ;;caz special
	jmp skip
	
linia_5:        ;;caz special
	jmp skip
	
linia_6:        ;;caz special
	jmp skip
	
linia_7:
	add ecx, 1
	jmp skip
	
linia_8:
	add ecx, 2
	
skip:
	cmp ebx, 0
	je coloana_1
	
	cmp ebx, 1
	je coloana_2
	
	cmp ebx, 2
	je coloana_3
	
	cmp ebx, 3
	je coloana_4
	
	cmp ebx, 4
	je coloana_5
	
	cmp ebx, 5
	je coloana_6
	
	cmp ebx, 6
	je coloana_7
	
	cmp ebx, 7
	je coloana_8
	
coloana_1:      ;;pun 2 (binar) pe linie / linii
	cmp eax, 0
	je caz_coloana1_linia_1
	
	cmp eax, 7
	je caz_coloana1_linia_8
	
	cmp eax, 3             ;;caz special
	je caz_special_col1_linia4
	
	cmp eax, 4             ;;caz special
	je caz_special_col1_linia5
	
	cmp eax, 5              ;;caz special
	je caz_special_col1_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 2
	add ecx, 2
	mov byte [ecx], 2
	jmp end
caz_coloana1_linia_1:
	add ecx, 2
	mov byte [ecx], 2
	jmp end
	
caz_coloana1_linia_8:
	mov byte [ecx], 2
	jmp end
	
caz_special_col1_linia4:
	mov byte [ecx], 2
	add ecx, 6
	mov byte [ecx], 2
	jmp end
	
caz_special_col1_linia5:
	add ecx, 1
	mov byte [ecx], 2
	add ecx, 6
	mov byte [ecx], 2
	jmp end
	
coloana_2:      ;;pun 5 in binar pe linii
	cmp eax, 0
	je caz_coloana2_linia_1
	
	cmp eax, 7
	je caz_coloana2_linia_8
	
	cmp eax, 3     ;;caz special
	je caz_special_col2_linia4
	
	cmp eax, 4     ;;caz special
	je caz_special_col2_linia5
	
	cmp eax, 5     ;;caz special
	je caz_special_col2_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 5
	add ecx, 2
	mov byte [ecx], 5
	jmp end
	
caz_coloana2_linia_1:
	add ecx, 2
	mov byte [ecx], 5
	jmp end
	
caz_coloana2_linia_8:
	mov byte [ecx], 5
	jmp end
	
caz_special_col2_linia4:
	mov byte [ecx], 5
	add ecx, 6
	mov byte [ecx], 5
	jmp end
	
caz_special_col2_linia5:
	add ecx, 1
	mov byte [ecx], 5
	add ecx, 6
	mov byte [ecx], 5
	jmp end
	
	
coloana_3:  ;;pun 10 in binar pe linii
	cmp eax, 0
	je caz_coloana3_linia_1
	
	cmp eax, 7
	je caz_coloana3_linia_8
	
	cmp eax, 3   ;;caz special
	je caz_special_col3_linia4
	
	cmp eax, 4   ;;caz special
	je caz_special_col3_linia5
	
	cmp eax, 5   ;;caz special
	je caz_special_col3_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 10
	add ecx, 2
	mov byte [ecx], 10
	jmp end
	
caz_coloana3_linia_1:
	add ecx, 2
	mov byte [ecx], 10
	jmp end
	
caz_coloana3_linia_8:
	mov byte [ecx], 10
	jmp end
	
caz_special_col3_linia4:
	mov byte [ecx], 10
	add ecx, 6
	mov byte [ecx], 10
	jmp end
	
caz_special_col3_linia5:
	add ecx, 1
	mov byte [ecx], 10
	add ecx, 6
	mov byte [ecx], 10
	jmp end
	
coloana_4:    ;;pun 20 in binar pe linii
	cmp eax, 0
	je caz_coloana4_linia_1
	
	cmp eax, 7
	je caz_coloana4_linia_8
	
	cmp eax, 3    ;;caz special
	je caz_special_col4_linia4
	
	cmp eax, 4    ;;caz special
	je caz_special_col4_linia5
	
	cmp eax, 5    ;;caz special
	je caz_special_col4_linia5  
     ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 20
	add ecx, 2
	mov byte [ecx], 20
	jmp end
	
caz_coloana4_linia_1:
	add ecx, 2
	mov byte [ecx], 20
	jmp end
	
caz_coloana4_linia_8:
	mov byte [ecx], 20
	jmp end
	
caz_special_col4_linia4:
	mov byte [ecx], 20
	add ecx, 6
	mov byte [ecx], 20
	jmp end
	
caz_special_col4_linia5:
	add ecx, 1
	mov byte [ecx], 20
	add ecx, 6
	mov byte [ecx], 20
	jmp end
	
	
coloana_5:   ;;pun 40 in binar pe linii
	cmp eax, 0
	je caz_coloana5_linia_1
	
	cmp eax, 7
	je caz_coloana5_linia_8
	
	cmp eax, 3   ;;caz special
	je caz_special_col5_linia4
	
	cmp eax, 4   ;;caz special
	je caz_special_col5_linia5
	
	cmp eax, 5   ;;caz special
	je caz_special_col5_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 40
	add ecx, 2
	mov byte [ecx], 40
	jmp end
	
caz_coloana5_linia_1:
	add ecx, 2
	mov byte [ecx], 40
	jmp end
	
caz_coloana5_linia_8:
	mov byte [ecx], 40
	jmp end
	
caz_special_col5_linia4:
	mov byte [ecx], 40
	add ecx, 6
	mov byte [ecx], 40
	jmp end
	
caz_special_col5_linia5:
	add ecx, 1
	mov byte [ecx], 40
	add ecx, 6
	mov byte [ecx], 40
	jmp end
	
coloana_6:  ;;pun 80 in binar pe linii
	cmp eax, 0
	je caz_coloana6_linia_1
	
	cmp eax, 7
	je caz_coloana6_linia_8
	
	cmp eax, 3   ;;caz special
	je caz_special_col6_linia4
	
	cmp eax, 4   ;;caz special
	je caz_special_col6_linia5
	
	cmp eax, 5   ;;caz special
	je caz_special_col6_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 80
	add ecx, 2
	mov byte [ecx], 80
	jmp end
	
caz_coloana6_linia_1:
	add ecx, 2
	mov byte [ecx], 80
	jmp end
	
caz_coloana6_linia_8:
	mov byte [ecx], 80
	jmp end
	
caz_special_col6_linia4:
	mov byte [ecx], 80
	add ecx, 6
	mov byte [ecx], 80
	jmp end
	
caz_special_col6_linia5:
	add ecx, 1
	mov byte [ecx], 80
	add ecx, 6
	mov byte [ecx], 80
	jmp end
	
coloana_7:    ;;pun 160 in binar pe linii
	cmp eax, 0
	je caz_coloana7_linia_1
	
	cmp eax, 7
	je caz_coloana7_linia_8
	
	cmp eax, 3    ;;caz special
	je caz_special_col7_linia4
	
	cmp eax, 4    ;;caz special
	je caz_special_col7_linia5
	
	cmp eax, 5    ;;caz special
	je caz_special_col7_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 160
	add ecx, 2
	mov byte [ecx], 160
	jmp end
	
caz_coloana7_linia_1:
	add ecx, 2
	mov byte [ecx], 160
	jmp end
	
caz_coloana7_linia_8:
	mov byte [ecx], 160
	jmp end
	
caz_special_col7_linia4:
	mov byte [ecx], 160
	add ecx, 6
	mov byte [ecx], 160
	jmp end
	
caz_special_col7_linia5:
	add ecx, 1
	mov byte [ecx], 160
	add ecx, 6
	mov byte [ecx], 160
	jmp end
	
coloana_8:   ;;pun 64 in binar pe linii
	cmp eax, 0
	je caz_coloana8_linia_1
	
	cmp eax, 7
	je caz_coloana8_linia_8
	
	cmp eax, 3   ;;caz special
	je caz_special_col8_linia4
	
	cmp eax, 4   ;;caz special
	je caz_special_col8_linia5
	
	cmp eax, 5   ;;caz special
	je caz_special_col8_linia5   
    ;;se procedeaza ca in cazul liniei 5
	
	mov byte [ecx], 64
	add ecx, 2
	mov byte [ecx], 64
	jmp end
	
caz_coloana8_linia_1:
	add ecx, 2
	mov byte [ecx], 64
	jmp end
	
caz_coloana8_linia_8:
	mov byte [ecx], 64
	jmp end
	
caz_special_col8_linia4:
	mov byte [ecx], 64
	add ecx, 6
	mov byte [ecx], 64
	jmp end
	
caz_special_col8_linia5:
	add ecx, 1
	mov byte [ecx], 64
	add ecx, 6
	mov byte [ecx], 64
	
end:
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
