LIST P=18F452
#include <P18F452.INC>

; Define Registers
TEMP EQU 0x20              ; Temporary register
DELAY_COUNT EQU 0x21       ; Delay counter

; Define Ports and Bits
RED_LIGHT EQU PORTB      ; Red LED on RB0
YELLOW_LIGHT EQU PORTB   ; Yellow LED on RB1
GREEN_LIGHT EQU PORTB    ; Green LED on RB2
PED_SIGNAL EQU PORTB     ; Pedestrian LED on RB3
EMERGENCY_BUTTON EQU PORTA ; Emergency button on RA0
PED_BUTTON EQU PORTA     ; Pedestrian button on RA1

; Initialize Variables
ORG 0x00
    GOTO MAIN              ; Jump to main program

; Interrupt Vector
ORG 0x08
    GOTO ISR               ; Jump to interrupt service routine

; Main Program
MAIN:
    CLRF PORTB             ; Clear PORTB
    CLRF PORTA             ; Clear PORTA
    MOVLW 0x03             ; Configure PORTA<1:0> as input
    MOVWF TRISA
    MOVLW 0xF0             ; Configure PORTB<4:0> as output
    MOVWF TRISB

    CALL INIT_TIMER0       ; Initialize Timer0
    BSF INTCON, GIE        ; Enable global interrupts
    BSF INTCON, PEIE       ; Enable peripheral interrupts
    BSF INTCON2, INTEDG0   ; Interrupt on rising edge for INT0
    BSF INTCON2, INTEDG1   ; Interrupt on rising edge for INT1
    BSF INTCON3, INT1E     ; Enable INT1 interrupt (Pedestrian button)
    BSF INTCON, INT0E      ; Enable INT0 interrupt (Emergency button)

NORMAL_SEQUENCE:
    ; Green Light ON for 5 seconds
    BSF PORTB, 2           ; Turn on Green LED
    CALL DELAY_5S
    BCF PORTB, 2           ; Turn off Green LED

    ; Yellow Light ON for 3 seconds
    BSF PORTB, 1           ; Turn on Yellow LED
    CALL DELAY_3S
    BCF PORTB, 1           ; Turn off Yellow LED

    ; Red Light ON for 4 seconds
    BSF PORTB, 0           ; Turn on Red LED
    CALL DELAY_4S
    BCF PORTB, 0           ; Turn off Red LED

    GOTO NORMAL_SEQUENCE

PEDESTRIAN_MODE:
    BSF PORTB, 3           ; Turn on Pedestrian LED
    CALL DELAY_5S          ; Pedestrian signal for 5 seconds
    BCF PORTB, 3           ; Turn off Pedestrian LED
    GOTO NORMAL_SEQUENCE

EMERGENCY_MODE:
    BSF PORTB, 0           ; Turn on Red LED
    BCF PORTB, 1           ; Turn off Yellow LED
    BCF PORTB, 2           ; Turn off Green LED
    BSF PORTB, 3           ; Keep Pedestrian LED ON
WAIT_EMERGENCY:
    BTFSC PORTA, 0         ; Wait for Emergency Button to be released
    GOTO WAIT_EMERGENCY
    GOTO NORMAL_SEQUENCE

; Timer0 Initialization
INIT_TIMER0:
    MOVLW 0x87             ; Configure Timer0: Prescaler 1:64
    MOVWF T0CON
    RETURN

; Interruptible Delays
DELAY_5S:
    MOVLW 50               ; 5 seconds = 50 x 100ms
    MOVWF DELAY_COUNT
DELAY_LOOP_5S:
    CALL TIMER_DELAY
    DECFSZ DELAY_COUNT, F
    GOTO DELAY_LOOP_5S
    RETURN

DELAY_3S:
    MOVLW 30               ; 3 seconds = 30 x 100ms
    MOVWF DELAY_COUNT
DELAY_LOOP_3S:
    CALL TIMER_DELAY
    DECFSZ DELAY_COUNT, F
    GOTO DELAY_LOOP_3S
    RETURN

DELAY_4S:
    MOVLW 40               ; 4 seconds = 40 x 100ms
    MOVWF DELAY_COUNT
DELAY_LOOP_4S:
    CALL TIMER_DELAY
    DECFSZ DELAY_COUNT, F
    GOTO DELAY_LOOP_4S
    RETURN

; 100ms Delay with Button Check
TIMER_DELAY:
    MOVLW 0xC2             ; Load high byte of TMR0
    MOVWF TMR0H
    MOVLW 0xF7             ; Load low byte of TMR0
    MOVWF TMR0L
    BCF INTCON, TMR0IF     ; Clear Timer0 Overflow Flag
    BSF T0CON, TMR0ON      ; Start Timer0
WAIT_LOOP:
    BTFSS INTCON, TMR0IF   ; Wait for Timer0 overflow
    GOTO WAIT_LOOP
    BCF INTCON, TMR0IF     ; Clear Timer0 overflow flag
    RETURN

; Interrupt Service Routine
ISR:
    BTFSC INTCON, INT0IF   ; Check for Emergency Button interrupt
    GOTO EMERGENCY_MODE
    BTFSC INTCON3, INT1IF  ; Check for Pedestrian Button interrupt
    GOTO PEDESTRIAN_MODE
    BCF INTCON, INT0IF     ; Clear INT0 flag
    BCF INTCON3, INT1IF    ; Clear INT1 flag
    RETFIE

END
