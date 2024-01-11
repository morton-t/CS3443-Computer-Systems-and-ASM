.data

	lowerRange: .space 1
	upperRange: .space 1
	
	c: .space 1
	
	msg1: .asciiz "Please enter the first character: "
	msg2: .asciiz "\nPlease enter the last character: "
	
	msg3: .asciiz "\nThe alphabets between "
	msg4: .asciiz " and "
	msg5: .asciiz " are: "
	
	space: .asciiz " "

.text
	.globl main
		main:
			#Prompt for first message - user input
			li $v0, 4
			la $a0, msg1
			syscall
			
			#prepare register & store first char
			li $v0, 12
			syscall
			sb $v0, lowerRange($0)
			
			#Store from lowerRange to the stack
			sub $sp, $sp, 4
			sb $v0, 0($sp)
			
			#Prompt for second message - user input
			li $v0, 4
			la $a0, msg2
			syscall
			
			#prepare register & store last char
			li $v0, 12
			syscall
			sb $v0, upperRange($0)
			
			
			#Store from upperRange to the stack
			sub $sp, $sp, 4
			sb $v0, 0($sp)
			
			
			#Load from the stack to register
			lb $s0, 0($sp)
			
			#first half print statement
			li $v0, 4
			la $a0, msg3
			syscall
			
			#Print lower char
			li $v0, 11
			lb $s0, 4($sp)
			la $a0, ($s0)
			syscall
			
			#Print 'and'
			li $v0, 4			
			la $a0, msg4
			syscall
			
			#Print upper char
			li $v0, 11
			lb $s1, 0($sp)
			la $a0, ($s1)
			syscall
			
			#Print 'are: '
			li $v0, 4
			la $a0, msg5
			syscall
			
			#Add 1 to lowerRange
			addi $s0, $s0, 1
			
			FOR:

				
				#Save lowerRange back to stack
				sb $s0, 4($sp)
				
				#Print lowerRange
				li $v0, 11
				lb $s0, 4($sp)
				la $a0, ($s0)
				syscall
				
				#Add 1 to lowerRange
				addi $s0, $s0, 1
				
				#Return start of loop if lower < upper
				blt $s0, $s1, FOR
			
			
			#Restore stack pointer
			addi $sp, $sp, 8
		
			#End execution
			li $v0, 10
			syscall
