;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;------------------------------------------
;           BUILD TABLE HERE
;------------------------------------------
;REG VALUES     R0  R1      R2  R3  R4  R5  R6      R7
;Pre Loop       0   6       12  0   0   0   0       0
;Loop 1         0   5       12  12  0   0   0       0
;Loop 2         0   4       12  24  0   0   0       0
;Loop 3         0   3       12  36  0   0   0       0
;Loop 4         0   2       12  48  0   0   0       0
;Loop 5         0   1       12  60  0   0   0       0
;End_of_PRG     0   32767   12  72  0   0   12286   0



.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------

LD R1,DEC_6
LD R2,DEC_12
LD R3,DEC_0

DW
ADD R3,R3,R2
ADD R1,R1,#-1
BRp DW


HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

DEC_6 .FILL #6
DEC_12 .FILL #12
DEC_0 .FILL #0

;---------------	
;END of PROGRAM
;---------------	
.END


