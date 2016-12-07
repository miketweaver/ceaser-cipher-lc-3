.ORIG x3000


ENCRYPTTYPE   .STRINGZ  "Would you like to encode? or decode? E or D?\n"
ENCRYPTmsg    .STRINGZ  "Nice. made it te ENCRYPT.\n"
DECRYPTmsg    .STRINGZ  "You are the decrypting master.\n"
  LEA R0, START   ;load the address of the label START into R0
  PUTS            ;output the string at START

  BEGIN
  LEA R0, ENCRYPTTYPE   ;load the address of the label ENCRYPTTYPE into R0
  PUTS                ;output the string at START

; Figures out if the user wanted to encrypt or decrypt a message.
; If 'E' then encrypt. If 'D' then decrypt.
; Another option (not implemented) was to branch to decrypt if not encrypt.

checkChar:
  in              ; Read in a single character to R0.
  add r3, r0, #0  ; Copy R0 to R3.
  lea r6, neg69   ; Load address of neg69 into R6.
  ldr r6, r6, #0  ; Load contents of neg69 into R6 (R6 now holds -69).
  add r0, r3, r6  ; Add -69 to the value in R3, to check if it's 'E'.
  BRz encrypt     ; If zero, branch to encrypt.
                  ; Else check if it's 'D'.
  lea r6, neg68   ; Load address of neg68 into R6.
  ldr r6, r6, #0  ; Load contents of neg68 into R6 (R6 now holds -68).
  add r0, r3, r6  ; Add -68 to the value in R3, to check if it's 'D'.
  BRz decrypt     ; If zero, branch to decrypt.

  LEA R0, INVALID   ;load the address of the label INVALID into R0
  PUTS              ;output the string at START

  BR checkChar
neg69:  .FILL #-69  ; Constant for the inverse of 'E'.
neg68:  .FILL #-68  ; Constant for the inverse of' D'.
decrypt:
  LEA R0, DECRYPTmsg    ;load the address of the label START into R0
  PUTS              ;output the string at START
  BR CeaserLoop

encrypt:
  LEA R0, ENCRYPTmsg    ;load the address of the label START into R0
  PUTS              ;output the string at START
  BR CeaserLoop

;;;; CEASER LOOP ;;;;
enterMessage:       .STRINGZ "Please enter your message: "

CeaserLoop:
AND R1, R1, #0    ; clear r1 with 0;

LEA R0, enterMessage   ;load the address of the label START into R0
PUTS            ;output the string at START

 ;Get Character and save in R3
 ;GETC            ; input character -> r0
loop:
BR Letters:

Letters:
  LD r2, capitalLetterBottom ; fill register r1 with letter A
  LD r6, capitalLetterTop ; fill register r2 with letter Z
  GETC ; loads in letter R0 and outputs it.
  NOT r3, r0 ; Gives one compliment of r0 stores in r3
  ADD r3, r3, #1 ; ADDS one to make the number negitive
  ADD r2, r3, r2 ; adds value of r3 (negitive r0) to r2 and stores in r2
  BRn CapitalTop ; br if value of letter greater than A
  BRz SuccessInputCapital ; br if value is equal to A
  BR FailedInput ; If it was a value less than A output Failed message 
  
CapitalTop:
    ADD r6, r3, r6 ; adds negitive value of r3 (not r0) to r2 and stores in r6
    BRzp SuccessInputCapital ; the letter is Z


LowerCaseLetter:
  LD r2, lowerCaseBottom ; fill register r1 with Letter a
  LD r6, lowerCaseTop ; fill register r2 with Letter z
  ADD r2, r3, r2 ; adds value of r3 (negitive r0) to r1 and stores in r1
  BRn lowerTop ; br if value of letter greater than A
  BRz SuccessInputLower ; br if value is equal to A
  BR FailedInput ; If it was a value less than A output Failed message

lowerTop:
ADD r6, r3, r6 ; adds negitive value of r3 (not r0) to r6 and stores in r6
BRzp SuccessInputLower ; the letter is Z
BR FailedInput

FailedInput:
  BR endLoop ;

SuccessInputLower:
  LEA r6 caseBottom ; loads r6 with address of caseBottom
  LD r2 lowerCaseBottom ; loads r2 with capitalLetterBottom
  STR r2, r6, #0 ; stores value of r2 into memory location of r6
  LEA r6 caseTop
  LD r2 lowerCaseTop 
  STR r2, r6, #0
  BR SuccessInput ; branches to manage input

