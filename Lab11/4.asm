INCLUDE <p18f452.inc>      ; Include header file for PIC18F452

; Define constants
INPUT_MASK      EQU 0x0F    ; Mask for 4-bit input (00001111)

; *****************************
; Main Program
; *****************************
                ORG 0x0000    ; Program start address
                GOTO MAIN     ; Jump to main program

MAIN:
                ; Initialization
                CLRF PORTB    ; Clear PORTB (turn off all LEDs)
                MOVLW 0x00    ; Set all PORTB pins as output
                MOVWF TRISB   ; Configure PORTB as output (RB7 will be output)
                MOVLW 0x0F    ; Set lower 4 bits of PORTD as input
                MOVWF TRISD   ; Configure RD0-RD3 as input

                ; Enable pull-ups for PORTD (if needed)
                MOVLW 0xF0     ; Enable pull-ups on RD0-RD3 (if needed)
                MOVWF INTCON2

MAIN_LOOP:
                ; Read 4-bit input from PORTD
                MOVF PORTD, W   ; Move PORTD value into WREG
                ANDLW INPUT_MASK ; Mask only lower 4 bits (RD0-RD3)

                ; *** DEBUGGING: Display PORTD value on PORTB ***
                MOVWF PORTB    ; Display PORTD value on PORTB for debugging

                ; *** DEBUGGING: Blink an LED to indicate loop execution ***
                BSF PORTB, 7   ; Turn on an indicator LED (e.g., RB7)
                CALL DELAY     ; Short delay 
                BCF PORTB, 7   ; Turn off the indicator LED

                CALL LIGHT_UP  ; Call subroutine to light up LEDs
                GOTO MAIN_LOOP ; Repeat the process

; *****************************
; Subroutine: LIGHT_UP
; Inputs: WREG contains the 4-bit value
; Outputs: Lights up the corresponding LEDs on PORTB
; *****************************
LIGHT_UP:
                CLRF PORTB      ; Clear PORTB before lighting LEDs
                MOVF WREG, W    ; Copy the value from WREG to WREG again

                ; Check the bits in WREG and turn on corresponding LEDs
                BTFSS WREG, 0   ; Check bit 0
                BSF PORTB, 0    ; If set, light up LED 0
                BTFSS WREG, 1   ; Check bit 1
                BSF PORTB, 1    ; If set, light up LED 1
                BTFSS WREG, 2   ; Check bit 2
                BSF PORTB, 2    ; If set, light up LED 2
                BTFSS WREG, 3   ; Check bit 3
                BSF PORTB, 3    ; If set, light up LED 3

                RETURN

; *****************************
; Delay Subroutine 
; *****************************
DELAY:
                MOVLW d'255'    ; Load WREG with a value
                MOVWF COUNT1   ; Move the value to COUNT1

DELAY_LOOP1:
                DECFSZ COUNT1, F ; Decrement COUNT1, skip next if 0
                GOTO DELAY_LOOP1 ; Loop until COUNT1 is 0

                RETURN          ; Return from subroutine

; *****************************
; Variables
; *****************************
COUNT1          EQU 0x20     ; Define a variable named COUNT1

; *****************************
; End of Program
; *****************************
                END
