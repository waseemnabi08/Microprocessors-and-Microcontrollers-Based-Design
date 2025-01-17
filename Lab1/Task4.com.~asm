#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

.DATA
MESSAGE DB 'This is the Message to be displayed',

.CODE
MOV DX, OFFSET MESSAGE
MOV AH, 09H
INT 21H

