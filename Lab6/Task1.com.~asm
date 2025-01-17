; COM file is loaded at CS:0100h
ORG 100h

.DATA
; Predefined values
A DB 9      ; A = 9
B DB 10     ; B = 10
C DB 7      ; C = 7

a1 DB 0
b1 DB 0
c1 DB 0
d DB 0
e DB 0
f DB 0
g DB 0
h DB 0
i DB 0
j db 0 
k db 0

.CODE
 
; a. A = 5 * A - 7
MOV AL, A       ; Move value of A (9) to AL
MOV BL, 5       ; Move value 5 to BL
IMUL BL          ; AL = AL * BL -> A * 5
SUB AL, 7       ; AL = AL - 7
MOV a1, AL       ; Store the result back in A

; b. B = (A - B) * (B + 10)
MOV AL, A       ; Move A to AL
MOV BL, B       ; Move B to BL
SUB AL, BL      ; AL = A - B
ADD BL, 10      ; BL = B + 10
IMUL BL          ; AL = (A - B) * (B + 10)
MOV b1, AL       ; Store result back in B

; c. A = 6 - 9 * A
MOV AL, A       ; Move A to AL
MOV BL, 9       ; BL = 9
IMUL BL          ; AL = 9 * A
MOV BL, 6       ; BL = 6
SUB BL, AL      ; BL = 6 - (9 * A)
MOV c1, BL       ; Store result back in A

; d. A = 5 + 2 * B
MOV AL, B       ; Move B to AL
MOV BL, 2       ; BL = 2
IMUL BL          ; AL = 2 * B
ADD AL, 5       ; AL = 5 + (2 * B)
MOV d, AL       ; Store result back in A

; e. B = (B - 4) * (5 * B)
MOV AL, B       ; Move B to AL
SUB AL, 4       ; AL = B - 4
MOV BL, B       ; Move B to BL
MOV CL, 5       ; CL = 5
IMUL BL          ; BL = 5 * B
IMUL BL          ; AL = (B - 4) * (5 * B)
MOV e, AL       ; Store result back in B

; f. A = 12 - (4 * (A - B)) + (B * 2)
MOV AL, A       ; Move A to AL
MOV BL, B       ; Move B to BL
SUB AL, BL      ; AL = A - B
MOV CL, 4       ; CL = 4
IMUL CL          ; AL = 4 * (A - B)
MOV CL, 12      ; CL = 12
SUB CL, AL      ; CL = 12 - (4 * (A - B))
MOV AL, B       ; Move B to AL
SHL AL, 1       ; AL = B * 2 (shift left for multiplication by 2)
ADD CL, AL      ; CL = (12 - (4 * (A - B))) + (B * 2)
MOV f, CL       ; Store result back in A

; g. (10 - A) * (A + 4) + (B * 3)
MOV AL, A       ; Move A to AL
MOV BL, 10      ; BL = 10
SUB BL, AL      ; BL = 10 - A
MOV CL, A       ; Move A to CL
ADD CL, 4       ; CL = A + 4
IMUL BL          ; AL = (10 - A) * (A + 4)
MOV BL, B       ; Move B to BL
MOV CL, 3       ; CL = 3
IMUL BL          ; BL = B * 3
ADD AL, BL      ; AL = (10 - A) * (A + 4) + (B * 3)
MOV g, AL       ; Store result back in A

; h. A = 2 * (B ^ 2) + (A ^ 3)
MOV AL, B       ; Move B to AL
IMUL AL          ; AL = B * B (B^2)
SHL AL, 1       ; AL = 2 * (B^2)
MOV BL, A       ; Move A to BL
IMUL BL          ; BL = A * A (A^2)
IMUL BL          ; BL = A^3
ADD AL, BL      ; AL = 2 * (B^2) + (A^3)
MOV h, AL       ; Store result back in A

; i. (A ^ 3) - (5 * A) + 9
MOV AL, A       ; Move A to AL
IMUL AL          ; AL = A * A (A^2)
IMUL AL          ; AL = A^3
MOV BL, 5       ; BL = 5
IMUL BL          ; BL = 5 * A
ADD AL, 9       ; AL = A^3 - (5 * A) + 9
SUB AL, BL      ; AL = (A^3) - (5 * A) + 9
MOV i, AL       ; Store result back in A

; j. C = (B + 10) * 5 + (A * 3 ^ 2)
MOV AL, B       ; Move B to AL
ADD AL, 10      ; AL = B + 10
MOV BL, 5       ; BL = 5
IMUL AL          ; AL = (B + 10) * 5
MOV AL, A       ; Move A to AL
MOV CL, 3       ; CL = 3
IMUL AL          ; AL = A * 3
IMUL AL          ; AL = (A * 3) * 3 = A * 3^2
ADD AL, BL      ; AL = (B + 10) * 5 + (A * 3^2)
MOV j, AL       ; Store result back in C

; k. A = (10 * B) ^ 6 + (C ^ 2 + 3)
MOV AL, B       ; Move B to AL
MOV BL, 10      ; BL = 10
IMUL AL          ; AL = 10 * B
MOV CL, AL      ; CL = 10 * B
SHL CL, 5       ; CL = (10 * B)^6 (for simplicity)
MOV AL, C       ; Move C to AL
IMUL AL          ; AL = C * C = C^2
ADD AL, 3       ; AL = C^2 + 3
ADD CL, AL      ; CL = (10 * B)^6 + (C^2 + 3)
MOV k, CL       ; Store result back in A (only low byte)

; End of program
INT 20h          ; Terminate the program
