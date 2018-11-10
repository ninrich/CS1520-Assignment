;add text in video interrupt
.model tiny
.stack 286
.data 
  color db ?
  triangleX dw ?
  triangleY dw ?
  endY dw ?
  endX dw ?
  startY dw ?
  startX dw ?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code
jmp Start
clrscr:
	mov ah, 00h 
	mov al, 13h 
	int 10h
	ret
delay:
	push ax
	mov cx, 02h 					;delay duration
	mov ah, 86h 					
	int 15h
	pop ax
	ret
Start:
	call clrscr
	mov al, 16d 					;color

shapeL:
	mov ah, 0Ch
	mov cx, 40 						;suradnica X
	mov dx, 40						;suradnica Y
   	hornaStrana:
		inc cx
		int 10h
		cmp cx, 260d
		jne hornaStrana
		mov ah, 0Ch		
	dole:
		inc dx
		int 10h
		cmp dx, 140d
		jne dole
	dolava:
		
		dec cx
		int 10h
		cmp cx, 175d
		jne dolava
	dolavaHore:
		
		dec dx
		dec cx
		int 10h
		cmp dx, 90
		jne dolavaHore
	dolava2:
		
		dec cx
		int 10h
		cmp cx, 40
		jne dolava2
	hore:
		
		dec dx
		int 10h
		cmp dx, 40
		jne hore
	
	call delay
	inc al
	cmp al, 32d
	je tri
	mov ah, 01h							;check for pressed key
	int 16h
	jz shapeL
	
	mov ah, 00d
	int 16h								;key press
	
	cmp ah, 01h 						;escape
	je endprogram
	cmp ah, 39h 						;spacebar
	;je Rektangle
	


tri:

call clrscr
mov triangleX, 190d
mov triangleY, 60d
mov al, 60d								;otherwise types do not match
mov color, al
Triangle:	
	mov al, color 						;color
	mov ah, 0Ch
	mov cx, triangleX 					;suradnica X
	mov dx, triangleY 					;suradnica Y
	
	kratsia:
		inc dx
		int 10h
		inc dx
		dec cx
		int 10h
		cmp cx, 150d
		jne kratsia	
	
	prepona:
		dec dx
		int 10h
		dec cx
		int 10h
		cmp dx, triangleY
		jne prepona
		jmp dlhsia
	
endprogram:
jmp endprogram2

	dlhsia:			
		inc cx
		int 10h
		cmp cx, triangleX
		jne dlhsia
		
	dec triangleX 						;decrease triangle size
	inc color							;change color
	dec triangleY  						;pyramid effect
	
	cmp triangleX, 150d					;stop at the centre
	je Rektangle
	
	call delay
	
	mov ah, 01h							;check for pressed key
	int 16h
	jz Triangle 						;repeat if key not pressed
	
	mov ah, 00d
	int 16h								;key press
	
	cmp ah, 01h 						;escape
	je endprogram2
	cmp ah, 39h 						;spacebar
	je Rektangle
Rektangle:
	call delay
	call delay
	call delay							;keep pyramid on screen for a while
	call clrscr
	mov startX, 10d						;dolava-doprava
	mov startY, 50d						;hore-dole
	mov endX, 20d						;ending point X
	mov endY, 150d						;ending point Y
	mov al, color
	mov ah, 0Ch
	mov cx, startX 					
	jmp VerticalLineSet					;jumps around increasing, so the numbers are nice
rektangleMovement:	
	call delay
	mov ah, 01h							;check for pressed key
	int 16h
	jnz endprogram2 					;end if key pressed
	call clrscr
	
	mov ah,0Ch
	inc startX
	mov cx, startX 						;reset X
	inc color
	mov al, color
	inc endX
	VerticalLineSet:
		mov dx, startY					;starting point Y 50d
	VerticalLine:
		int 10h
		inc dx
		cmp dx, endY
		jne VerticalLine
	HorizontalLines:
		inc al
		inc cx
		cmp cx, endX
		jne VerticalLineSet	
	cmp startX, 295d					;how many repetitions 
	jne rektangleMovement
	call clrscr	
endprogram2:
	;mov ah, 00d
	;int 16h								;key press
	
	mov ah, 00h 						;clear screen
	mov ax,3 							;clear screen
	int 10h 							;clear screen
	mov ah,4ch 
	int 21h  
END Start 