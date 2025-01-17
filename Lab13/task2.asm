; Define configuration bits
    LIST P=18F452
    #include <p18f452.inc>

; Set configuration bits
    CONFIG OSC = HS
    CONFIG WDT = OFF
    CONFIG LVP = OFF
    CONFIG DEBUG = OFF

; Define registers
TEMP EQU 0x20  ; Temporary register for toggling

; Start of code
    ORG 0x0000           ; Reset vector
    GOTO MAIN            ; Jump to main program

    ORG 0x0008           ; High-priority interrupt vector
    GOTO HIGH_ISR        ; Jump to high-priority ISR

    ORG 0x0018           ; Low-priority interrupt vector
    GOTO LOW_ISR         ; Jump to low-priority ISR

; Main Program
MAIN:
    CLRF PORTB           ; Clear PORTB
    CLRF LATB            ; Clear Latch for PORTB
    MOVLW 0x00
    MOVWF TRISB          ; Set PORTB as output

    ; Configure Timer0
    CLRF T0CON           ; Clear Timer0 control register
    MOVLW 0x87           ; Timer0: 8-bit mode, prescaler 1:256
    MOVWF T0CON          ; Enable Timer0

    ; Configure INT1
    BSF INTCON3, INT1IE  ; Enable INT1 interrupt
    BCF INTCON3, INT1IF  ; Clear INT1 interrupt flag
    BSF RCON, IPEN       ; Enable priority levels on interrupts
    BSF INTCON3, INT1IP  ; Set INT1 as high-priority

    ; Enable Timer0 interrupt
    BSF INTCON, TMR0IE   ; Enable Timer0 interrupt
    BCF INTCON, TMR0IF   ; Clear Timer0 interrupt flag
    BCF INTCON2, TMR0IP  ; Set Timer0 interrupt as low-priority

    ; Enable global interrupts
    BSF INTCON, GIEH     ; Enable high-priority interrupts
    BSF INTCON, GIEL     ; Enable low-priority interrupts

LOOP:
    GOTO LOOP            ; Infinite loop

; High-Priority Interrupt Service Routine
HIGH_ISR:
    BTFSS INTCON3, INT1IF ; Check if INT1 caused the interrupt
    RETFIE FAST           ; Return if not INT1
    BCF INTCON3, INT1IF   ; Clear INT1 interrupt flag
    ; Toggle RB2
    MOVF LATB, W          ; Read LATB
    XORLW 0x04            ; Toggle RB2 (bit 2)
    MOVWF LATB            ; Write back to LATB
    RETFIE FAST           ; Return from high-priority ISR

; Low-Priority Interrupt Service Routine
LOW_ISR:
    BTFSS INTCON, TMR0IF  ; Check if Timer0 caused the interrupt
    RETFIE                ; Return if not Timer0
    BCF INTCON, TMR0IF    ; Clear Timer0 interrupt flag
    ; Toggle RB1
    MOVF LATB, W          ; Read LATB
    XORLW 0x02            ; Toggle RB1 (bit 1)
    MOVWF LATB            ; Write back to LATB
    RETFIE                ; Return from low-priority ISR

    END
