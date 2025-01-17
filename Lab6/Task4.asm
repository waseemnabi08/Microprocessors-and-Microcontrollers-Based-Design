; COM file is loaded at CS:0100h
ORG 100h

.DATA
; Predefined values
A dw 0      
B dw 0     
C dw 0      
A1 dw 0  ; A^2
B1 dw 0  ; B^2
C1 dw 0  ; C^2
msg db 0dh, 0ah, 'Enter A: $'
msg1 db 0dh, 0ah, 'Enter B: $'
msg2 db 0dh, 0ah, 'Enter C: $'

.CODE

START:
    ; Get input for A
    LEA DX, msg
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, '0'      ; Convert ASCII to numeric
    MOV A, AX       ; Store input in A

    ; Get input for B
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, '0'      ; Convert ASCII to numeric
    MOV B, AX       ; Store input in B

    ; Get input for C
    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, '0'      ; Convert ASCII to numeric
    MOV C, AX       ; Store input in C

    ; Calculate (A * 3) / (B + 1)
    MOV AX, A
    MOV BX, 3
    MUL BX           ; AX = A * 3 (result in AX)

    MOV BX, B
    INC BX           ; BX = B + 1
    CMP BX, 0
    JE setZ          ; If B + 1 = 0, set zero flag (cannot divide by zero)

    ; Perform the division
    XOR DX, DX       ; Clear DX for division
    IDIV BX          ; AX = (A * 3) / (B + 1)

    CMP AX, 5        ; Compare result with 5
    JG setC          ; If greater than 5, set carry flag

    ; Calculate (C / 2) + (A / B)
    MOV AX, C
    MOV BX, 2
    XOR DX, DX       ; Clear DX for division
    IDIV BX          ; AX = C / 2 (result in AX)

    ; Now calculate A / B
    MOV BX, B
    CMP BX, 0
    JE setZ          ; If B = 0, set zero flag

    MOV CX, A
    XOR DX, DX       ; Clear DX for division
    IDIV BX          ; AX = (A / B)

    ADD AX, CX       ; AX = (C / 2) + (A / B)
    CMP AX, 4        ; Compare with 4
    JLE setP         ; If less than or equal to 4, set parity flag

    ; If we reach here, clear flags
    JMP clearALL

setC:
    STC              ; Set carry flag
    JMP exit

setP:
    MOV AL, 02h      ; Set AL to 2 (for parity flag)
    JMP exit

setZ:
    XOR AX, AX       ; Set AX to 0 (set zero flag)
    JMP exit

clearAll:
    CLC              ; Clear carry flag
    ; Set AL to 0 to clear parity flag (this is not direct but logical)
    ; Zero the parity flag is done through other checks

exit:
    MOV AX, 4C00h    ; Terminate program
    INT 21h

END START
