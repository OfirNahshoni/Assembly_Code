# Question 15 - Project 1 Lab CS
# Purpose: Program that get 2 input integers from user and calculates results of the operations:
# A+B , A-B , A/B , A%B

.data 0x10010000
next_line: .asciiz "\n"
add_op: .asciiz "A+B = "
sub_op: .asciiz "A-B = "
div_op: .asciiz "A/B = "
mod_op: .asciiz "A%B = "
input_msg: .asciiz "Please enter 2 numbers:\n"
output_msg: .asciiz "The results of the following calculations are:\n"

.text
# Main function
main:
# Display massage for the user to enter one word
la $a0,input_msg # Load Address: load address of $a0 to the string input_msg
li $v0,4 # Syscall number 4: print string
syscall

# Get 2 integers from user - 2 inputs (A,B):
li $v0,5 # Syscall number 5: input integer from user
syscall
add $t1,$v0,$0 # Save the first integer input - A
li $v0,5 # Syscall number 5: input integer from user
syscall
add $t2,$v0,$0 # Save the second integer input - B

la $a0,output_msg # Load Address: load address of $a0 to the string output_msg
li $v0,4 # Syscall number 4: print string
syscall

# op1(+)
la $a0,add_op # Load Address: load address of $a0 to the string add_op
li $v0,4 # Syscall number 4: print string
syscall
add $a0,$t1,$t2 # $a0 = A+B
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load Address: load address of $a0 to the string next_line
li $v0,4 # Syscall number 4: print string
syscall

# op2(-)
la $a0,sub_op # Load Address: load address of $a0 to the string sub_op
li $v0,4 # Syscall number 4: print string
syscall
sub $a0,$t1,$t2 # $a0 = A-B
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load Address: load address of $a0 to the string next_line
li $v0,4 # Syscall number 4: print string
syscall

div $t1,$t2 # Divide: $t1/$t2 - LO is quotient and HI is reminder

# op3(/)
la $a0,div_op # Load Address: load address of $a0 to the string div_op
li $v0,4 # Syscall number 4: print string
syscall
mflo $a0 # Set $a0 as the quotient of the division $t1/$t2 (A/B)
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load Address: load address of $a0 to the string next_line
li $v0,4 # Syscall number 4: print string
syscall

# op4(%)
la $a0,mod_op # Load Address: load address of $a0 to the string mod_op
li $v0,4 # Syscall number 4: print string
syscall
mfhi $a0 # Set $a0 as the reminder of the division $t1/$t2 (A/B)
li $v0,1 # Syscall number 1: print integer
syscall
la $a0,next_line # Load Address: load address of $a0 to the string next_line
li $v0,4 # Syscall number 4: print string
syscall