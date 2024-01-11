
# Question 2
# Program finds all prime numbers between two input numbers

.data

	#Declare variables listed at the start of main
	n1: .space 4
	n2: .space 4
	flag: .space 4
	i: .space 4
	
	#Declare messages to be printed
	msg1: .asciiz "Please enter the first integer: "
	msg2: .asciiz "Please enter the second integer: "
	
	#Print prime number msg
	msgPrime: .asciiz "Prime numbers between "
	andMsg: .asciiz " and "
	areMsg: .asciiz " are: "
	tabMsg: .asciiz "	"
	
	newLine: .asciiz "\n"
	
.text
	.globl main
		main:
		
			#Prompt first message
			li $v0, 4
			la $a0, msg1
			syscall
			
			#Ready input
			li $v0, 5
			syscall
			
			#Move input from $v0 to n1
			la $a0, n1
			sw $v0, ($a0)
			
			#Prompt second message
			li $v0, 4
			la $a0, msg2
			syscall
			
			#Ready input
			li $v0, 5
			syscall
			
			#Move input from $v0 to n2
			la $a0, n2
			sw $v0, ($a0)
			
			#Load n1 & n2 to register $t1 & $t2
			lw $t1, n1
			lw $t2, n2
			
			
			##IF STATEMENT START
			
			#Branch if n1 not > than n2
			ble $t1, $t2, ENDIFMAIN
				######
				# $t1 = n1
				# $t2 = n2
				######
				

				#If statement arithmetic
				add $t1, $t1, $t2
				sub $t2, $t1, $t2
				sub $t1, $t1, $t2
			
				la $a0, n1
				la $a1, n2
				
				# Sture arithmetic results in n1, n2
				sw $t1, ($a0)
				sw $t2, ($a1)
						
			ENDIFMAIN:
			##IF STATEMENT END
			
			#Print prime number message
			li $v0, 4
			la $a0, msgPrime
			syscall
			
			#Print n1
			li $v0, 1
			lw $a0, n1
			syscall
		
			#Print 'and'
			li $v0, 4
			la $a0, andMsg
			syscall
			
			#Print n2
			li $v0, 1
			lw $a0, n2
			syscall
			
			#Print 'are:'
			li $v0, 4
			la $a0, areMsg
			syscall
			
			##FOR LOOP MAIN BEGIN
			
			#Set i to n1 + 1
			lw $t1, n1
			add $t0, $t1, 1
			
			#store result in i
			la $a0, i
			sw $t0, ($a0)
			
			# Load n2 to $t1
			lw $t1, n2
			
			FORMAIN:
				#####
				# $t0 = i
				# $t1 = n2
				# $t2 = flag
				######
				
				bge $t0, $t1, ENDFORMAIN
				
				# Load $a0 for method
				la $a0, i
				
				# Method call
				jal checkPrimeNumber
				
				# Set flag to return value from checkPrimeNumber
				la $a0, flag
				sw $v0, ($a0)
				
				#Load $t2 with flag
				lw $t2, flag
				
				#IF STATEMENT FOR LOOP BEGIN
					#Branch to endif if flag != 1
					bne $t2, 1, ENDIFINFOR
					
					# Print value of i		
					li $v0, 1
					lw $a0, i		
					syscall
					
					# Print a tab
					li $v0, 4
					la $a0, tabMsg
					syscall
					
				ENDIFINFOR:
				##IF STATEMENT FOR LOOP END
				
				# Increment i
				lw $t0, i
				addi $t0, $t0, 1
				
				# Save i
				la $a0, i
				sw $t0, ($a0)
				
				b FORMAIN
				
			ENDFORMAIN:
			##FOR LOOP MAIN END
			
		END:
			#Exit program
			li $v0, 10
			syscall
		
	checkPrimeNumber:
		#####
		# $s0 = n
		# $s1 = flag
		# $s2 = j
		# $s3 = sentinal condition (n / 2)
		#####	

		#Set local vars
		lw $s0, ($a0)
		li $s1, 1
		li $s2, 2
	
		#Set sentinal condition to $s3
		div $s3, $s0, 2
		
		##FOR LOOP START
		CHECKFOR:
			#Exit for loop if $s2 > $s3 (n / 2)
			bgt $s2, $s3, ENDCHECKFOR
					
		
			# If statement start
			
			####
			# $s4 = result of n % j
			#### 
			#Set $s4 to the result of n % j
			div $s0, $s2
			mfhi $s4
			
			bne $s4, 0, ENDCHECKIF
				
				#Set flag to 0
				li $s1, 0
			
				# Break statement
				j ENDCHECKFOR
			ENDCHECKIF:
			##If statement end
		
			# Increment sentinal j
			addi $s2, $s2, 1
			
		#Return to start of for loop	
		j CHECKFOR
			
		ENDCHECKFOR:
		##For loop end
		
		#Set $v0 with return value
		
		move $v0, $s1
		
		jr $ra
