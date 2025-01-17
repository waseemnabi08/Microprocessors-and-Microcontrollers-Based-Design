#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

.MODEL SMALL

.STACK100H

.CODE

MOV AX, 2000 MOV BX, 2000H MOV CX, 1010001B MOV DX, 4567 MOV BH,'A' MOV CL,'a'

MOV AH, 4CH

INT 21H; INT 21h returns the control to DOS if AH=4CH

END
