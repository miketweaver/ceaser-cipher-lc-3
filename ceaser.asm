.ORIG x3000

	LEA R0, START  	;load the address of the label START into R0
	PUTS            ;output the string at START

	BEGIN
	LEA R0, ENCRYPTTYPE  	;load the address of the label ENCRYPTTYPE into R0
	PUTS            		;output the string at START

; Figures out if the user wanted to encrypt or decrypt a message.
; If 'E' then encrypt. If 'D' then decrypt.
; Another option (not implemented) was to branch to decrypt if not encrypt.
checkChar:
  in                ; Read in a single character to R0.
  add r3, r0, #0	; Copy R0 to R3.
  lea r6, neg69   ; Load address of neg69 into R6.
  ldr r6, r6, #0  ; Load contents of neg69 into R6 (R6 now holds -69).
  add r0, r3, r6  ; Add -69 to the value in R3, to check if it's 'E'.
  BRz encrypt     ; If zero, branch to encrypt.
                  ; Else check if it's 'D'.
  lea r6, neg68   ; Load address of neg68 into R6.
  ldr r6, r6, #0  ; Load contents of neg68 into R6 (R6 now holds -68).
  add r0, r3, r6  ; Add -68 to the value in R3, to check if it's 'D'.
  BRz decrypt     ; If zero, branch to decrypt.

  LEA R0, INVALID  	;load the address of the label INVALID into R0
  PUTS            	;output the string at START

  BR checkChar

decrypt:
	LEA R0, DECRYPTmsg  	;load the address of the label START into R0
	PUTS            	;output the string at START
	BR close

encrypt:
	LEA R0, ENCRYPTmsg  	;load the address of the label START into R0
	PUTS            	;output the string at START
	BR close

readString:  
    LEA r2, stringSize  ; Saves the address of stringSize into r2 
    LD r1, stringLoop ; Loads the number 20 in register 1
  loop:
      in ; Gets and prints out each characer
      STR r0, r2, #0 ;Saves the value of the input(r0) in memory.
      ADD r2, r2, #1 ; adds one to the memory address in r2
      ADD r1, r1, #-1 ; counts down the loop
  BRp loop ; Breaks the loop if zero
    LEA r0, stringSize ; saves the string locaiton in r0
    PUTS ; prints out the characters
BR close 

close:
	HALT

START 			.STRINGZ	"Welcome to the Ceaser Cipher Program\n"
ENCRYPTTYPE 	.STRINGZ	"Would you like to encode? or decode? E or D?\n"
KEY				.STRINGZ	"Please Enter the Key. 1 to 26: \n"
ENCRYPTmsg 		.STRINGZ	"Nice. made it te ENCRYPT.\n"
DECRYPTmsg 		.STRINGZ	"You are the decrypting master.\n"
INVALID			.STRINGZ	"You have input an invalid answer.\n"

neg69:  .fill	#-69  ; Constant for the inverse of 'E'.
neg68:  .fill	#-68  ; Constant for the inverse of' D'.

array:  .blkw	20    ; Array of size 20.

; **** readString *****
stringLoop:   .FILL 20 ; Sets the maximum character fill limit to be 20 characters
stringSize:   .blkw 20 ; Saves a memoery size of 20.

.END