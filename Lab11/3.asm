; *****************************
; Timer0 Controlled LED
; *****************************

INCLUDE <p18f452.inc>      ; Include header file for PIC18F452

; Define constants
TIMER0_OVERFLOW_COUNT EQU 0x20   ; Set this value based on desired delay

; Define variable for counting
COUNT1          EQU 0x20   ; Define memory location for count variable

; *****************************
; Main Program
; *****************************
                ORG 0x0000    ; Program start address
                GOTO MAIN     ; Jump to main program

MAIN:
                ; Initialization
                CLRF PORTB    ; Clear PORTB (turn off all LEDs)
                MOVLW 0xFF    ; Set PORTB as output
                MOVWF TRISB   ; Configure PORTB as output
                MOVLW 0x00    ; Set PORTC5 as input
                MOVWF TRISC   ; Configure PORTC5 as input
                CLRF TMR0     ; Clear Timer0 register

                ; Configure Timer0
                MOVLW 0x07    ; Set prescaler to 256
                MOVWF T0CON   ; Set Timer0 control register

                ; Timer0 start (start counting)
                BSF T0CON, TMR0ON  ; Turn on Timer0

WAIT_FOR_HIGH:
                ; Wait until PORTC5 is high
                BTFSC PORTC, 5    ; Check if PORTC5 is high
                GOTO WAIT_FOR_HIGH ; Loop until PORTC5 is high

                ; Timer0 will count for 3 seconds (based on prescaler)
                MOVLW 0xFF   ; Set up for 3-second delay (or adjust as needed)
                MOVWF COUNT1   ; Load counter

START_TIMER:
                BTFSS INTCON, T0IF   ; Check if Timer0 overflow interrupt flag is set
                GOTO START_TIMER     ; Wait for overflow (no action)
                BCF INTCON, T0IF     ; Clear the interrupt flag
                DECFSZ COUNT1, F ; Decrement the counter
                GOTO START_TIMER

                ; Turn on LED after 3 seconds
                BSF PORTB, 0    ; Turn on LED at PORTB pin 0

                ; Now do any further operations you want
                GOTO MAIN   ; Keep repeating the cycle

; *****************************
; End of Program
; *****************************
                END
