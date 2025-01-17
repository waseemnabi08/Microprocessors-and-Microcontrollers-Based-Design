#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

.CODE

MOV BX, 95

LOOP_START:

CMP BX, 5
JL END_LOOP

ADD AX, BX

SUB BX, 5
jmp LOOP_START

END_LOOP:

ret