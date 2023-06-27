;=================================================
; Name: 
; Email: 
; 
; Lab: lab 3, ex 3
; Lab section: 
; TA: 
; 
;=================================================


.ORIG x3000

	; Instructions
	LD R2, ARRAY_PTR	
	LD R4, ARRAY_PTR
	LD R3, DEC_10								
	
	LEA R0, PROMPT								
	PUTS										
	
	DO_WHILE
		GETC									
		OUT
		STR R0, R2, #0							
		ADD R2, R2, #1							
		ADD R3, R3, #-1							
		BRp DO_WHILE	
	
	LD R3, DEC_10
	
	LD R0,NEWLINE
	OUT
	
	DO_WHILE_2
	    LDR R0,R4,#0
	    OUT
	    ADD R4,R4,#1
	    ADD R3, R3, #-1							
		BRp DO_WHILE_2
	    
		
	HALT									
	
	PROMPT .STRINGZ "Enter 10 characters: \n"
	DEC_10 .FILL #10
	ARRAY_PTR .FILL x3500
	NEWLINE .FILL x0A

.END
	
	.ORIG x3500
	ARRAY_1 .BLKW #10
	
.END