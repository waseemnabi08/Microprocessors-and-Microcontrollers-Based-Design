; COM file is loaded at CS:0100h
ORG 100h

.DATA
MESSAGE DB 'Waseem Ghulam', 0Dh, 0Ah, 'DE-44', 0Dh, 0Ah, 'Computer Engineering', 0Dh, 0Ah, '$'

.CODE
MOV DX, OFFSET MESSAGE
MOV AH, 09H
INT 21H

RET
