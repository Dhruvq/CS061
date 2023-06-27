;=================================================
; Name: 
; Email: 
; 
; Lab: lab 5, ex 1
; Lab section: 
; TA: 
;=================================================

.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE
LD R1, ARRAY ;array start address > R1

LD R5, SUB_GET_STRING_3200 ;subroutine address > R5
JSRR R5 ;jump to subroutine

LD R0, ARRAY
PUTS

HALT
ARRAY .FILL x4000

SUB_GET_STRING_3200 .FILL x3200
top_stack_addr .FILL xFE00 ; DO NOT MODIFY THIS LINE OF CODE
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

AND R5, R5, #0 

Lol
GETC
ADD R2, R0, #-10 
BRz Endlol 

STR R0, R1, #0 
OUT
ADD R1, R1, #1 

BR Lol

Endlol
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


.ORIG x4000
ARR .BLKW #100
HALT
.END