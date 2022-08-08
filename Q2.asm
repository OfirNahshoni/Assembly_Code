# Question 2 - Project 1 Lab CS
# Purpose: make the program in Q1 into procedure
# Given Arguments:
# Beginning address: start_address
# Number of integers to init in array: quantity_numbers_init
# Main function will manage the space in memory

.data 0x10010060
A: .space 16 # Specify length of array A: 4 words array (4*4)

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010068 # First argument for procedure: start_address
addi $a3,$0,2 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init
jal Random_IntArray_Init # Jump And Link to procedure

# To stop the program
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
add $t3,$t0,$a2 # Current address of the integer we want to store in array A
sw $a0,0($t3) # Load Word: $a0 into the (start_address+i)
addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end_procedure:
jr $ra # Jump Return - return to main function