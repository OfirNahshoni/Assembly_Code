# Question 1 - Project 1 Lab CS
# Purpose: Program that make 20 random integers and store them into array (A)
.data 0x10010000
A: .space 80 # Block (array) of 20 words (20*4)
comma_print: .asciiz ","

.text
add $t0,$0,$0 # i=0
addi $t1,$0,80 # Upper limit of loop is 76 (last word that loaded)

#la $a0,A # Address of $a0 is the first element in array A

loop:
beq $t0,$t1,end # If $t0=$t1 jump to end

# Random 1 number
addi $a1,$0,100 # Upper limit integer is 100
li $v0,42 # Syscall number 42: random integers
syscall
subi $a0,$a0,50 # Move the range from [0,100] to range [-50,50]
sw $a0,A($t0) # Load Word $a0 into the current element in A
# Print the random integer to Run I/O screen
li $v0,1 # Syscall number 1: print integer
syscall

la $a0,comma_print # Set the string "," into $a0
li $v0,4 # Syscall number 4: print string
syscall

addi $t0,$t0,4 # i = i + 4
j loop # Jump to label 'loop'

end:
li $v0,10 # Syscall number 10: exit operation
syscall