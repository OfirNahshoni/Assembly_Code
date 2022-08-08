# Question 9 - Project 1 Lab CS
# Purpose: Program that calculates the sum of all words in given array
# Output value stored in $a1 and will be printed to Run I/O screen

.data 0x10010000
A: .space 24 # Space to 6 words (each word is 4 bytes)
next_line: .asciiz "\n"
out_msg: .asciiz "Sum of all the elements in A is: "

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

lw $a1,0($a2) # Load Word: load the first word 
addi $t0,$0,4 # Initialize index: point to second word
mul $t7,$a3,$t0 # $t7 = $a3*4 -> Set the upper limit of the loop (loop_main)

loop_main:
beq $t0,$t7,end_prog # If $t0==$t7 jump to label end_prog
add $t1,$a2,$t0 # Address of the current element (word) in the array
lw $t2,0($t1) # Load Word: load word from address 0+$t1 in memory (array A)
add $a1,$a1,$t2 # Addition of the current element to sum of previous elements
addi $t0,$t0,4 # i=i+4
j loop_main # Jump to label loop_main

end_prog:
la $a0,out_msg # Load $a0 to the address of the string out_msg
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$a1,$0 # Assign $a0 as the output value to print to screen
li $v0,1 # Syscall number 1: print integer
syscall
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