;=================================================
; Name: 
; Email: 
; 
; Lab: lab 4, ex 1
; Lab section: 
; TA: 
; 
;=================================================
.ORIG x3000

 LD R1,CONST
 
 LD R5,SUB_FILL_ARRAY_3200
 
 JSRR R5
 
 HALT
 
 CONST .FILL x3005
 ARRAY_1 .BLKW #10
 SUB_FILL_ARRAY_3200 .FILL x3200
 
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
 .ORIG x3200
 LD R2,NINE
 ADD R3,R1,#0
 
 Rep
 STR R2, R3, #9
 ADD R3, R3, #-1
 ADD R2, R2, #-1
 BRp Rep
 
 RET
 NINE .FILL #9
 .END