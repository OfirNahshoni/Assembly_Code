# Question 6 - Project 1 Lab CS
# Purpose: Program that finds the minimum value in array A and display it
# to Run I/O screen

.data
A: .space 24 # Specify length of array A: 6 words array (6*4)
next_line: .asciiz "\n"
out_str: .asciiz "The minimum number is: "

.text
# Main function
main:
# Define the given arguments for the procedure
addi $a2,$0,0x10010000 # First argument for procedure: start_address
addi $a3,$0,6 # Second argument for procedure: quantity_numbers_init

# Call to procedure Random_IntArray_Init - Initialize array A
jal Random_IntArray_Init # Jump And Link to procedure

# Finding the maximum number in A and display it
add $t0,$0,$0 # Index: i=0
addi $t1,$0,4 # $t1=4
mul $t2,$a3,$t1 # Upper limit of initialization: $t2 = $a3 * 4
# Define the element for comparison
lw $t3,0($a2) # Load Word: load from address 0+$a2 in memory into $t3
addi $t0,$t0,4 # i=i+4

find_min:
beq $t0,$t2,end_prog # If $t0=$t2 jump to label end_prog
add $t4,$a2,$t0 # Address of current element 0x10010000+4
lw $t5,0($t4) # Load Word: load from address 0+$t4 in memory into $t5
slt $t6,$t3,$t5 # Set Less Than: set $t6=1 if $t3<$t5 , set $t6=0 if $t3>=$t5
bne $t6,$0,continue # If $t6=0 ($t3>=$t5) jump to label continue
add $t3,$0,$t5 # Set $t3=$t5
continue:
addi $t0,$t0,4 # i=i+4
j find_min # Jump to label find_min

end_prog: # End of program
la $a0,out_str # Load Address: load address of string out_str into $a0
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$t3,$0 # Assign $a0=$t3, $t3 is the maximum value in array A
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
add $t3,$t0,$a2 # Current address of the integer we want to store in array A
sw $a0,0($t3) # Store Word: store $a0 (by value) into the start_address+i
lw $a0,0($t3) # Load Word: load from address 0+$t3 in memory into $a0
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load Address: load the address of string next_line into $a0
li $v0,4 # Syscall number 4: print string
syscall
addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end_procedure:
jr $ra # Jump Return - return to main function