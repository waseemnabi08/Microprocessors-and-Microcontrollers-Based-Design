ORG 100h
.MODEL SMALL
.STACK 100H
.DATA
    PROMPT DB 'Enter a number between 0 and 9: $'
    INVALID DB 0DH, 0AH, 'Invalid input! Program will now terminate.$'
    GRADE_A DB 0DH, 0AH, 'Grade A', 0DH, 0AH, '$'
    GRADE_B DB 0DH, 0AH, 'Grade B', 0DH, 0AH, '$'
    GRADE_C DB 0DH, 0AH, 'Grade C', 0DH, 0AH, '$'

.CODE
START:
    MOV AX, @DATA       ; Initialize data segment
    MOV DS, AX
    
    ; Begin Loop
LOOP_INPUT:
    LEA DX, PROMPT      ; Display the prompt message
    MOV AH, 09H
    INT 21H
    
    ; Get user input
    MOV AH, 01H
    INT 21H
    
    SUB AL, '0'         ; Convert ASCII to number (0-9)
    
    ; Check if input is out of bounds (negative or > 9)
    CMP AL, 0           ; Is number negative?
    JL EXIT_PROGRAM     ; Jump if less than 0
    CMP AL, 9           ; Is number greater than 9?
    JG EXIT_PROGRAM     ; Jump if greater than 9
    
    ; Check and display grade
    CMP AL, 7           ; Check if grade is A
    JGE DISPLAY_A       ; If AL >= 7, display grade A
    CMP AL, 5           ; Check if grade is B
    JGE DISPLAY_B       ; If AL >= 5, display grade B
    JMP DISPLAY_C       ; Otherwise, display grade C
    
DISPLAY_A:
    LEA DX, GRADE_A     ; Display "Grade A"
    MOV AH, 09H
    INT 21H
    JMP LOOP_INPUT
    
DISPLAY_B:
    LEA DX, GRADE_B     ; Display "Grade B"
    MOV AH, 09H
    INT 21H
    JMP LOOP_INPUT
    
DISPLAY_C:
    LEA DX, GRADE_C     ; Display "Grade C"
    MOV AH, 09H
    INT 21H
    JMP LOOP_INPUT

EXIT_PROGRAM:
    LEA DX, INVALID     ; Display invalid input message
    MOV AH, 09H
    INT 21H
    
    MOV AH, 4CH         ; Terminate the program
    INT 21H

END START