SuccessInputCapital:
  LEA r6 caseBottom ; loads r6 with address of caseBottom
  LD r2 capitalLetterBottom ; loads r2 with capitalLetterBottom
  STR r2, r6, #0 ; stores value of r2 into memory location of r6
  LEA r6 caseTop
  LD r2 capitalLetterTop 
  STR r2, r6, #0
  BR SuccessInput ; branches to manage input

START       .STRINGZ  "Welcome to the Ceaser Cipher Program\n"
INVALID     .STRINGZ  "You have input an invalid answer.\n"
caseBottom:    .FILL x0061 ; Letter a
caseTop:     .FILL x007A ; Letter z
capitalLetterBottom:  .FILL x0041 ; Letter A
capitalLetterTop:   .FILL x005A ; Letter Z
lowerCaseBottom:    .FILL x0061 ; Letter a
lowerCaseTop:     .FILL x007A ; Letter z
failuremsg:       .STRINGZ "Your input was not a valid letter."       
stringLoop:   .FILL 20 ; Sets the maximum character fill limit to be 20 characters
string:        .blkw 21 ; Saves a memoery size of 20.
key:          .fill #13 ; Temproray key 
numLoop:      .FILL #20  ;
LD R5, numLoop ;

AND R6, R6, #0    ; clear r1 with 0;
AND R3, R3, #0    ; clear r1 with 0;
AND R0, R0, #0    ; clear r1 with 0;
AND R2, R2, #0    ; clear r1 with 0;
neg10:  .fill #-10  ; Constant for the inverse of '\n'.

SuccessInput:
  add r3, r0, #0  ; Copy R0 to R3. (Save input Charater to R3)

 ;loop counter
  ADD R5, R5, #-1 ;
  BRz endLoop ;

 ;print out character
  ADD r0, r3, #0  ; load charater -> r0
  out               ; r0 -> console

;begin keying
  ; load z into r0
  lea r6, caseTop  ; Load address of key into R6.
  ldr r6, r6, #0        ; Load contents of key into R6.
  ; make r6 negative: -("z")
  NOT R6, R6            ; Gives one compliment of the "z" stores in r6
  ADD r6, r6, #1        ; ADDS one to make the number negitive

  ; load key into r4.
  lea r4, key           ; Load address of key into R4.
  ldr r4, r4, #0        ; Load contents of key into R4.

  ; check if key is bigger than character bounds. 
  ADD r0, r3, r4 ; add charater and key.
  ADD r0, r0, r6 ; Add Key+Character to r0 (top "z")
  BRp Overflow

save:
  ADD r3, r3, r4 ;    add character and key and save in r0
  LEA R0, string ; saves the address of the storage memory block
  ADD R0, R0, R1 ;
  STR R3, R0, #0       ; r3 -> ( memory address stored in r0 + r1 )
  ADD R1, R1, #1       ; increments the memory pointer so that it
                       ; always points at the next available block
  BR loop

Overflow:
  ; make r3 (character) negative
  NOT r0, r3; Gives one compliment of the "z" stores in r0
  ADD r0, r0, #1 ; ADDS one to make the number negitive
  ; load lowerCaseTop to r6p
  lea r6, caseTop  ; Load address of key into R6.
  ldr r6, r6, #0        ; Load contents of key into R6.
  ; k = k - (lowerCaseTop+1-C)
  ADD r6, r6, #1 ; lowerCaseTop +1
  ADD r0, r6, r0 ; r2 - C
  ;make r0 negative
  NOT r0, r0; Gives one compliment of the "z" stores in r0
  ADD r0, r0, #1 ; ADDS one to make the number negitive
  ; k + r0
  ADD r4, r4, r0 ; Add the Key + r0 and save in r4

  ; c = bottom.
  ; load lowerCaseBottom to r6p
  lea r6, caseBottom  ; Load address of key into R3.
  ldr r3, r6, #0        ; Load contents of key into R3.

  BR save ;

endLoop:
  LEA R0, endmsg   ;load the address of the label START into R0
  PUTS            ;output the string at START
  LEA R0, string   ;load the address of the label string into R0
  PUTS                ;output the string at string
  LEA R0, byemsg   ;load the address of the label START into R0
  PUTS            ;output the string at START
  HALT

close:
  HALT

endmsg:       .STRINGZ "\nYour encoded/decoded messages is: "
byemsg:       .STRINGZ "\nThank you. Have a nice day."


.END