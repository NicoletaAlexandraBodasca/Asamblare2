;7. Se dă s1 un sir de octeti. Să se construiască sirul s2 astfel:
;-dacă s1[0] apartine [00h,0Fh] atunci s1:=s2
;-dacă s1[0] apartine [10h,1Fh] atunci s2 va contine sirul s1 în ordine inversă
;-dacă s1[0] apartine [20h,2Fh] atunci s2 va contine primii (n div 2) octeti din s1 in ordinea lor, iar următorii ((n div 2)+(n mod 2)) octeti în ordine inversă
;-altfel, s2 va contine primii (n div 2) octeti din s1 în ordine inversă, iar restul respectând ordinea lor.

assume cs:code, ds:data
data segment
	s1 db -3,1,2,3,4,5,6,7
	n EQU ($-s1)
	p EQU ($-s1)/2
	s2 db n dup(?)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov cx,n
	mov si,0
	mov di,p
	cmp s1[si],00h
	jge compara
	altfel:    
		sub di,1
		mov ax,di
		repeta:
			cmp si,ax
			jg adsir  
			mov bl,s1[di]
			mov s2[si],bl
			sub di,1
			add si,1
		loop repeta
		adsir:
			mov bl,s1[si]
			mov s2[si],bl
			add si,1
		loop adsir
		jmp gata
		
	compara:
		cmp s1[si], 0Fh
		jle adauga
		cmp s1[si], 10h
		jge compara2
		
	adauga:   
		mov al,s1[si]
		mov s2[si],al
		add si,1
	loop adauga
	jmp gata
	
	
	compara2:
		cmp s1[si],1Fh
		jle adauga2
		cmp s1[si],20h
		jge compara3
		
	adauga2:
		mov di,n-1
		repeat:
			mov al,s1[di]
			mov s2[si],al
			add si,1
			sub di,1
			cmp di,-1
			
		jne repeat
		jmp gata
		
	
	compara3:
		cmp s1[si],2Fh
		jle adauga3
		cmp s1[si],2Fh
		jge altfel
		
	
	adauga3:
		mov cx,n
		sub di,1
		
		repeta2:
			cmp si,di
			jg adsir2
			mov bl,s1[si]
			mov s2[si],bl
			add si,1
			cmp si,di
			jle repeta2
		
		mov di,n
		sub di,1   ;di=n-1
			
		adsir2:        ;adaug in ordine inversa 
			mov bl,s1[di]
			mov s2[si],bl
			sub di,1
			add si,1
			cmp si,cx
			jne adsir2
	
	
	gata:
	
	mov ax, 4c00h
	int 21h
	code ends
	
end start
	
	

		
