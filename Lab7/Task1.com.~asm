#make_COM#

; COM file is loaded at CS:0100h
ORG 100h
.model small
.stack 100h


.data

numbers dw 10, 20, 30, 40, 50
sum dw 0

.code

mov ax, @data
mov ds, ax

mov cx, 0
mov ax, 0
LEA si , numbers
addi:
cmp cx, 5
jge done 
add ax, [si] ; ax = ax + number[cx]
inc cx 
add si, 2
jmp addi

done:
mov sum, ax
mov ah, 4ch
int 21h
