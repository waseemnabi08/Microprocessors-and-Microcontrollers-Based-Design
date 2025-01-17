	LIST P=18F452           ; Specify the processor
    #include <p18f452.inc>  ; Include the device file for PIC18F452


    ; Define delay count
    DELAY_COUNT EQU 0x20    ; Memory location for delay variable

    ORG 0x0000              ; Set program start address
    GOTO Start              ; Jump to the start of the program

Start:
	    ; Configure for external RC oscillator (XT mode)
  	  movlw   b'11111000'     ; Set FOSC bits for XT mode 
   	 movwf   OSCCON           ; Write to OSCCON register
	

    ; Initialize PORTD
    CLRF PORTC              ; Clear PORTC
    MOVLW 0x00              ; Set PORTD as output
    MOVWF TRISC

MainLoop:
    ; Turn on even LEDs (binary 10101010 = 0xAA)
    MOVLW 0xAA              ; Load W with 0xAA
    MOVWF PORTC             ; Set PORTC with even LEDs on
    CALL Delay              ; Call delay subroutine

    ; Turn off all LEDs
    CLRF PORTC              ; Clear PORTC (all LEDs off)
    CALL Delay              ; Call delay subroutine

    GOTO MainLoop           ; Repeat the loop

; Delay subroutine
Delay:
    MOVLW D'250'            ; Outer loop count
    MOVWF DELAY_COUNT       ; Move to delay variable
DelayLoop:
    NOP                     ; Do nothing (1 cycle)
    NOP                     ; Do nothing (1 cycle)
    DECFSZ DELAY_COUNT, F   ; Decrement delay count, skip if zero
    GOTO DelayLoop          ; Repeat until DELAY_COUNT reaches 0
    RETURN

    END
