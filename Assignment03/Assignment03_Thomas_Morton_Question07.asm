#	n = $t0
#	i = $t1
# 	j = $t2
#	k = $t3

.data
	n: .space 1
	
	msg1: .asciiz "Please enter the number of columns: "
	space: .asciiz " "
	newLine: .asciiz "\n"
	
.text
	.globl main
		main:
		
		#Prompt number of columns
		li $v0, 4
		la $a0, msg1
		syscall
		
		# Save input to variable n
		li $v0, 5
		syscall
		sb $v0, n($0)
		
		#Initialize $t0 with input from n
		lb $t0, n($s0)
		
		#init $t1 with 0 for for1 sentinal 'i'
		li $t1, 0
		FOR1:
			
			#Skip loop if n < 0
			bge $t1, $t0, FOR4
			
			#init $t2 with 0 for for2 sentinal 'j'
			li $t2, 0
			FOR2:
				#Skip loop if j not less than i
				bge $t2, $t1, ENDFOR2
				
				#Print a space
				li $v0, 4
				la $a0, space
				syscall
				
				#Increment sentinal
				addi $t2, $t2, 1
				
				#Restart loop if j < n
				blt $t2, $t0, FOR2
			ENDFOR2:
			
			#init $t3 with 1 for for3 sentinal 'k'
			li $t3, 1
			
			# Init $t4 with n - i
			sub $t4, $t0, $t1	
			FOR3:
				#Branch if 'k' not less than or equal to n - i
				bgt $t3, $t4, ENDFOR3
				
				#Print k
				li $v0, 1
				la $a0, ($t3)
				syscall
				
				#Update for3 sentinal
				addi $t3, $t3, 1
				
				#Repeat loop if k <= (n - i)
				ble $t3, $t4, FOR3
			ENDFOR3:
				
		#Print newline
		li $v0, 4
		la $a0, newLine
		syscall
		
		#Update for1 sentinal, loop if less than n
		addi $t1, $t1, 1
		blt $t1, $t0, FOR1
		#End FOR1
		
		
		
		#Init $t1 with 1 for sentinal 'i'
		li $t1, 1
		FOR4:
			# Exit loop if i >= n
			bge $t1, $t0, END
			
			#Init $t2 with 1 for sentinal 'j'
			li $t2, 1
			
			#Init temp register for sentinal arithmetic (n - i)
			sub $t9, $t0, $t1
						
			FOR5:
				#Skip loop if j not less than (n - i)
				bge $t2, $t9, ENDFOR5
			
				#Print a space
				li $v0, 4
				la $a0, space
				syscall
			
				#Update sentinal
				add $t2, $t2, 1
			
				#Restart loop if j less than (n - i)
				blt $t2, $t9, FOR5
			
			ENDFOR5:
			#Init $t3 with 1 for sentinal 'k'
			li $t3, 1
			
			#Init $t8 with aritmetic for sentinal (i + 1)
			add $t8, $t1, 1
			
			FOR6:
				#Skip loop if k not less than or equal to (i + 1)
				bgt $t3, $t8, ENDFOR6
				
				#Set $t7 with arithmetic for print statement (i + 2 - k)
				add $t7, $t1, 2
				sub $t7, $t7, $t3
				
				#Print result of aritmetic
				li $v0, 1
				la $a0, ($t7)
				syscall
				
				#Update sentinal
				add $t3, $t3, 1
				
				#Repeat loop if k <= (i + 1)
				ble $t3, $t8, FOR6
				
			ENDFOR6:
			
			#Print newline
			li $v0, 4
			la $a0, newLine
			syscall
		
			
		#Update sentinal for FOR4
		add $t1, $t1, 1
			
		# Restart loop if i < n
		blt $t1, $t0, FOR4
						

		END:
		#Exit program
		li $v0, 10
		syscall
