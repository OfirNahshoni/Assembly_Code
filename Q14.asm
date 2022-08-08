# Question 14 - Project 1 Lab CS
# Purpose: Program that counts how many words equal to user input

.data
A: .space 24 # Array of 6 words (each word contains 4 bytes)
display_array: .asciiz "The numbers in A are:\n"
input_msg: .asciiz "Please enter number between [-50,50]:\n"
next_line: .asciiz "\n"
output_msg: .asciiz "Number of words equals to input is: "

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

# Display massage for the user to enter one word
la $a0,input_msg # Load Address: load address of $a0 to the string input_msg
li $v0,4 # Syscall number 4: print string
syscall

# Get word from user - input:
li $v0,5 # Syscall number 5: input integer from user
syscall

add $a0,$0,$0 # Counter: $a0=0
add $t0,$0,$0 # Index: i=0
addi $t1,$0,4 # $t1=4
mul $t7,$a3,$t1 # Upper limit of loop_main - $t7=6*4

loop_main:
beq $t0,$t7,end_prog # If $t0==$t7 jump to label end_prog
add $t2,$a2,$t0 # Address current element (word) in array A
lw $a1,0($t2) # Load Word: load the current word, A[i], into $a1
bne $a1,$v0,continue # If $a1 != $v0 jump to label continue. $a1 - current word , $v0 - input from user
addi $a0,$a0,1 # Promote the counter - count++
continue:
addi $t0,$t0,4 # i=i+4
j loop_main # Jump to label loop_main

end_prog:
add $t3,$0,$a0 # Save value of $a0 (counter) in temporary register
la $a0,output_msg # Load Address: load address of $a0 to the string out_msg
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$t3,$0 # Set $a0=$t3 (by value)
li $v0,1 # Syscall number 1: print integer
syscall
li $v0,10 # Syscall number 10: exit operation
syscall

# Procedure Random_IntArray_Init(start_address,quantity_numbers_init)
Random_IntArray_Init:
# Print massage relates to display all the elements in A:
la $a0,display_array # Load Address: load address of $a0 to the string display_array
li $v0,4 # Syscall number 4: print string
syscall

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