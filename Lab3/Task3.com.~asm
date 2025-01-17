ORG 100h           ; COM files start execution from offset 100h

.DATA
    msg DB 'Enter your first name (max 9 characters): $'
    msg2 DB 0Dh, 0Ah, 'Enter your last name (max 9 characters): $'
    buffer DB 9, 0, 9 DUP('$')
    
    buffer2 DB 9, 0, 9 DUP('$')
    msg1 DB 0Dh, 0Ah, 'chars in first and last name respectively: $'
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

    ; Convert number of characters in buffer[1] to ASCII and print
    MOV DL, buffer[1]
    ADD DL, 30h    ; Convert to ASCII
    MOV AH, 02h    ; Print character in DL
    INT 21h              

    ; Print a space
    MOV AH, 02h          
    MOV DL, ' '           
    INT 21h               

    ; Convert number of characters in buffer2[1] to ASCII and print
    MOV DL, buffer2[1]
    ADD DL, 30h    ; Convert to ASCII
    MOV AH, 02h    ; Print character in DL
    INT 21h

    ; Exit the program
    MOV AH, 4Ch
    INT 21h
