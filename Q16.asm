# Question 16 - Project 1 Lab CS
# Purpose: Program that changes in 'Allice.txt' each lower case letters into upper case letters
# Output: New file 'AlliceU.txt' created

.data 0x10010000
buffer: .space 100000 # String that includes all the words - read from file (input) or write to file (output)
input_file_name: .asciiz "/Allice.txt"
before_change: .asciiz "\n---------------------------------\nString read from input file, before change:\n"
output_file_name: .asciiz "/AlliceU.txt"
after_change: .asciiz "\n---------------------------------\nString to write to output file, after change:\n"

.text
# Open input file Allice.txt to read:
li $v0,13 # Syscall number 13: open file
la $a0,input_file_name # Load Address: get the file name into $a0
li $a1,0 # File flag = 0 -> Read operation
li $a2,0 # File mode = 0 -> Mode ignored
syscall
move $s0,$v0 # File descriptor to read from

# Read input file - Allice.txt
li $v0,14 # Syscall number 14: read from file
move $a0,$s0 # Move $s0 to $a0
la $a1,buffer # Address of the input buffer (array) -> will include all words
li $a2,100000 # Maximum number of characters to read
syscall

# Close the input file - Allice.txt
li $v0,16 # Syscall number 16: close file
syscall

print_input_string:
# Print string read from input file - before change
li $v0,4 # Syscall number 4: print string
la $a0,before_change # Load Address: to print massage before change
syscall
li $v0,4 # Syscall number 4: print string
la $a0,buffer # Load Address
syscall

# Code that change every lower case to upper case letter
la $t0,buffer # Load Address: load address of first char in string buffer into $t0
loop:
lb $t2,0($t0) # Load Byte: load the current char in the input string
beq $t2,$0,print_new_string
# Checking the current char from input string is not lower case:
# If upper case -> move to next char
# If lower case -> change to upper case
blt $t2,'a',continue # Branch Less Than: if $t2 < 'a'=97 jump to label continue
bgt $t2,'z',continue # Branch Greater Than: if $t2 > 'z'=122 jump to label continue
# This code is operated of the current character is lower case letter:
addi $t3,$t2,-32 # Change the lower case letter into upper case letter and copy to $t3 = $t2-32
sb $t3,0($t0) # Store Byte: store upper case letter in the output string
continue: # Continue to the next char across the string buffer
addi $t0,$t0,1 # Promote index to the next character in the string buffer
j loop # Jump to label loop

print_new_string:
# Print string to write to output file - after change
li $v0,4 # Syscall number 4: print string
la $a0,after_change # Load Address: to print massage before change
syscall
li $v0,4 # Syscall number 4: print string
la $a0,buffer # Load Address
syscall

write_file:
# Open (Create) output file AlliceU.txt to Write:
li $v0,13 # Syscall number 13: open file
la $a0,output_file_name # Load Address: load address of string represents the name of the file into $a0
li $a1,1 # File flag = 0 -> Write operation
#li $a2,0 # File mode = 0 -> Mode ignored
syscall
move $s0,$v0 # File descriptor of output file AlliceU.txt

# Write to output file AlliceU.txt:
li $v0,15 # Syscall number 15: write to file
move $a0,$s0 # File descriptor
la $a1,buffer # Load Address: load address of output string into $a1
la $a2,100000 # Load Address: length of the buffer string
syscall

# Close the output file AlliceU.txt:
li $v0,16 # Syscall number 16: close file (in $a0 should be file descriptor need to be closed)
move $a0,$s0 # Move file descriptor from stack memory ($s1) to $a0
syscall

# Exit operation - end of program
li $v0,10
syscall