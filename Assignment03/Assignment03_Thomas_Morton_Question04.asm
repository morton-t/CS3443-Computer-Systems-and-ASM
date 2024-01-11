
.data
	msg1: .asciiz "The array elements are: \n"
	newLine: .asciiz "\n"
	
	i: .word 0

.text
	.globl main
		main:

		#Load ints into stack for array
		addi $s0, $zero 100
		addi $sp, $sp, -4
		sw $s0, 0($sp)
				
		addi $s0, $zero 90
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 80
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 70
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 60
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 50
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 40
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 30
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 20
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		addi $s0, $zero 10
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		# End loading ints
		
		
		#Message Prompt for loop
		li $v0, 4
		la $a0, msg1
		syscall
		

		#For loop
		FOR:
			#Load sentinal adress
			lw $t1, i($0)
			
			#Load word from stack
			li $v0, 1
			move $a0, $s0
			syscall
			
			# Increase stack pointer
			addi $sp, $sp, 4
			lw $s0, 0($sp)
			
			#Print newline
			li $v0, 4
			la $a0, newLine
			syscall
			
			# Increment sentinal; branch to start if < 9
			addi $t1, $t1, 1
			sw $t1, i($0)
			blt $t1, 10, FOR
		
		
		#Exit program
		END:
			li $v0, 10
			syscall
