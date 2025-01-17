; COM file is loaded at CS:0100h
ORG 100h

.data
prompt db 'Enter a string: $'
prompt1 db 0Dh,0Ah, 'Enter second string: $'
prompt2 db 0Dh,0Ah, 'A comes first $'
prompt3 db 0Dh,0Ah, 'B comes first $'
prompt4 db 0Dh,0Ah, 'Identical $'
buffer db 20                 ; Maximum input size (up to 20 characters)
       db ?                  ; Placeholder for actual input length
       db 20 dup(0)          ; Space for the actual input characters
buffer1 db 20                 ; Maximum input size (up to 20 characters)
       db ?                  ; Placeholder for actual input length
       db 20 dup(0)          ; Space for the actual input characters

.code
main proc
    mov ax, @data           
    mov ds, ax              ;

    ; Display first prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Take first string input
    lea dx, buffer          ; Load address of buffer into DX
    mov ah, 0Ah             ; DOS function 0Ah - Buffered Input
    int 21h                 ; Call DOS interrupt

    ; Display second prompt
    mov ah, 09h
    lea dx, prompt1
    int 21h

    ; Take second string input
    lea dx, buffer1          ; Load address of buffer1 into DX
    mov ah, 0Ah              ; DOS function 0Ah - Buffered Input
    int 21h                 

    ; Initialize SI to start comparing strings from the first character
    MOV SI, 2              ; Offset to the first character in both buffers

COMPARE_LOOP:
    MOV AL, [buffer + SI]      
    MOV BL, [buffer1 + SI]     
    CMP AL, BL                 
    JG B_COMES_FIRST           
    JL A_COMES_FIRST          
    
    ; If characters are equal, check if end of any string is reached
    CMP AL, 0                  
    JE STRINGS_IDENTICAL       
    CMP BL, 0                  
    JE STRINGS_IDENTICAL       

    INC SI                     
    JMP COMPARE_LOOP           

A_COMES_FIRST:
    ; Display "A comes first"
    mov ah, 09h
    lea dx, prompt2
    int 21h
    JMP END_PROGRAM            

B_COMES_FIRST:
    ; Display "B comes first"
    mov ah, 09h
    lea dx, prompt3
    int 21h
    JMP END_PROGRAM            

STRINGS_IDENTICAL:
    ; Display "Identical"
    mov ah, 09h
    lea dx, prompt4
    int 21h

END_PROGRAM:
    mov ah, 4Ch                ; DOS function 4Ch - Terminate program
    int 21h

main endp

end main