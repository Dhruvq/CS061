;=================================================
; Name: 
; Email: 
; 
; Lab: lab 5, ex 2
; Lab section: 
; TA: 
; 
;=================================================
.ORIG x3000
; Initialize the stack. Don't worry about what that means for now.
LD r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE
LD R1, ARRAY ;array start address > R1

LD R2, SUB_GET_STRING_3200
JSRR R2

LD R2, SUB_IS_PALINDROME_3400 ;subroutine
JSRR R2


    LD R0, NEWLINE
    OUT
    
    LEA R0, THE_STRING
    PUTS
    LD R0, ARRAY
    PUTS
    ADD R0, R4, #0
    BRp PALINDROME
    BRz NOTPALINDROME
    
    PALINDROME
    LEA R0, IS_PALINDROME
    PUTS
    BR EXIT_1
    
    NOTPALINDROME
    LEA R0, NOT_PALINDROME
    PUTS
    
    EXIT_1

HALT
    ARRAY .FILL x4000
    SUB_GET_STRING_3200 .FILL x3200
    SUB_IS_PALINDROME_3400 .FILL x3400
    top_stack_addr .FILL xFE00 ; DO NOT MODIFY THIS LINE OF CODE
    NEWLINE .FILL x0A
    THE_STRING              .STRINGZ "The string \""
    NOT_PALINDROME          .STRINGZ "\" IS NOT a palindrome \n"
    IS_PALINDROME           .STRINGZ "\" IS a palindrome \n"
.END

;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING_3200
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.ORIG x3200
;backup
ADD R6, R6, #-1 ;R0
STR R0, R6, #0
ADD R6, R6, #-1 ;R1
STR R1, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R7
STR R7, R6, #0

    ;algorithm
    AND R5, R5, #0 ;clear R5
    
    INPUT_LOOP
    
    GETC
    ADD R2, R0, #-10
    BRz END_INPUT_LOOP 
    
    STR R0, R1, #0 
    OUT
    ADD R1, R1, #1 
    ADD R5, R5, #1 
    
    BR INPUT_LOOP
    END_INPUT_LOOP
    
    LD R0, NULL_CHAR 
    STR R0, R1, #0 

;restore
LDR R7, R6, #0 ;R7
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R1, R6, #0 ;R1
ADD R6, R6, #1
LDR R0, R6, #0 ;R0
ADD R6, R6, #1

RET
NULL_CHAR .FILL x0000
.END

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME_3400
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.ORIG x3400

;backup
ADD R6, R6, #-1 ;R0
STR R0, R6, #0
ADD R6, R6, #-1 ;R1
STR R1, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R7
STR R7, R6, #0
    
    
    ADD R2, R1, R5
    ADD R2, R2, #-1 
    LD R4, ONE 
    
    COMPARE
    LDR R3, R2, #0 
    NOT R3, R3
    ADD R3, R3, #1 
    
    LDR R0, R1, #0 
    ADD R0, R0, R3 
    BRz SAME 
    BR DIFF 
    
    SAME
    ADD R1, R1, #1 
    ADD R2, R2, #-1 
    
    AND R3, R3, #0 
    ADD R3, R2, #0 
    NOT R3, R3
    ADD R3, R3, #1 
    ADD R0, R1, R3 
    BRz EXIT_2 
    BRp EXIT_2 
    BR COMPARE
    
    DIFF
    LD R4, ZERO
    BR EXIT_2
    
    EXIT_2

;restore
LDR R7, R6, #0 ;R7
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R1, R6, #0 ;R1
ADD R6, R6, #1
LDR R0, R6, #0 ;R0
ADD R6, R6, #1

RET
ONE .FILL #1
ZERO .FILL #0
.END

.ORIG x4000
ARR .BLKW #100
HALT
.END    