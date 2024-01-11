
.data

	msg1: .asciiz "Please enter a string: \n"
	msg2: .asciiz "\nLength of input string: "
	msg3: .asciiz "\nThe array starts at the memory location: "

	i: .space 1

.text
	.globl main
		main:
	
		#Prompt for user input
		li $v0, 4
		la $a0, msg1
		syscall
		

		### Copy array on stack start addr to t0
		addi $t0, $sp, 0
		
 
		# Read in input string, store to stack
		li $v0, 8
		la $a0, 0($sp)
		li $a1, 100
		syscall
		
		### FOR loop start
		lb $t3, i # Initialize counter
		lb $t1, ($sp) # Initialize sentinal with character from stack
		FOR:
			#Display input length
			li $v0, 4
			la $a0, msg2
			syscall
			
			#Print length so far
			li $v0, 1
			la $a0, ($t3) 
			syscall
			
			# update $t1 with character
			addi $sp, $sp, 1
			lb $t1, 0($sp) 
			
			
			# Increase i for iteration
			addi $t3, $t3, 1
			
			# Branch if not null character
			bnez $t1, FOR
		###FOR loop end
		
		#Message prompt starting address for array
		li $v0, 4
		la $a0, msg3
		syscall
		
		#Print starting address for array on stack
		
		li $v0, 1 	# I had instruction 'li $v0, 34' here, which prints hexadecimal values in MARS
		la $a0, ($t0)	# but QtSpim does not support that instruction,
		syscall		# so I'm just printing the decimal representation of the address.
				# If you can, please consider this when grading.
		
		End:
		#End Program
		li $v0, 10
		syscall
