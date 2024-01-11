

# Question 4
# Program uses recursion to print an inputted string backwards
# Upon the user ending the string with a '\n' character

.data
	msg1: .asciiz "Enter a sentence: "

.text
	.globl main
		main:
			#Prompt for user input
			li $v0, 4
			la $a0, msg1
			syscall
			
			jal reverseSentence
		
		END:
			#Exit program
			li $v0, 10
			syscall
			
		reverseSentence:
			####
			# $s0 = c
			# $s1 = counter for $sp
			####
			
			#Update stack pointer
			sub $sp, $sp, 4
			sw $ra, ($sp)
			
			#Adjust stack pointer; Prepare to read next char
			sub $sp, $sp, 1
			li $v0, 12
			syscall
			
			#Save character to stack
			sb $v0, ($sp)
			
			# Update char c
			lb $s0, ($sp)
			
			#align $sp to word bounary
			sub $sp, $sp, 3
			
			#IF STATEMENT START
				# Skip if statement if c == '\n'
				beq $s0, 10, ENDIF
					
					#Recursive call
					jal reverseSentence
					
					#align sp to char data
					add $sp, $sp, 3
					
					#Load char c to register
					lb $s1, ($sp)
					
					#Adjust stack pointer to word boundary
					add $sp, $sp, 1
##					
						#Update stack pointer
						lw $ra, ($sp)
						add $sp, $sp, 4
##					
					#Print character
					li $v0, 11
					la $a0, ($s1)
					syscall					
				
				ENDIF:
			#IF STATEMENT END
			
			jr $ra
