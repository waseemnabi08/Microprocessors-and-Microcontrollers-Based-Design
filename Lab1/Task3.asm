#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

MOV AH, 01H

INT 21H
 
