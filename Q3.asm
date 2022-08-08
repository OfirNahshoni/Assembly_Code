# Question 3 - Project 1 Lab CS
# Purpose: Copy block of integers (address-0x10010000)
# to other array (address-0x100101000)

.data
A: .space 16 # Specify length of first array A: 4 integers (each is word)
B: .space 16 # Specify length of second array B: 4 integers (each is word)

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,4 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init
jal Random_IntArray_Init # Jump And Link to procedure

# Copy array A to array B
add $t0,$0,$0 # Index of for loop: i=0
addi $t1,$0,4 # $t1=4
mul $t2,$t1,$a3 # Multiply: $t2 = 4 * $a3. Specify upper limit of for loop
addi $t3,$0,0x10010100 # Address of first element in array B
#la $t3,f # Load Address: load first address 

loop_copy:
beq $t0,$t2,end_prog # If $t0=$t2 jump to label end_prog
lw $t4,A($t0) # Load Word: load from the address A+i into register $t4
add $t5,$t3,$t0 # Make the current address in B to copy to: $t5=$t3+i
sw $t4,0($t5) # Store Word: store $t4 (by value) into address 0+$t5 in memory
addi $t0,$t0,4 # i=i+4
j loop_copy

end_prog: # To stop the program
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
