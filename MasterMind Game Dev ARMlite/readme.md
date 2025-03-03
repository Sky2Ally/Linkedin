# Mastermind Game in Armlite Assembly

## Description
This project is an implementation of the **Mastermind** game using the **Armlite Assembly Programming Language**. The game involves two players:
- **Codemaker**: Sets a secret code.
- **Codebreaker**: Attempts to guess the secret code within a limited number of tries.

The game processes input from both players, validates the guesses, and determines the winner based on correct character matches and their positions.

## Key Features
### **Stage 1: Initialization**
- The game prompts users to enter the names of the **Codemaker** and **Codebreaker**.
- It stores the number of guesses allowed for the **Codebreaker** in a register.
- Displays entered names and the number of guesses.

### **Stage 2: Code Validation**
- The **Codemaker** enters a **4-character secret code**.
- The game verifies:
  - The length of the code (must be exactly 4 characters).
  - The characters used (must be one of: `r, g, b, y, p, c`).
- If invalid, the user must re-enter the code.

### **Stage 3: Secret Code Storage**
- Stores the **Codemaker’s secret code** in a label (`secretcode`).
- Ensures the code is displayed only after validation.

### **Stage 4: Codebreaking Attempts**
- The **Codebreaker** is prompted to enter their guesses.
- Each guess is stored in a label (`querycode`).
- The number of remaining guesses is displayed after each attempt.

### **Stage 5A: Code Comparison**
- **Case 1: Position Match**
  - Compares each character of `querycode` with `secretcode` at the same index.
  - If they match, a counter (`R12`) is incremented.
- **Case 2: Color Match (Wrong Position)**
  - Checks if a guessed character is in the secret code but in a different position.
  - If matched, a counter (`R11`) is incremented.

### **Stage 5B: Determining the Winner**
- If all **4 characters match exactly** (Case 1 count = 4), the **Codebreaker wins**.
- Otherwise, the game loops until all guesses are exhausted.
- If no exact match is found, the **Codemaker wins**.

## Assumptions
- Players always enter valid inputs after validation.
- The game logic follows the standard **Mastermind** rules with a **4-character code** constraint.

## Author
**Bhuvan Virmani**  
