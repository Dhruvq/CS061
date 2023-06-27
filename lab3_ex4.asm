;=================================================
; Name: 
; Email: 
; 
; Lab: lab 3, ex 4
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000
LD    R1,DATA_PTR

    LEA R0, PROMPT								
	PUTS

LOL
    GETC         
    OUT
    STR    R0,R1,#0    
    ADD    R1,R1,#1   
    ADD    R0,R0,#-10    
    BRnp    LOL        

    LD    R1,DATA_PTR    


LMAO
    LDR    R0,R1,#0     
    OUT                 
    ADD    R2,R0,#0     
    ADD    R1,R1,#1     
    ADD    R2,R2,#-10   
    BRnp    LMAO       

HALT

    
    PROMPT .STRINGZ "Enter characters: \n"
    NEWLINE    .FILL    x0A    
    DATA_PTR    .FILL    x4000   
    

.end

.ORIG x4000
	ARRAY_1 .BLKW #100
	
.END