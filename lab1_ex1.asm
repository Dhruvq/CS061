;=================================================
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 24
; TA: 
; 
;=================================================

.ORIG x3000
    LD R1, DEC_6
    LD R2, DEC_12
    LD R3, DEC_0


DO_WHILE
    ADD R3,R3,R2
    ADD R1,R1, #-1
    BRp DO_WHILE
HALT


DEC_0 .FILL     #0
DEC_6 .FILL     #6
DEC_12 .FILL    #12

.END