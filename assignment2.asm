;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS		    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

  GETC
  OUT
  ADD R1, R0, #0
  
  LEA R0, Newline
  PUTS
  
  GETC
  OUT
  ADD R2, R0, #0
  
  LEA R0, Newline
  PUTS

  ADD R0,R1,#0
  OUT
  
  LEA R0, Minus
  PUTS
  
  ADD R0,R2,#0
  OUT
  
  LEA R0, Equals
  PUTS

  ADD R3, R2, #0
  NOT R3, R3
  ADD R3, R3, 1
  
  ADD R4, R1, R3
  
  ;Here
  
  BRn if_neg
  
  ADD R4, R4, #14
  ADD R4, R4, #14
  ADD R4, R4, #14
  ADD R4, R4, #6
  ADD R0, R4, #0
  OUT
  
  LEA R0, Newline
  PUTS

  HALT

if_neg
  NOT R4, R4
  ADD R4, R4, #1;;Convert number from ASKII to Decimal
  ADD R4, R4, #14
  ADD R4, R4, #14
  ADD R4, R4, #14
  ADD R4, R4, #6
  
  LEA R0, Negative
  PUTS
  
  ADD R0, R4, #0
  OUT
  
  LEA R0, Newline
  PUTS

HALT				; Stop execution of program
;-----------
;Data
;------
; String to prompt user. Note: already includes terminating newline!
Equals  .STRINGZ    " = "
Minus  	.STRINGZ    " - "
Negative .STRINGZ "-"
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
Newline .FILL xD	; newline character - use with LD followed by OUT
	
.END

