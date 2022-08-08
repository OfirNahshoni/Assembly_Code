# Question 12 - Project 1 Lab CS
# Purpose: Program that multiply by 2 all elements (words) in array A

.data
A: .space 24 # Array of 6 words (each word contains 4 bytes)
next_line: .asciiz "\n"
out_msg: .asciiz "All words multiply by 2:\n"

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

add $t0,$0,$0 # Index: i=0
addi $t1,$0,4 # $t1=4
mul $t7,$a3,$t1 # Upper limit of loop_main - $t7=6*4

# Print output string to Run I/O screen
la $a0,out_msg # Load Address: load $a0 to address of the string out_msg
li $v0,4 # Syscall number 4: print string
syscall

loop_main:
beq $t0,$t7,end_prog # If $t0==$t7 jump to label end_prog
add $t2,$a2,$t0 # Address current element (word) in array A
lw $a0,0($t2) # Load Word: load the current word, A[i], into $a0
sll $a0,$a0,1 # Shift Left Logical: shift 1 logical left current word, A[i] - A[i] = A[i] * 2
sw $a0,0($t2) # Store Word: store $a0 to address 0+$t2 in memory
# Print updated values:
li $v0,1 # Syscall number 1: print integer
syscall
add $t3,$0,$a0 # Save value of $a0 in temporary register -> $t3=$a0
la $a0,next_line # Load Address: load address of $a0 to the string next_line
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$t3,$0 # Return to original value of $a0 -> $a0=$t3
addi $t0,$t0,4 # i=i+4
j loop_main # Jump to label loop_main

end_prog:
li $v0,10 # Syscall number 10: exit operation
syscall

# Procedure Random_IntArray_Init(start_address,quantity_numbers_init)
Random_IntArray_Init:
add $t0,$0,$0 # i=0
addi $t1,$0,4 # $t1=4
mul $t2,$a3,$t1 # Upper limit of initialization: $t2 = $a3 * 4

loop:
beq $t0,$t2,end_procedure # If $t0=$t2 jump to label end_procedure
# Random 1 number
addi $a1,$0,100 # Upper limit integer is 100
li $v0,42 # Syscall number 42: random integers
syscall
subi $a0,$a0,50 # Move the range from [0,100] to range [-50,50]
add $t4,$a0,$0 # Temporary register to not loose the value of $a0
# Print the numbers in other lines
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load $a0 to the address of the string next_line
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$t4,$0
add $t3,$t0,$a2 # Current address of the integer we want to store in array A
sw $a0,0($t3) # Load Word: store $a0 into the (start_address+i)
addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end_procedure:
jr $ra # Jump Return - return to main function