;=================================================
; Name: 
; Email: 
; 
; Lab: lab 8, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
LEA R0, PROMPT ;print prompt
PUTS
GETC ;get input
OUT ;echo

ADD R1, R0, #0 ;move input to R1

LD R0, NEWLINE ;print newline
OUT

LD R2, PARITY_CHECK_3600 ;call subroutine
JSRR R2

LEA R0, OUTPUT ;print output
PUTS

ADD R0, R3, #0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12 ;add 48 to r0 before outputing to make it decimal
OUT

HALT
top_stack_addr .fill xFE00
PARITY_CHECK_3600 .FILL x3600
NEWLINE .FILL x0A
PROMPT .STRINGZ "Input a character : "
OUTPUT .STRINGZ "Number of 1’s is: "
.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: Character, R1
; Postcondition: Number of 1's in input's binary printed to console
; Return Value (R3): Number of 1's in input's binary
;=================================================
.orig x3600
; Backup registers
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R4
STR R4, R6, #0
ADD R6, R6, #-1 ;R5
STR R5, R6, #0
ADD R6, R6, #-1 ;R7
STR R7, R6, #0

; Code
ADD R2, R1, #0 ;move input to R2
AND R3, R3, #0 ;clear R3
LD R4, Loop_Counter
LD R5, Bit_Mask

LOOP
AND R0, R2, R5 ;bit mask R2 with r5 which is x8000, store result in R0

BRp NEGATIVE_MSB ;1 MSB
BRz SKIP ;0 MSB

NEGATIVE_MSB
ADD R3, R3, #1 ;increment 1 counter

SKIP
ADD R2, R2, R2 ;left-shift
ADD R4, R4, #-1 ;decrement loop counter; will occur 16 times becuase there are 16 bits that store the input
BRp LOOP
END_LOOP

; Restore registers
LDR R7, R6, #0 ;R7
ADD R6, R6, #1
LDR R5, R6, #0 ;R5
ADD R6, R6, #1
LDR R4, R6, #0 ;R4
ADD R6, R6, #1
LDR R2, R6, #0 ;R2
ADD R6, R6, #1

RET
Loop_Counter .FILL #16
Bit_Mask .FILL x8000
.end