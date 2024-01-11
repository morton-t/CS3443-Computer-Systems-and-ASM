### Please press enter after entering the first number

.data
	n1: .space 1
	n2: .space 1
	i: .byte 1
	
	gcd: .space 1
	
	msg1: .asciiz "Enter two whole numbers greater than 0: "
	
	msg2: .asciiz "G.C.D of "
	msg3: .asciiz " and "
	msg4: .asciiz " is "
	
.text
	.globl main
		main:
			#Prompt for input
			li $v0, 4
			la $a0, msg1
			syscall
			
			#ready input
			li $v0, 5
			syscall
			
			
			#save input to n1
			sb $v0, n1($0)
			lb $t0, n1($0)
				
			
			READ:
				#ready input
				li $v0, 5
				syscall
			
				#save input to n2
				sb $v0, n2($0)
				lb $t1, n2($0)
				
			#Branch to read if input is a space	
			beq $t1, 32, READ

			### FOR LOOP START
				#Initialize i with 1
				addi $t0, $0, 1
			
				#load temp registers with inputs
				lb $t1, n1($0)
				lb $t2, n2($0)
			
				FOR:
				#Skip loop if i greater than n1 or n2
				bgt $t0, $t1, ENDFOR
				bgt $t0, $t2, ENDFOR
			
				#Perform modulo division on n1
				div $t1, $t0
				#move remainder to $t3
				mfhi $t3
			
				#Perform modulo division on n1
				div $t2, $t0
			
				#move remainder to $t4
				mfhi $t4
			
				##IF Start
					bne $t3, 0, ENDIF
					bne $t4, 0, ENDIF
					
					#Store i in GCD
					sb $t0, gcd($0)
					
					#Store from gcd to the stack
					sub $sp, $sp, 4
					sb $t0, 0($sp)

					ENDIF:	
				##IF END
			
				#increment sentinal i
				addi $t0, $t0, 1
				j FOR		
			
				ENDFOR:
			### FOR LOOP END
			
			
			#Message print
			li $v0, 4
			la $a0, msg2
			syscall
			
			#Print first input
			li $v0, 1
			lb $a0, n1($0)
			syscall
			
			#Message print
			li $v0, 4
			la $a0, msg3
			syscall
			
			#Print second input
			li $v0, 1
			lb $a0, n2($0)
			syscall
			
			#Message print
			li $v0, 4
			la $a0, msg4
			syscall
			
			
			#Load from the stack to register
			lb $s0, 0($sp)
			
			#Print gcd loaded from stack
			li $v0, 1
			la $a0, ($s0)
			syscall
			
			#Restore stack pointer
			addi $sp, $sp, 4
		
		
		END:
			#End execution
			li $v0, 10
			syscall
