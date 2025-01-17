#include <p18f452.h> // Include the header file for the PIC18F452

// Configuration settings
#pragma config OSC = HS // High-speed oscillator
#pragma config WDT = OFF // Watchdog Timer disabled
#pragma config LVP = OFF // Low-Voltage Programming disabled
#pragma config PWRT = ON // Power-up Timer enabled

// Function prototype
unsigned char is_palindrome(unsigned char input);

void main(void) {
    unsigned char input, result;

    // Initialization
    TRISD = 0xFF; // Set PORTD as input
    TRISB = 0x00; // Set PORTB as output
    LATB = 0x00;  // Clear PORTB output

    while (1) {
        input = PORTD; // Read 8-bit input from PORTD
        result = is_palindrome(input); // Check if the number is a palindrome

        if (result) {
            LATB = 0xFF; // Turn on all LEDs on PORTB if input is a palindrome
        } else {
            LATB = 0x00; // Turn off all LEDs on PORTB if not a palindrome
        }
    }
}

// Function to check if an 8-bit number is a palindrome
unsigned char is_palindrome(unsigned char input) {
    unsigned char reversed = 0, original = input;
    unsigned char i;

    for (i = 0; i < 8; i++) {
        reversed <<= 1; // Shift reversed number left
        reversed |= (input & 0x01); // Add the least significant bit of input to reversed
        input >>= 1; // Shift input right
    }

    // Check if the reversed number equals the original
    return (reversed == original);
}
