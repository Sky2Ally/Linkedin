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
      LDR R5, .InputNum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      MOV R0, #str4
      STR R0, .WriteString
      STR R1, .WriteString
      MOV R2, #str5
      STR R2, .WriteString
      STR R3, .WriteString
      MOV R4, #str6
      STR R4, .WriteString
      STR R5, .WriteUnsignedNum
      HALT
str1: .ASCIZ "Enter Codemaker's Name: \n"
str2: .ASCIZ "Enter Codebreakers's Name:\n"
str3: .ASCIZ "Enter the number of guesses: \n"
str4: .ASCIZ "\nCodemaker is: "
str5: .ASCIZ "\nCodebreaker is: "
str6: .ASCIZ " \nMaximum Number of Guesses:"
codemaker: .BLOCK 128
codebreaker: .BLOCK 128
