; COM file is loaded at CS:0100h
ORG 100h           ; COM files start execution from offset 100h

.DATA
    msg DB 'Enter your first name (max 9 characters): $'
    msg2 DB 0Dh, 0Ah, 'Enter your last name (max 9 characters): $'
    buffer DB 9, 0, 9 DUP('$')
    
    buffer2 DB 9, 0, 9 DUP('$')
    msg1 DB 0Dh, 0Ah, 'Your full name is: $'
    space DB ' '

.CODE

START:

    LEA DX, msg
    MOV AH, 09h
    INT 21h

    MOV AH, 0Ah
    LEA DX, buffer
    INT 21h

    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    MOV AH, 0Ah
    LEA DX, buffer2
    INT 21h
    
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    MOV AH, 09H
    MOV BH, 00H          
    MOV BL, buffer[1] ;
    MOV buffer[BX+2], '$'
    LEA DX, buffer[2]; 
    INT 21H              

    MOV AH, 02H          
    MOV DL, ' '           
    INT 21H               

    MOV AH, 09H  
    MOV BH, 00H           
    MOV BL, buffer2[1]  ; 
    MOV buffer2[BX+2], '$'
    LEA DX, buffer2[2]; Lo
    INT 21H        
    
    MOV AH, 4Ch
    INT 21h

RET