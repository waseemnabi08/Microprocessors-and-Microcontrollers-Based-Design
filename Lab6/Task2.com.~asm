#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

.DATA
; Predefined values
A dw 0      
B dw 0     
C dw 0      
A1 dw 0  ; A^2
B1 dw 0 ; B^2
C1 dw 0 ; C^2
msg db 0dh, 0ah, 'Enter A: $'
msg1 db 0dh, 0ah, 'Enter B: $'
msg2 db 0dh, 0ah, 'Enter C: $'


.CODE

MOV AX, @DATA
MOV DS, AX

LEA DX, msg
MOV ah , 09h
int 21h

mov ah, 01h
int 21h
sub al, '0'
mov ah, 0
mov A, ax


LEA DX, msg1
MOV ah , 09h
int 21h

mov ah, 01h
int 21h
sub al, '0'
mov ah, 0
mov B, ax


LEA DX, msg2
MOV ah , 09h
int 21h

mov ah, 01h
int 21h
sub al, '0'
mov ah, 0
mov C, ax


mov ax, a
mul ax ; a^2
mov A1, ax



mov ax, b
mul ax ; b^2
mov B1, ax

mov ax, c 
mul ax ; c^2
mov C1, ax

mov ax, A1
mov dx, B1
add ax, dx
mov dx , C1
cmp ax, dx ;(A^2 + B^2 = C^2)

je setC

jmp clear


setC:

STC
jmp exit

clear:

CLC

exit:

ret








