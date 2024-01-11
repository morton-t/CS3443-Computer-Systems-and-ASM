# Illustration of local integer variable

.data

	message1:		.asciiz "Enter a number: "
	message2: 		.asciiz "The number you entered is: "
	message3: 		.asciiz "The address where the number is entered is: "
	newLine:		.asciiz "\n"

.text
	.globl main  # devlare main function as global
	main:
		# Prompt message1
		li $v0, 4
		la $a0, message1
		syscall

		# Accept user input
		li $v0, 5
		syscall
		
		# Save the enetered data into the stack
		addi $sp, $sp, -4	# move the stack 4 bytes down.
		sw $v0, 0($sp)	# store the entered value (stored in $v0) to the stack pointed by $sp
		
		# Prompt message2
		li $v0, 4
		la $a0, message2
		syscall

		# Display user input
		li $v0, 1
		la $a0, 0($sp)	# load $t1 with the value stored in memory that is specified at $t0
		syscall

		# Enter a new line
		li $v0, 4
		la $a0, newLine
		syscall

		# Prompt message3
		li $v0, 4
		la $a0, message3
		syscall

		# Display address where the number is store in the memory
		li $v0, 1
		add $a0, $sp, $0	# mobe stack address pointed by $sp into $a0;
		syscall

		# Restore the stack back to its original state
		addi $sp, $sp, 4	# move the stack 4 bytes up
		
		# Exit the program
		li $v0, 10
		syscall