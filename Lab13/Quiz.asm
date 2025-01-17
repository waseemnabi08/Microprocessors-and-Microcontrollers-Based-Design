    LIST P=18F452            ; Specify the microcontroller
    #include <p18f452.inc>   ; Include the PIC18F452 header file

    
    ORG 0x00                 ; Reset vector
    GOTO START               ; Jump to start of program

;----------------------------------------------------------
; Initialization Section
;----------------------------------------------------------
START:
    CLRWDT                   ; Clear watchdog timer
    BCF INTCON, GIE          ; Disable global interrupts
    BCF INTCON, PEIE         ; Disable peripheral interrupts
    CLRF PORTB               ; Clear PORTB (output for LED bargraph)
    CLRF PORTD               ; Clear PORTD (input from switches)
    
    ; Set PORTD as input (TRISD = 0xFF)
    MOVLW 0xFF
    MOVWF TRISD

    ; Set PORTB as output (TRISB = 0x00)
    CLRF TRISB

    ; Main loop
MAIN_LOOP:
    MOVF PORTD, W            ; Read input from PORTD
    MOVWF INPUT              ; Store input value in INPUT register

    ; Check if input is between 1 and 15 (Perfect Square Check)
    MOVF INPUT, W
    SUBLW 1                  ; Check if input >= 1
    BTFSS STATUS, Z          ; If not, skip to next check
    GOTO FIBO_CHECK          ; Jump to Fibonacci check

    MOVF INPUT, W
    SUBLW 15                 ; Check if input <= 15
    BTFSC STATUS, Z          ; If input <= 15, continue
    GOTO FIBO_CHECK          ; Jump to Fibonacci check

    ; Perfect Square Check (for input between 1 and 15)
    MOVF INPUT, W
    CALL IS_SQUARE           ; Call subroutine to check if the number is a perfect square
    MOVF RESULT, W
    MOVWF PORTB              ; Display result on PORTB
    CALL DELAY               ; Wait for a while before moving on
    GOTO MAIN_LOOP           ; Restart the main loop

FIBO_CHECK:
    ; Check if input is between 16 and 30 (Fibonacci Calculation)
    MOVF INPUT, W
    SUBLW 16                 ; Check if input >= 16
    BTFSS STATUS, Z          ; If not, skip to next check
    GOTO MULTIPLY_TABLE      ; Jump to multiplication table

    MOVF INPUT, W
    SUBLW 30                 ; Check if input <= 30
    BTFSC STATUS, Z          ; If input <= 30, continue
    GOTO MULTIPLY_TABLE      ; Jump to multiplication table

    ; Fibonacci Sequence Calculation (for input between 16 and 30)
    MOVF INPUT, W            ; Get input value
    MOVWF FIB_COUNT          ; Store input value in FIB_COUNT register

    ; Initialize Fibonacci sequence (fib1 = 0, fib2 = 1)
    CLRF FIB1
    MOVLW 0x01
    MOVWF FIB2

FIB_LOOP:
    MOVF FIB1, W             ; Get fib1
    ADDWF FIB2, W            ; fib_next = fib1 + fib2
    MOVWF FIB_NEXT           ; Store the result in FIB_NEXT
    MOVF FIB2, W             ; Update fib1
    MOVWF FIB1
    MOVF FIB_NEXT, W         ; Update fib2
    MOVWF FIB2

    ; Check if we've reached the input number
    DECFSZ FIB_COUNT, F      ; Decrement FIB_COUNT and skip if zero
    GOTO FIB_LOOP

    MOVF FIB_NEXT, W         ; Display the last Fibonacci number on PORTB
    MOVWF PORTB
    CALL DELAY               ; Wait for a while before moving on
    GOTO MAIN_LOOP           ; Restart the main loop

MULTIPLY_TABLE:
    ; Check if input >= 31 (Multiplication Table)
    MOVF INPUT, W
    SUBLW 31                 ; Check if input >= 31
    BTFSS STATUS, Z          ; If not, skip to next check
    GOTO MAIN_LOOP           ; Restart main loop if input < 31

    ; Get MSB of the input number (for multiplication table)
    MOVF INPUT, W
    SWAPF WREG, W            ; Swap nibbles to get MSB
    ANDLW 0x0F               ; Mask to get the MSB
    MOVWF MULTIPLIER         ; Store MSB in MULTIPLIER register

    ; Display the first three multiplication results
    MOVLW 1
    MOVWF COUNTER            ; Set counter to 1

MUL_LOOP:
    MOVF MULTIPLIER, W
    MULWF COUNTER            ; Multiply MULTIPLIER by COUNTER
    MOVWF PORTB              ; Display the result on PORTB
    CALL DELAY               ; Wait for a while
    INCF COUNTER, F          ; Increment counter
    MOVF COUNTER, W
    SUBLW 4                  ; Check if we have done 3 multiplications
    BTFSS STATUS, Z          ; If not, continue loop
    GOTO MUL_LOOP

    GOTO MAIN_LOOP           ; Restart the main loop

;----------------------------------------------------------
; Subroutine: IS_SQUARE (Check if number is a perfect square)
;----------------------------------------------------------
IS_SQUARE:
    CLRF RESULT              ; Clear result (default 0)
    MOVF INPUT, W
    MOVWF TEMP_INPUT         ; Store input in TEMP_INPUT
    MOVLW 1                  ; Start checking from 1
    MOVWF COUNTER

SQUARE_LOOP:
    MOVF COUNTER, W
    MULWF COUNTER            ; Multiply COUNTER by itself
    MOVF PROD, W             ; Get the result of COUNTER * COUNTER
    SUBWF TEMP_INPUT, W      ; Subtract input from COUNTER^2
    BTFSS STATUS, Z          ; If the result is zero, it's a perfect square
    GOTO NEXT_SQUARE
    MOVLW 1
    MOVWF RESULT             ; Set result to input (perfect square)
    RETURN

NEXT_SQUARE:
    INCF COUNTER, F          ; Increment COUNTER
    MOVF COUNTER, W
    SUBLW TEMP_INPUT         ; Check if COUNTER^2 exceeds input
    BTFSC STATUS, C          ; If COUNTER^2 > input, exit
    GOTO SQUARE_LOOP
    RETURN

;----------------------------------------------------------
; Subroutine: DELAY (Simple delay loop)
;----------------------------------------------------------
DELAY:
    MOVLW 0xFF
    MOVWF DELAY_COUNT
DELAY_LOOP:
    DECFSZ DELAY_COUNT, F
    GOTO DELAY_LOOP
    RETURN

;----------------------------------------------------------
; Variables Section
;----------------------------------------------------------
INPUT      RES 1
RESULT     RES 1
TEMP_INPUT RES 1
FIB_COUNT  RES 1
FIB1       RES 1
FIB2       RES 1
FIB_NEXT   RES 1
MULTIPLIER RES 1
COUNTER    RES 1
DELAY_COUNT RES 1

    END                     ; End of the program
