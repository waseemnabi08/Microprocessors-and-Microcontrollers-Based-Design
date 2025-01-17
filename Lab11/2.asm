INCLUDE <p18f452.inc>      ; Include the PIC18F452 header file

; Define constants and file registers
COUNT1      EQU 0x20       ; Outer loop counter for delay
COUNT2      EQU 0x21       ; Inner loop counter for delay

    ORG 0x0000             ; Reset vector
    GOTO MAIN              ; Jump to the main program

MAIN:
    ; Configure RB7 as output
    CLRF PORTB             ; Clear PORTB
    BCF TRISB, 7           ; Set RB7 as output (clear bit 7 of TRISB)

SQUARE_LOOP:
    BSF LATB, 7            ; Set RB7 high (start of square wave)
    CALL DELAY_60HZ        ; Delay for half-period (ON time)
    BCF LATB, 7            ; Set RB7 low (end of square wave)
    CALL DELAY_60HZ        ; Delay for half-period (OFF time)
    GOTO SQUARE_LOOP       ; Repeat indefinitely

; ******************************
; DELAY_60HZ Subroutine
; Generates a delay of 8.33 ms (half-period of 60 Hz)
; XTAL = 12 MHz, Timer0 with Prescaler = 64
; ******************************
DELAY_60HZ:
    ; Configure Timer0
    CLRF TMR0L             ; Clear Timer0 Low register
    CLRF TMR0H             ; Clear Timer0 High register
    MOVLW B'10000100'      ; Timer0: 16-bit mode, prescaler = 64
    MOVWF T0CON            ; Load Timer0 control register

    ; Load Timer0 registers for 8.33 ms
    ; Timer count = 65536 - (Delay / Clock Period) / Prescaler
    ; = 65536 - (8.33ms / 0.33us) / 64
    ; = 65536 - 395
    MOVLW 0xF9             ; Load high byte of 395 (65536 - 395 = F9A5)
    MOVWF TMR0H            ; High byte
    MOVLW 0xA5             ; Load low byte of 395
    MOVWF TMR0L            ; Low byte

    BSF T0CON, TMR0ON      ; Turn on Timer0

WAIT_TMR0:
    BTFSS INTCON, TMR0IF   ; Check Timer0 overflow flag
    GOTO WAIT_TMR0         ; Wait until Timer0 overflows

    BCF INTCON, TMR0IF     ; Clear Timer0 overflow flag
    RETURN                 ; Return to the main program

    END                    ; End of program
