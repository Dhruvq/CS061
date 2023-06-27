;=================================================
; Name: Thomas Chang
; Email: tchan226@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 021
; TA: Westin Montano & Nicholas Santini
; 
;=================================================

.orig x3000
LD R6, top_stack_addr
LD R5, digit_top_stack_addr

; Test harness
LD R2, LOAD_FILL_VALUE_3200
JSRR R2
LD R2, OUTPUT_AS_DECIMAL_3400
JSRR R2

HALT
; Test harness local data
top_stack_addr .fill xFE00
digit_top_stack_addr .fill x3800
LOAD_FILL_VALUE_3200 .FILL x3200
OUTPUT_AS_DECIMAL_3400 .FILL x3400
.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: Hard-coded value in memory label VALUE
; Postcondition: VALUE stored in R1
; Return Value: VALUE in R1
;=================================================
.orig x3200
; Backup registers
ADD R6, R6, #-1 ;R7
STR R7, R6, #0

; Code
LD R1, VALUE ;load R1 with VALUE

; Restore registers
LDR R7, R6, #0 ;R7
ADD R6, R6, #1

RET
VALUE .FILL #1208
.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: R1
; Postcondition: R1 printed to console
; Return Value: None
;=================================================
.orig x3400
; Backup registers
ADD R6, R6, #-1 ;R0
STR R0, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R3
STR R3, R6, #0
ADD R6, R6, #-1 ;R4
STR R4, R6, #0
ADD R6, R6, #-1 ;R7
STR R7, R6, #0

; Code
AND R4, R4, #0 ;clear R4
ADD R3, R1, #0 ;copy reg val to R3

BRn NEGATIVE
BR POSITIVE

NEGATIVE
LD R0, NEGATIVE_SIGN
OUT
NOT R3, R3
ADD R3, R3, #1

POSITIVE
LOOP
    ADD R3, R3, #-10 ;subtract reg val copy by 10
BRnz STACK
    ADD R4, R4, #1 ;increment 10 counter
BR LOOP

STACK
    ADD R3, R3, #10
    
    ADD R5, R5, #-1 ;push isolated digit to stack
    STR R3, R5, #0
    
    ADD R2, R4, #0
    BRz EXIT ;last digit pushed
    
    ADD R3, R4, #0
    AND R4, R4, #0
    BR LOOP
EXIT

PRINT_LOOP
LDR R0, R5, #0
ADD R5, R5, #1 ;pop top of stack to R0

ADD R2, R0, #-10 ;if 10
BRz TEN_CASE

ADD R0, R0, #15 ;convert decimal to printable ascii
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT ;print

BR SKIP
TEN_CASE
LEA R0, TEN
PUTS

SKIP
LD R0, TOS_CHECK
NOT R0, R0
ADD R0, R0, #1
ADD R2, R5, R0
BRz END_PRINT_LOOP
BR PRINT_LOOP
END_PRINT_LOOP

; Restore registers
LDR R7, R6, #0 ;R7
ADD R6, R6, #1
LDR R4, R6, #0 ;R4
ADD R6, R6, #1
LDR R3, R6, #0 ;R3
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1
LDR R0, R6, #0 ;R0
ADD R6, R6, #1

RET
TEN .STRINGZ "10"
NEGATIVE_SIGN .FILL #45
TOS_CHECK .FILL x3800
.end