

# Question 1
# Program finds the least common multiple (integer division) between two input numbers


.data
	#Declare integer variables
	n1: .space 4
	n2: .space 4
	n2Modified: .space 4
	
	gcd: .space 4
	lcm: .space 4
	
	#Declare message strings
	msg1: .asciiz "Enter the first positive integers: "
	msg2: .asciiz "Enter the second positive integers: "
	
	msgLCM: .asciiz "The LCM of two numbers " 
	andMsg: .asciiz " and "
	is: .asciiz " is "
	period: .asciiz "."

.text
	.globl main
		main:
			#Prompt message 1
			li $v0, 4
			la $a0, msg1
			syscall
			
			#Ready input
			li $v0, 5
			syscall
			
			#store input to address of n1
			la $t0, n1
			sw $v0, ($t0)
			
			#Prompt message 2
			li $v0, 4
			la $a0, msg2
			syscall
			
			#ready input
			li $v0, 5
			syscall
			
			#store input to address of n2
			la $t0, n2
			sw $v0, ($t0)
			
		
			#save n1 to gcd
			lw $t0, n1
			add $t1, $t0, $0
			la $t2, gcd
			sw $t1, ($t2)
			
			#save n2 to n2Modified
			lw $t0, n2
			add $t2, $t0, $0
			la $t3, n2Modified
			sw $t2, ($t3)
			
			#Load registers with gcd and n2
			lw $t1, gcd
			lw $t2, n2Modified
			
			#--While loop start
			
			#$t1 = gcd
			#$t2 = n2Modified
			
			WHILE:
				#if gcd == n2Modified, end loop
				beq $t1, $t2, ENDWHILE
				
				#--if statement start
				IF:
					#if gcd <= n2Modified skip to else; otherwise subtract n2Modified from gcd
					ble $t1, $t2, ELSE
					sub $t1, $t1, $t2
					j WHILE
				ELSE:
					#Otherwise, subtract gcd from n2Modified
					sub $t2, $t2, $t1
					j WHILE
				#--if statement end
			ENDWHILE:
			#--While loop end
			
			#Update values for gcd
			la $a0, gcd
			sw $t1, ($a0)
			
			#Function call
			la $a0, n1
			la $a1, n2
			la $a2, gcd
			jal LCM
			
			# Move results from LCM to lcm
			la $a0, lcm
			sw $v0 ($a0)

			
			#Output final message prompt
			li $v0, 4
			la $a0, msgLCM
			syscall
			
			#Output first number
			li $v0, 1
			lw $a0, n1
			syscall
			
			#Print 'and'
			li $v0, 4
			la $a0, andMsg
			syscall
			
			#Output second number
			li $v0, 1
			lw $a0, n2
			syscall
			
			#Print 'is'
			li $v0, 4
			la $a0, is
			syscall
			

			#Print LCM
			li $v0, 1
			lw $a0, lcm
			syscall		
			
			
			#Print '.'
			li $v0, 4
			la $a0, period
			syscall
			
			#End program
			END:
				li $v0, 10
				syscall
				
				
	LCM:
	# $a0; $s0 - n1
	# $a1; $s1 - n2
	# $a2; $s2 - gcd

	# $v0 - LCM Return 
	
	# Set $s with values from $a
	lb $s0, ($a0)
	lb $s1, ($a1)
	lb $s2, ($a2)
	
	#Multiply n1 and n2
	mul $s0, $s0, $s1
	
	#Divide n1 * n2 by gcd, store in $v0
	div $v0, $s0, $s2
	
	#return
	jr $ra
	
