;=================================================
; Name:
; Email: 

; 
;=================================================
.ORIG x3000

LD R1, ARRAY_3000

LD R5, SUB_FILL_ARRAY_3200
JSRR R5

LD R5, SUB_CONVERT_ARRAY_3400
JSRR R5

LD R5, SUB_PRETTY_PRINT_ARRAY_3800
JSRR R5

HALT
ARRAY_3000 .FILL x4000
SUB_FILL_ARRAY_3200 .FILL x3200
SUB_CONVERT_ARRAY_3400 .FILL x3400
SUB_PRETTY_PRINT_ARRAY_3800 .FILL x3800
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200

AND R2, R2, #0 
LD R2, ARRAY_VAL 
AND R3, R3, #0 
LD R3, COUNTER_3200 ;R3 = loop counter, 10

DEC_LOOP
STR R2, R1, #0 

ADD R1, R1, #1 
ADD R2, R2, #1 
ADD R3, R3, #-1 
BRp DEC_LOOP 
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

AND R2, R2, #0 
AND R3, R3, #0 
LD R3, COUNTER_3400 ;R3 = loop counter, 10

CHAR_LOOP
LDR R2, R1, #0 
ADD R2, R2, #12
ADD R2, R2, #12
ADD R2, R2, #12
ADD R2, R2, #12
STR R2, R1, #0

ADD R1, R1, #1 
ADD R3, R3, #-1 

BRp CHAR_LOOP 
CHAR_END_LOOP

LD R1, ARRAY_3400
RET

HALT
ARRAY_3400 .FILL x4000
COUNTER_3400 .FILL #10
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3600

AND R2, R2, #0 
AND R3, R3, #0 
LD R3, COUNTER_3600 ;R3 = loop counter, 10

PRINT_LOOP
LDR R0, R1, #0 
OUT

ADD R1, R1, #1
ADD R3, R3, #-1
BRp PRINT_LOOP
END_PRINT_LOOP


RET
LD R1, ARRAY_3600

HALT
ARRAY_3600 .FILL x4000
COUNTER_3600 .FILL #10
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3800
LEA R0, EQUAL
PUTS
LD R5, PRINT_SUB
JSRR R5
LEA R0, EQUAL
PUTS

RET

HALT
PRINT_SUB .FILL x3600
EQUAL .STRINGZ "====="
.END

.ORIG x4000
array .BLKW #10
.END
