; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000
; initialize the stack
ld r6, stack_addr

lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
LEA R1, user_prompt ;parameter 1 (address of input prompt)
LEA R2, user_string ;parameter 2 (address to store user string)
LD R5, get_user_string_addr
JSRR R5

; find size of input string
LEA R1, user_string
LD R5, strlen_addr
JSRR R5

; call palindrome method
; * put your code here
ADD R2, R1, R0 ;parameter 2 (address of end of user string)
ADD R2, R2, #-1
LD R5, palindrome_addr;x3400
JSRR R5

; determine of string is a palindrome
; * put your code here
IF_PALINDROME
    ADD R0, R0, #0
    BRz Not_palidrome
    
    Is_palindrome
    LEA R0, result_string
    PUTS
    
    LEA R0, final_string
    PUTS
    BR EXIT_PALINDROME
    
    Not_palidrome
    LEA R0, result_string
    PUTS
    
    LEA R0, not_string
    PUTS
    
    LEA R0, final_string
    PUTS
EXIT_PALINDROME

; print the result to the screen
; * put your code here

; decide whether or not to print "not"
; * put your code here

HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ "a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  100

.END

;---------------------------------------------------------------------------------
; get_user_string - prompts to input string until newline is entered then stores the string
;
; parameter: R1 - address of input prompt
; parameter: R2 - address to store user string
;
; returns: nothing
;---------------------------------------------------------------------------------
.ORIG x3200
get_user_string
;Backup, R7 first
ADD R6, R6, #-1 ;R7
STR R7, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R1
STR R1, R6, #0
ADD R6, R6, #-1 ;R0
STR R0, R6, #0

;Prompt
ADD R0, R1, #0 ;print prompt
PUTS

;Algorithm
INPUT_LOOP
GETC
ADD R1, R0, #-10 ;check if newline
BRz END_INPUT_LOOP ;if newline, exit loop
STR R0, R2, #0 ;store input char at arr mem addr
OUT
ADD R2, R2, #1 ;increment arr mem addr
BR INPUT_LOOP
END_INPUT_LOOP

AND R0, R0, #0 ;store null term char at end
STR R0, R2, #0

LD R0, NEWLINE_3200 ;print newline
OUT

;Restore, R7 last
LDR R0, R6, #0 ;R0
ADD R6, R6, #1
LDR R1, R6, #0 ;R1
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R7, R6, #0 ;R7
ADD R6, R6, #1

RET
NEWLINE_3200 .FILL x0A
.END

;---------------------------------------------------------------------------------
; strlen - compute the length of a zero terminated string
;
; parameter: R1 - the address of a zero terminated string
;
; returns: R0 - The length of the string
;---------------------------------------------------------------------------------
.ORIG x3300
strlen
;Backup, R7 first
ADD R6, R6, #-1 ;R7
STR R7, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R1
STR R1, R6, #0

AND R0, R0, #0 ;clear R0

COUNT_LOOP
LDR R2, R1, #0 ;load char from R1 to R2
BRz END_COUNT_LOOP ;if null term char, exit loop
ADD R0, R0, #1 ;increment mem addr
ADD R1, R1, #1 ;increment 

BR COUNT_LOOP
END_COUNT_LOOP

;Restore, R7 first
LDR R1, R6, #0 ;R1
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R7, R6, #0 ;R7
ADD R6, R6, #1

RET
.END

;---------------------------------------------------------------------------------
; palindrome - (Describe what it does in 1 or 2 lines)
;
; parameter: R1 - starting address of the first letter in the word
; parameter: R2 - address of the last letter in the word
;
; returns: R0 is the boolean value that says if the string is a palidrome
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
ADD R6, R6, #-1 ;R7
STR R7, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R1
STR R1, R6, #0

 
    COMPARE
    LDR R3, R2, #0; putting last value in r3
    NOT R3, R3
    ADD R3, R3, #1 ; make the decimal of the char negative

    LDR R4, R1, #0 ; putting the first value in r4
    ADD R4, R4, R3 ; checking if values are the same (same if 0)
    BRz SAME ;same char
    BR DIFF ;diff char

    SAME
    and R0, R0, #0
    ADD R0, R0, #1
    
    ADD R1, R1, #1 ;increament to the next addr
    ADD R2, R2, #-1 ;decrement last addr

    AND R3, R3, #0 ;make r3 0
    
    ADD R3, R2, #0 ; copy decimal value of adress form r2 to r3
    NOT R3, R3
    ADD R3, R3, #1 ;twos complement r3
    
    ADD R4, R1, R3
    
    BRzp EXIT
    BR EXIT_2

    DIFF
    AND R0, R0, #0
    BR EXIT
    
    Exit_2
    jsr palindrome
    
    EXIT

; Resture all used registers, R7 last, using proper stack discipline
LDR R1, R6, #0 ;R1
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R7, R6, #0 ;R7
ADD R6, R6, #1

RET
.END