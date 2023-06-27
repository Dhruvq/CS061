;=================================================
; Name: Thomas Chang
; Email: tchan226@ucr.edu
; 
; Lab: lab 4, ex 3
; Lab section: 021
; TA: Westin Montano & Nicholas Santini
; 
;=================================================
.ORIG x3000

LD R1, ARRAY_3000

LD R5, SUB_FILL_ARRAY_3200
JSRR R5

LD R5, SUB_CONVERT_ARRAY_3400
JSRR R5

HALT
ARRAY_3000 .FILL x4000
SUB_FILL_ARRAY_3200 .FILL x3200
SUB_CONVERT_ARRAY_3400 .FILL x3400
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200

AND R2, R2, #0 ;clear R2
LD R2, ARRAY_VAL ;R2 = array val
AND R3, R3, #0 ;clear R3
LD R3, COUNTER_3200 ;R3 = loop counter, 10

DEC_LOOP
STR R2, R1, #0 ;store array val in curr mem address

ADD R1, R1, #1 ;increment mem address
ADD R2, R2, #1 ;increment array val
ADD R3, R3, #-1 ;decrement loop count
BRp DEC_LOOP ;loop if positive
END_DEC_LOOP

LD R1, ARRAY_3200
RET

HALT
ARRAY_3200 .FILL x4000
ARRAY_VAL .FILL #0
COUNTER_3200 .FILL #10
.END

;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3400

AND R2, R2, #0 ;clear R2
AND R3, R3, #0 ;clear R3
LD R3, COUNTER_3400 ;R3 = loop counter, 10

CHAR_LOOP
LDR R2, R1, #0 ;curr mem address to R2
ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #3 ;convert dec to char
STR R2, R1, #0

ADD R1, R1, #1 ;increment mem address
ADD R3, R3, #-1 ;decrement loop count

BRp CHAR_LOOP ;loop if positive
CHAR_END_LOOP

LD R1, ARRAY_3400
RET

HALT
ARRAY_3400 .FILL x4000
COUNTER_3400 .FILL #10
.END