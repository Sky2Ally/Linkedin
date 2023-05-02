;;STAGE 1
      MOV R0, #str1
      STR R0, .WriteString
      MOV R1, #codemaker
      STR R1, .ReadString
      MOV R2, #str2
      STR R2, .WriteString
      MOV R3, #codebreaker
      STR R3, .ReadString
      MOV R4, #str3
      STR R4, .WriteString
      LDR R12, .InputNum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R0, #str4
      STR R0, .WriteString
      STR R1, .WriteString
      MOV R2, #str5
      STR R2, .WriteString
      STR R3, .WriteString
      MOV R4, #str6
      STR R4, .WriteString
      STR R12, .WriteUnsignedNum
;;read code - STAGE 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R0,#secretcode
      MOV R2, #str7
      MOV R11,#0x0A
      STR R11, .WriteChar
      STR R1, .WriteString
      STR R2, .WriteString
getcode: 
      MOV R1, R0        ;; passing code array as a perimeter
      STR R1, .ReadString
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R2, #0 
      MOV R1,R0
      MOV R3, #0x0      ;; register with null value
testchar:               ;; testing number of characters - 4
      LDRB R4, [R1+R2]
      ADD R2,R2,#1
      CMP R4 ,R3
      BNE testchar
      CMP R2, #5 
      BNE getcode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R2, #test
      MOV R3, #0
      MOV R5, #0x00
testASCII:              ;; testing valid characters (r,g,y,b,p,c)
      MOV R1, R0        ;; passing code array as a perimeter
      PUSH {R6,R7}
loop1:
      LDRB R6, [R1+R3]
      ADD R3,R3,#1
      MOV R4, #0
      CMP R6,R5
      BEQ continue
loop2:
      LDRB R7, [R2+R4]
      ADD R4, R4,#1
      CMP R7,R5
      BEQ getcode
      CMP R6,R7
      BNE loop2
      CMP R6,R7
      BEQ loop1
      CMP R7,R5
      BEQ getcode
      B loop1
      POP {R6,R7}
continue:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R1, #codebreaker
      MOV R2, #str8
      MOV R3,#0
      MOV R4, #querycode
      MOV R5, R12
guessinput:
      STR R11, .WriteChar
      STR R1, .WriteString
      STR R2, .WriteString
      STR R5, .WriteUnsignedNum
      STR R4, .ReadString
      SUB R5, R5, #1
      BL comparecodes
      CMP R5, R3
      BNE guessinput
      CMP R5,R3
      BEQ gameover
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comparecodes: 
      PUSH {R1,R2,R3}
      PUSH {R4,R5,R6,R7,R11}
      MOV R1, #querycode
      MOV R4, R0        ;; passing secretcode array as a perimeter
      MOV R5, R1        ;; passing querycode array as a perimeter
      MOV R2, #0
      MOV R3, #0
      MOV R12,#0        ;;For counting instances of CASE 1
      MOV R11,#0        ;;For counting instances of CASE 2
      MOV R9,#0x00      ;;null value
case1:
      LDRB R6,[R4+R2]
      LDRB R7,[R5+R3]
      ADD R2,R2,#1
      ADD R3,R3,#1
      CMP R6,R9         ;;comparing with null value
      BEQ continue2
      CMP R6,R7         ;;comparing codes
      BNE case1
      PUSH {LR}
      BL case1count
      POP {LR}
      CMP R6,R9
      BNE case1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
continue2:
      MOV R2, #0
case2:
      MOV R5, R0        ;; passing secretcode array as a perimeter
      MOV R6, R1        ;; passing querycode array as a perimeter
      LDRB R7,[R5+R2]   ;;taking a single character from secret code
      ADD R2,R2,#1
      MOV R3, #0
      CMP R7,R9         ;;comparing with null
      BEQ continue3
loop3:
      LDRB R8, [R6+R3]  ;;taking a single character from query code
      ADD R3, R3,#1
      CMP R8,R9         ;;comparing with null
      BEQ case2
      CMP R7,R8         ;;comparing codes
      BNE loop3
      PUSH {LR}
      BL case2count     ;;counting the instances of color match
      POP {LR}
      B case2
continue3:
      POP {R4,R5,R6,R7,R11}
      POP {R1,R2,R3}
      RET
gameover:
      HALT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
str1: .ASCIZ "Enter Codemaker's Name: \n"
str2: .ASCIZ "Enter Codebreakers's Name:\n"
str3: .ASCIZ "Enter the number of guesses: \n"
str4: .ASCIZ "\nCodemaker is: "
str5: .ASCIZ "\nCodebreaker is: "
str6: .ASCIZ " \nMaximum Number of Guesses:"
str7: .ASCIZ " Please enter a 4-character secret code: "
codemaker: .BLOCK 128
codebreaker: .BLOCK 128
secretcode: .BLOCK 128
querycode: .BLOCK 128
test: .ASCII "rgbypc"
str8: .ASCIZ ", This is your guess number: "
case1count:             ;; to count the cases in case1
      ADD R12,R12,#1
      RET
case2count:
      ADD R11,R11,#1
      RET
