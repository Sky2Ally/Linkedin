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
      MOV R10,#0x0A
      STR R10, .WriteChar
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
      STR R10, .WriteChar
      STR R1, .WriteString
      STR R2, .WriteString
      STR R5, .WriteUnsignedNum
      STR R4, .ReadString
      SUB R5, R5, #1
      BL comparecodes
      CMP R5, R3
      BNE guessinput
      CMP R5,R3         ;;comparing remaining guesses with 0
      BEQ gameover
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comparecodes: 
      PUSH {R1,R2,R3}
      PUSH {R4,R5,R6,R7}
      MOV R1, #querycode
      MOV R4, R0        ;; passing secretcode array as a perimeter
      MOV R5, R1        ;; passing querycode array as a perimeter
      MOV R2, #0
      MOV R3, #0
      MOV R12,#0
      MOV R11,#0
      MOV R9,#0x00
case1:                  ;;validates for position matches
      LDRB R6,[R4+R2]
      LDRB R7,[R5+R3]
      ADD R2,R2,#1
      ADD R3,R3,#1
      CMP R6,R9
      BEQ continue2
      CMP R6,R7
      BNE case1
      PUSH {LR}
      BL case1count
      POP {LR}
      CMP R6,R9
      BNE case1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
continue2:
      MOV R2, #0
case2:                  ;;validates for color matches
      MOV R5, R0        ;; passing secretcode array as a perimeter
      MOV R6, R1        ;; passing querycode array as a perimeter
      LDRB R7,[R5+R2]
      ADD R2,R2,#1
      MOV R3, #0
      CMP R7,R9
      BEQ continue3
loop3:
      LDRB R8, [R6+R3]
      ADD R3, R3,#1
      CMP R8,R9
      BEQ case2
      CMP R7,R8
      BNE loop3
      PUSH {LR}
      BL case2count
      POP {LR}
      B case2
continue3:
      POP {R4,R5,R6,R7}
      POP {R1,R2,R3} 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Stage 5b
      MOV R8, #str9
      MOV R9, #str10
      STR R8, .WriteString ;;printing the output for position matches
      STR R12, .WriteUnsignedNum
      STR R9, .WriteString ;;printing the output for color matches
      STR R11, .WriteUnsignedNum
      MOV R8, #4
      CMP R12, R8
      BEQ win
      RET
gameover:
      MOV R2, #4
      CMP R12, R2
      BEQ win
lose:
      STR R10, .WriteChar ;;newline char
      STR R1, .WriteString ;;codebreaker name
      MOV R3, #str12
      STR R3, .WriteString
      B over
win:
      STR R10, .WriteChar ;;newline char
      STR R1, .WriteString ;;codebreaker name
      MOV R3, #str11
      STR R3, .WriteString
over:
      MOV R1,#str13
      STR R1, .WriteString
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
str9: .ASCIZ "\nPosition Matches: "
str10: .ASCIZ "\nColor Matches: "
str11: .ASCIZ ",you WIN!"
str12: .ASCIZ ",you LOSE!"
str13: .ASCIZ "\nGAME OVER!!"
case1count:             ;; to count the instances of case1
      ADD R12,R12,#1
      RET
case2count:             ;; to count the instances of case2
      ADD R11,R11,#1
      RET
