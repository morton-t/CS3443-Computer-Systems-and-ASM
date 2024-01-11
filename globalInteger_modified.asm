# Illustration of global integer variable

.data
	number: .word 0
	
	message1:	.asciiz "Enter a number: "
	message2:	.asciiz "The number you entered is: "
	message3:	.asciiz "The address where the number is entered is: "
	
	newLine:	.asciiz "\n"

.text 
	.globl main	# declare main function as global
	main: 	
			# Prompt message1
			li $v0, 4
			la $a0, message1
			syscall
			
			# Accept user input
			li $v0, 5
			syscall 
			
			# Save the input in variable number
			sw $v0, number($0)
			
			# Prompt message2
			li $v0, 4
			la $a0, message2
			syscall
			
			# Display user input
			li $v0, 1
			lw $a0, number($0)	# load the variable number into $a0 
			syscall 
						
			# Enter new line
			li $v0, 4
			la $a0, newLine
			syscall
			
			# Prompt message3
			li $v0, 4
			la $a0, message3
			syscall
			
			# Display address where the number is stored in the memory
			li $v0, 1
			la $a0, number	# load the address of variable number into $t0 
			syscall 
			

			# Exit the Program
			li $v0, 10	
			syscall
