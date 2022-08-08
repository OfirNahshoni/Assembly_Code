# Question 13 - Project 1 Lab CS
# Purpose: Program that adds the value 0x1000 to all elements (words) in array A

.data
A: .space 24 # Array of 6 words (each word contains 4 bytes)

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

loop_main:
beq $t0,$t7,end_prog # If $t0==$t7 jump to label end_prog
add $t2,$a2,$t0 # Address current element (word) in array A
lw $a0,0($t2) # Load Word: load the current word, A[i], into $a0
addi $a0,$a0,0x1000 # Update value of current word - A[i]= A[i] + 0x1000
sw $a0,0($t2) # Store Word: store $a0 to address 0+$t2 in memory
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
add $t3,$t0,$a2 # Current address of the integer we want to store in array A
sw $a0,0($t3) # Load Word: store $a0 into the (start_address+i)
addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end_procedure:
jr $ra # Jump Return - return to main function