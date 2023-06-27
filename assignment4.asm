;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Dhruv Thippasandra
; Email: dthip001@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

    .ORIG x3000			; Program begins here
    ;-------------
    ;Instructions
    ;-------------
    
    ;-------------------------------
    ;INSERT CODE STARTING FROM HERE 
    ;--------------------------------
    ;Example of how to Output Intro Message
    ;LD R0, introMessage  ;Output Intro Message
    ;PUTS
    
    ;Example of how to Output Error Message
    ;LD R0, errorMessage  ;Output Error Message
    ;PUTS
    
    Loop 		
    
 
    AND R5,R5,#0		
    AND R4,R4,#0	
    AND R3,R3,#0		;
    LD R6, COUNTER
    
    
   
    LD R0, introMessage
    PUTS
    
    
    Lol
        GETC		
        ADD R1,R0,#0
        LD R7,NEGNEWLINE
        ADD R1,R1,R7
        BRnp OUTPUT
    
    OUTPUT		
        OUT		
        BRnzp INPUT	
    INPUT	
    			
    
        ADD R1,R0,#0
        LD R7,NEG48		
        ADD R1,R1,R7	
        BRn OTHER_CHAR	
    
        ADD R1,R0,#0	
        LD R7,NEG57		
        ADD R1,R1,R7	
        BRp INVALID_CHAR	
    
        ADD R1,R6,#0	
        ADD R1,R1,#-6	
        BRz FIRST_CHAR
    		
        ADD R5,R5,R5
        ADD R2,R5,R5
        ADD R2,R2,R2	
        ADD R5,R5,R2	
    
    		
    
        LD R7,NEG48		
        ADD R0,R0,R7
        ADD R5,R5,R0	
        
        ADD R6,R6,#-1	
        BRp Lol	
        BRz CHECK_NEG	
    
    
    
    FIRST_CHAR
        LD R7,NEG48
        ADD R0,R0,R7	
        ADD R5,R0,R5
        ADD R6,R6,#-2
        BRnzp Lol		
    
    
    OTHER_CHAR
    		
        LD R7,PLUS		
        ADD R1,R0,#0
        ADD R1,R1,R7
        BRz PLUS_CHAR	
        
        LD R7,MINUS		
        ADD R1,R0,#0	
        ADD R1,R1,R7	
        BRz MINUS_CHAR
        
        LD R7,NEGNEWLINE	
        ADD R1,R0,#0
        ADD R1,R1,R7	
        BRz NEWLINE_INPUT	
    
    
    INVALID_CHAR
        ADD R1,R0,#0
        ADD R1,R1,#-10
        BRnp NEWLINE_ERROR
    
    NEWLINE_ERROR	
        LD R0,NEWLINE
        OUT
        BRnzp ERROR_MESSAGE	
    
    ERROR_MESSAGE
        LD R0,errorMessage	
        PUTS
        BRnzp Loop 	
    
    PLUS_CHAR
    		
        ADD R1,R6,#0	
        ADD R1,R1,#-6	
        BRnp INVALID_CHAR	
        
    		
        ADD R4,R4,#0	
        ADD R3,R3,#1	
        ADD R6,R6,#-1	
        BRnzp Lol
    
    MINUS_CHAR 
    			
        ADD R1,R6,#0
        ADD R1,R1,#-6
        BRnp INVALID_CHAR	
    	
        ADD R4,R4,#1	
        ADD R3,R3,#1
        ADD R6,R6,#-1	
        BRnzp Lol		
    
    NEWLINE_INPUT
    			
        ADD R1,R6,#0
        ADD R1,R1,#-6	
        BRz INVALID_CHAR
        
    			
        ADD R1,R6,#0
        ADD R1,R1,#-5
        BRnp CHECK_NEG	
    
    		
        ADD R1,R3,#0
        ADD R1,R1,#-1
        BRz INVALID_CHAR
    
        BRnp CHECK_NEG	
    
    TWO_COMPLEMENT
        NOT R5,R5
        ADD R5,R5,#1
        BRnzp END
    
    CHECK_NEG
        ADD R1,R4,#0	
        ADD R1,R1,#-1	
        BRz TWO_COMPLEMENT	
    
    END
        LD R0,NEWLINE 
        OUT
    
    AND R4, R4, x0
    ADD R4, R5, x0 
    
    AND R5, R5, #0
    
    HALT
;---------------	
;Data
;---------------
    DEC_0 .FILL #0
    DEC_10 .FILL #9
    COUNTER .FILL #6
    NEG48 .FILL #-48
    NEG57 .FILL #-57
    PLUS .FILL #-43
    MINUS .FILL #-45
    NEWLINE .FILL #10
    NEGNEWLINE .FILL #-10
    
    introMessage .FILL xB000
    errorMessage .FILL xB200
    .END
;------------
;Remote data
;------------
    .ORIG xB000
;---------------
;messages
;---------------
    intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
    .END
;---------------
;error_messages
;---------------
    .ORIG xB200	
    error_mes .STRINGZ	"ERROR INVALID INPUT\n"
    
;---------------
; END of PROGRAM
;---------------
    .END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
