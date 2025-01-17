INCLUDE <P18F452.INC>
ORG 0x0000        ; Reset vector
    GOTO MAIN         ; Jump to main program

    ORG 0x0008        ; Interrupt vector
ISR
    BTFSS INTCON, INT0IF ; Check if INT0 interrupt occurred
    RETFIE                ; Return if no interrupt
    BCF INTCON, INT0IF    ; Clear INT0 interrupt flag
    MOVLW 0x01           ; Toggle LED state
    XORWF PORTB, F
    RETFIE               ; Return from interrupt

MAIN
    CLRF PORTB          ; Clear PORTB
    CLRF TRISB          ; Set PORTB as output
    BSF TRISC, 0        ; Set RC0 as input

    BSF INTCON, GIE     ; Enable global interrupts
    BSF INTCON, INT0IE  ; Enable INT0 interrupt

LOOP
    GOTO LOOP           ; Infinite loop
    END
