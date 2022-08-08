# Question 10 - Project 1 Lab CS
# Purpose: Assign the sum of the current element and the next into the current
# A[i] = A[i] + A[i+1] -> A[i]-current byte , A[i+1]-next byte

.data
A: .space 24 # Space to 6 words (each word is 4 bytes)

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

addi $t2,$0,4 # $t2=4
add $t0,$a2,$0 # Address of first byte of first word in array A
addi $t1,$a2,1 # Address of second byte of first word in array A 
mul $t7,$a3,$t2 # $t7 = $a3*4 -> Set the upper limit of the loop (loop_main)
add $t6,$a2,$t7 # Upper limit: first address outside the array A

loop_main:
# If $t1==$t6 (if $t1 equals to the first address outside A) jump to label end_prog
beq $t0,$t6,end_prog
lb $t2,0($t0) # Load Byte: load the current byte - A[i]
lb $t3,0($t1) # Load Byte: load the next byte - A[i+1]
add $t4,$t2,$t3 # $t4 = A[i] + A[i+1]
sb $t4,0($t0) # Store Byte: store $t4 to address 0+$t0 in memory
addi $t0,$t0,2 # Address of current byte - i
addi $t1,$t1,2 # Address of next byte - i+1
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