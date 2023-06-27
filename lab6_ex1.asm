;=================================================
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
;=================================================

.ORIG x3000
LD R3, BASE
LD R4, MAX
LD R5, TOS
LD R6, BACKUP_TOS

LD R0, TEST_ARR
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1
LDR R1, R0, #0
LD R2, SUB_STACK_PUSH_3200

JSRR R2
ADD R0, R0, #1

HALT
BASE .FILL xA000
MAX .FILL xA005
TOS .FILL xA000
BACKUP_TOS .FILL xFE00
SUB_STACK_PUSH_3200 .FILL x3200
TEST_ARR .FILL x4001
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH_3200
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R5 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3200
;BACKUP
ADD R6, R6, #-1 ;R0
STR R0, R6, #0
ADD R6, R6, #-1 ;R2
STR R2, R6, #0
ADD R6, R6, #-1 ;R7
STR R7, R6, #0

;ALGORITHM
ADD R2, R5, #0 ;move TOS to R2
NOT R2, R2 ;convert R2 TOS to negative
ADD R2, R2, #1

ADD R2, R4, R2 ;MAX - TOS

BRp NOT_OVERFLOW ;if +, TOS < MAX
BR OVERFLOW ;if -, TOS > MAX

NOT_OVERFLOW
ADD R5, R5, #1 ;increment TOS
STR R1, R5, #0 ;R1 val > TOS
BR PUSH_QUIT

OVERFLOW
LEA R0, OVERFLOW_ERR ;print error message
PUTS
LD R0, NEWLINE_1
OUT

PUSH_QUIT
LDR R7, R6, #0 
ADD R6, R6, #1
LDR R2, R6, #0 
ADD R6, R6, #1
LDR R0, R6, #0 
ADD R6, R6, #1

RET
NEWLINE_1 .FILL x0A
OVERFLOW_ERR .STRINGZ "Overflow error, quitting"
.END

.ORIG x4000
HALT
VAL_1 .FILL #5
VAL_2 .FILL #7
VAL_3 .FILL #4
VAL_4 .FILL #9
VAL_5 .FILL #2
VAL_6 .FILL #3
.END