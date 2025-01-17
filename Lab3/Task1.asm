; COM file is loaded at CS:0100h
ORG 100h           ; COM files start execution from offset 100h

.DATA
    msg DB 'Enter your first name (max 9 characters): $'
    buffer DB 9, 0, 9 DUP('$')  ; First byte: max length, Second byte: actual length, rest: input space
    msg1 DB 0Dh, 0Ah, 'Your name is: $'

.CODE

START:
    ; Display prompt message
    LEA DX, msg
    MOV AH, 09h
    INT 21h

    ; Read the user input (buffered input)
    MOV AH, 0Ah
    LEA DX, buffer
    INT 21h

    ; Display "Your name is:"
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    ; Display the entered name (from buffer[2] onwards)
    LEA DX, buffer + 2  ; Skip first two bytes (buffer size and input length)
    MOV AH, 09h
    INT 21h

    ; Exit the program
    MOV AH, 4Ch
    INT 21h

RET
