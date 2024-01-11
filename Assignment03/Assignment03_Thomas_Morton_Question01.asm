.data
	c: .space 1
	
	lowercase_vowel: .word 0
	uppercase_vowel: .word 0
	
	msg: .asciiz "Enter an alphabet: "
	isv: .asciiz " is a vowel."
	isc: .asciiz " is a consonant."

.text
	.globl main
		main:
	
			#prompt user for input
			li $v0, 4
			la $a0, msg
			syscall
			
		
			#ready input
			li $v0, 12
			la $a0, c($0)
			syscall
			
			#Store from char c to the stack
			sub $sp, $sp, 4
			sb $v0, 0($sp)
			
			
			
			#Load from the stack to register
			lb $s0, 0($sp)
			
			#Restore the stack pointer after load
			addi $sp, $sp, 4
			
			
			#Load vals to register for comparison
			la $t1, 97
			la $t2, 101
			la $t3, 105
			la $t4, 111
			la $t5, 117
			
			
			#Branch if value from the stack equals temp registers
			beq $s0, $t1, lowerEqual 
			beq $s0, $t2, lowerEqual
			beq $s0, $t3, lowerEqual
			beq $s0, $t4, lowerEqual 
			beq $s0, $t5, lowerEqual 
			returnLower:
			
			#Load vals to register for comparison
			la $t1, 65
			la $t2, 69
			la $t3, 73
			la $t4, 79
			la $t5, 85
			
			#Branch if value  from the stack equals temp registers
			beq $s0, $t1, upperEqual
			beq $s0, $t2, upperEqual
			beq $s0, $t3, upperEqual
			beq $s0, $t4, upperEqual
			beq $s0, $t5, upperEqual
			returnUpper:
		
			#Load vals from vars	
			lb $t0, uppercase_vowel		
			lb $t1, lowercase_vowel
			
			#branch if input was vowel
			beq $t0, 1, isvowel
			beq $t1, 1, isvowel
			
			
			#Else branch and print is consonant
			b isconsonant
			b isconsonant
								
			
			toend:
			#End main
				li $v0, 10
				syscall
				

		# if uppercase set var to 1
		upperEqual:
			la $a0, uppercase_vowel
			li $a1, 1
			sw $a1, 0($a0)
			j returnUpper
		
		# if lowercase set var to 1
		lowerEqual:
			la $a0, lowercase_vowel
			li $a1, 1
			sw $a1, 0($a0) 
			j returnLower

		isvowel:
			#load char to print
			li $v0, 11
			la $a0, ($s0)
			syscall
		
			#load string and then print string and char
			li $v0, 4
			la $a0, isv
			syscall
		
			j toend
			
		isconsonant:
			li $v0, 11
			la $a0, ($s0)
			syscall
		
			#load string and then print string and char
			li $v0, 4
			la $a0, isc
			syscall
			
			j toend	
