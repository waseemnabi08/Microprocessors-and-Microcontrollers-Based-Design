; Hello World Sample!

; Standard header:
	#make_COM#
        ORG  100H  

; Jump to start:
	JMP START

; Data:
msg DB 'Hello, World!', 13, 10
    DB 'Please Register.', 13, 10
    DB 'Thank you!', '$'


; Load address of msg to DX register:
START:  LEA DX, msg

; Print using DOS interrupt:
        MOV AH, 9
        INT 21h

; Exit to operating system:
        MOV AH, 4Ch
        INT 21h
