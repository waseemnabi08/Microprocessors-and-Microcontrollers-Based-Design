; Define configuration bits
    LIST P=18F452
    #include <p18f452.inc>

; Set configuration bits
    CONFIG OSC = HS        ; High-speed oscillator
    CONFIG WDT = OFF       ; Watchdog timer disabled
    CONFIG LVP = OFF       ; Low-voltage programming disabled
    CONFIG DEBUG = OFF     ; Debugging disabled

; Start of code
    ORG 0x0000             ; Reset vector
    GOTO MAIN              ; Jump to main program

    ORG 0x0008             ; High-priority interrupt vector
    GOTO HIGH_ISR          ; Jump to high-priority ISR

    ORG 0x0018             ; Low-priority interrupt vector
    GOTO LOW_ISR           ; Jump to low-priority ISR

; Main Program
MAIN:
    CLRF PORTB             ; Clear PORTB (turn off buzzer initially)
    CLRF LATB              ; Clear LATB latch
    MOVLW 0x00
    MOVWF TRISB            ; Set PORTB as output (buzzer control)

    ; Configure INT2
    BSF INTCON2, INT2IE    ; Enable INT2 interrupt
    BCF INTCON2, INT2IF    ; Clear INT2 interrupt flag
    BSF RCON, IPEN         ; Enable priority levels on interrupts
    BSF INTCON2, INT2IP    ; Set INT2 as high-priority interrupt

    ; Enable global interrupts
    BSF INTCON, GIEH       ; Enable high-priority interrupts
    BSF INTCON, GIEL       ; Enable low-priority interrupts

    ; Infinite loop
LOOP:
    GOTO LOOP              ; Keep looping to wait for interrupts

; High-Priority Interrupt Service Routine
HIGH_ISR:
    BTFSS INTCON2, INT2IF  ; Check if INT2 caused the interrupt
    RETFIE FAST            ; Return if not INT2
    BCF INTCON2, INT2IF    ; Clear INT2 interrupt flag

    ; Turn on the buzzer (PORTB = 0xFF)
    MOVLW 0xFF
    MOVWF LATB             ; Set LATB to turn on buzzer
    RETFIE FAST            ; Return from high-priority ISR

; Low-Priority Interrupt Service Routine
LOW_ISR:
    ; No low-priority interrupt handling needed
    RETFIE                 ; Return from low-priority ISR

; End of program
    END
