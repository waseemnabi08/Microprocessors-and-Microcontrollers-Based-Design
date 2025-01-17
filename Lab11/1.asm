INCLUDE <p18f452.inc>      ; Include the PIC18F452 header file

; Define file registers for delay counters
COUNT1      EQU 0x20       ; Outer loop counter
COUNT2      EQU 0x21       ; Inner loop counter

    ORG 0x0000             ; Reset vector
    GOTO MAIN              ; Jump to the main program

MAIN:
    ; Configure RB1 as output
    CLRF PORTB             ; Clear PORTB
    BCF TRISB, 1           ; Set RB1 as output (clear bit 1 of TRISB)

TOGGLE_LOOP:
    ; Toggle RB1
    BSF LATB, 1            ; Turn RB1 ON
    CALL DELAY_1S          ; Wait for 1 second
    BCF LATB, 1            ; Turn RB1 OFF
    CALL DELAY_1S          ; Wait for 1 second
    GOTO TOGGLE_LOOP       ; Repeat

; 1-second delay subroutine
DELAY_1S:
    MOVLW D'250'           ; Outer loop (repeat 250 times)
    MOVWF COUNT1

DELAY_LOOP1:
    MOVLW D'250'           ; Inner loop (repeat 250 times)
    MOVWF COUNT2

DELAY_LOOP2:
    NOP                    ; No operation (short delay)
    DECFSZ COUNT2, F       ; Decrement inner loop counter
    GOTO DELAY_LOOP2       ; Repeat inner loop
    DECFSZ COUNT1, F       ; Decrement outer loop counter
    GOTO DELAY_LOOP1       ; Repeat outer loop
    RETURN                 ; Return after 1-second delay

    END                    ; End of program
