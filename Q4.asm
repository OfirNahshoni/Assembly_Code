# Question 4 - Project 1 Lab CS
# Purpose: Swap values between 2 arrays (A<->B)

.data
A: .space 20 # First array: space for 5 words
B: .space 20 # Second array: space for 5 words
C: .space 20 # Temporary array: space for 5 words

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,5 # Second argument for procedure: quantity_numbers_init

# Initializing 2 arrays: A,B
jal Random_IntArray_Init # Jump And Link to procedure

addi $a2,$0,0x10010020 # First argument for procedure: start_address
jal Random_IntArray_Init # Jump And Link to procedure

## First step: Copy array A to array C
add $t0,$0,$0 # Index of for loop: i=0
addi $t1,$0,4 # $t1=4
mul $t2,$t1,$a3 # Multiply: $t2 = 4 * $a3. Specify upper limit of for loop
addi $t3,$0,0x10010060 # Start address of array C
loop1:
beq $t0,$t2,step2 # If $t0=$t2 jump to label step2
addi $t6,$t0,0x10010000 # Address of current element in A
lw $t4,0($t6) # Load Word: load the value of 0+$t6 from memory into $t4
add $t5,$t3,$t0 # Make the current address in B to copy to: $t5=$t3+i
sw $t4,0($t5) # Store Word: store $t4 (by value) into address 0+$t5 in memory
addi $t0,$t0,4 # i=i+4
j loop1

## Second step: copy array B to array A
step2: 
add $t0,$0,$0 # Index of for loop: i=0
addi $t3,$0,0x10010000 # Start address of array A
loop2:
beq $t0,$t2,step3 # If $t0=$t2 jump to label step3
addi $t6,$t0,0x10010020 # Address of current element in B
lw $t4,0($t6) # Load Word: load the value of 0+$t6 from memory into $t4
add $t5,$t3,$t0 # Make the current address in B to copy to: $t5=$t3+i
sw $t4,0($t5) # Store Word: store $t4 (by value) into address 0+$t5 in memory
addi $t0,$t0,4 # i=i+4
j loop2

# Third step: Copy array C to array B
step3:
add $t0,$0,$0 # Index of for loop: i=0
add $t3,$0,0x10010020 # Address of first element of array in B
loop3:
beq $t0,$t2,end_prog # If $t0=$t2 jump to label end_prog
addi $t6,$t0,0x10010060 # Address of current element in C
lw $t4,0($t6) # Load Word: load from the address C+i into register $t4
add $t5,$t3,$t0 # Make the current address in B to copy to: $t5=$t3+i
sw $t4,0($t5) # Store Word: store $t4 (by value) into address 0+$t5 in memory
addi $t0,$t0,4 # i=i+4
j loop3

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
