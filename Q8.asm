# Question 8 - Project 1 Lab CS
# Purpose: Program that swap between 2 followed half words in each
# word, in array A

.data
A: .space 24 # Specify length of array A: 6 words array (6*4)

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

addi $t5,$0,4 # $t5=4
mul $t7,$a3,$t5 # Define number of words: $t7 = $a3 * 4
add $t6,$a2,$t7 # Address of last element (word) in array A
add $t0,$a2,$0 # Address of the first even half word in array A
addi $t1,$a2,2 # Address of the first odd half word in array A

# Code to swap Bytes whose their places are even and odd followed indexes
loop_main:
beq $t0,$t6,end_prog # If we are in the last byte in the array
lh $t2,0($t0) # Load Byte: load half word in even index
lh $t3,0($t1) # Load Byte: load half word in odd index
sh $t3,0($t0) # Store Byte: store odd half word in even index
sh $t2,0($t1) # Store Byte: store byte half word in odd index
addi $t0,$t0,4 # Promote current even to the next even
addi $t1,$t1,4 # Promote current odd to the next odd
j loop_main # Jump to label 'swap_even_odd_followed'

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
add $t3,$t0,$a2 # Current address of the integer we want to store in array A
sw $a0,0($t3) # Load Word: $a0 into the (start_address+i)
addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end_procedure:
jr $ra # Jump Return - return to main function