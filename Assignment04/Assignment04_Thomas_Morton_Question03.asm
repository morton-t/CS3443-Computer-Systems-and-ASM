
# Question 3
# Program concatenates two strings
# Then removes nonalphabet characters from the combined string
# Then counts the number of vowels and consonants and outputs their totals

.data
	str1: .space 50
	str2: .space 50

	inputmsg1: .asciiz "Enter the first string: "
	inputmsg2: .asciiz "Enter the second string: "
	
	strWithAlpha: .asciiz "String with just alphabets: "
	numVowels: .asciiz "\nNumber of Vowels in String: "
	numConsonants: .asciiz "Number of Consonants in String: "
	
	newLine: .asciiz "\n"
	
	combinedStr: .asciiz "Combined String: "

.text
	.globl main
		main:
			#Prompt first input
			li $v0, 4
			la $a0, inputmsg1
			syscall
			
			#Read input and save to str1
			li $v0, 8
			la $a0, str1
			la $a1, 50
			syscall
			
			#Prompt econd input
			li $v0, 4
			la $a0, inputmsg2
			syscall
			
			#Read input and save to str2
			li $v0, 8
			la $a0, str2
			la $a1, 50
			syscall
			
			#Load $a0, $a1 for function call
			la $a0, str1
			la $a1, str2
			
			#Call concatenate
			jal concatenate

		
		#Exit Program
		END:
			li $v0, 10
			syscall
			
	concatenate:
		
		#########
		# $s0 = str1
		# $s1 = str2
		# $s2 = i
		# $s3 = j
		# $s4 = len
		# $s5 = char str1
		# $s6 = char str2
		# $s7 = str1 starting address
		#########
		
		#Adjust stack pointer and save $ra
		sub $sp, $sp, 4
		sw $ra, ($sp)
		
		# Save str1 and str2 to $s registers 0 and 1 respectively
		move $s0, $a0
		move $s1, $a1

		# Reset vars to 0
		li $s2, 0
		li $s3, 0
		li $s4, 0
		li $s5, 0
		li $s6, 0
		li $s7, 0
		
		#Load first character of str1 and str2
		lb $s5, ($s0)
		lb $s6, ($s1)
		
		# Load starting address for str1
		la $s7, ($s0)
		
		CONCATFOR1: 
			#branch if character is null
			beq $s5, 0, ENDCONCATFOR1
			
			
			#Increment character (FIX TO USE i) & Increment i
			addi $s0, $s0, 1
			addi $s2, $s2, 1
			
			#Load next character to $s5
			lb $s5, ($s0)
			
			j CONCATFOR1
			
		ENDCONCATFOR1:
			
		CONCATFOR2:
			#Branch if str2 char is null
			beq $s6, 0, ENDCONCATFOR2
			
			# Append byte from string 2 to addr at end of str1
			sb $s6, ($s0)
			
			#Increment i, j, $s0, $s1
			addi $s0, $s0, 1
			addi $s1, $s1, 1
			addi $s2, $s2, 1
			addi $s3, $s3, 1
			
			
			#Load next character to $s6
			lb $s6, ($s1)
			
			j CONCATFOR2
			
		ENDCONCATFOR2:
		
		# Load $s6 with null character
		# Then append the null to the end of str1
		li $s6, 0
		sb $s6, ($s0)
				

		# Load $a0 with str1 address for next function call
		la $a0, ($s7)
		
		#Call removeNonAlphaCharacters
		jal removeNonAlphaCharacters
		
		# replace $ra and stack pointer
		lw $ra, ($sp)
		add $sp, $sp, 4
		
		jr $ra
	
	removeNonAlphaCharacters:
		#####
		# $s0 = line
		# $s1 = i
		# $s2 = j
		# $s3 = line character [i]
		# $s4 = line character [j]
		# $s5 = line start addr
		# $s6 = temporary hold for j + 1 and nullchar
		#####
		
		# Increment $sp and save $ra
		sub $sp, $sp, 4
		sw $ra, ($sp)
		
		# Load $s0 with address in $a0 (line)
		move $s0, $a0
		
		# Copy line start addr
		move $s5, $s0
		
		# Display combined string msg
		li $v0, 4
		la $a0, combinedStr
		syscall
		
		# Print combined string from $s0
		li $v0, 4
		la $a0, ($s0)
		syscall
		
		#Load first str[i]; init i to 0
		lb $s3, ($s0)
		li $s1, 0
			
		
		## FOR LOOP START
		REMOVEFOR:	
			#Branch if char == '\0'
			beq $s3, 0, ENDREMOVEFOR
					
			
			## WHILE LOOP START
			REMOVEWHILE:
			### WHILE STATEMENT CONDITIONS
			
				#  !(line[i] >= 'A' && line[i] <= 'Z')
				blt $s3, 65, ENDC1 #less than A == F; F && T == F; end first condition
				bgt $s3, 90, ENDC1 #greater than Z == F; F && T == F; end first condition
				
				#!T == F; Exit while
				b ENDFORINWHILE
				
				ENDC1:
				#!F == T; check next condition
				#  !(line[i] >= 'a' && line[i] <= 'z')
				blt $s3, 97, ENDC2 #less than a == F; F && T == F; end second condition
				bgt $s3, 122, ENDC2 #greater than z == F; T && F == F; end second condition
					
				# !T == F; Exit while
				b ENDFORINWHILE
					
				ENDC2:
				# !F == T; check next condition
				bne $s3, 0, ENDC3 # if char == '\0' then F
				
				# !T == F; exit while
				b ENDFORINWHILE
				
				ENDC3:
				# !F == T; continue in while loop
				
			### END WHILE LOOP CONDITIONS
				

				## FOR LOOP IN WHILE START
				
				# Set j = i
				move $s2, $s1
				
				# Access str[j]		
				add $s0, $s5, $s2	# Add Index to addr of str
				lb $s4, ($s0)		# Load new index to $s4
				
				
				FORINWHILE:
					#Branch if char is '\0'
					beq $s4, 0, ENDFORINWHILE
					
						
					# Set $s6 = char at [j + 1]
					lb $s6, 1($s0)
					sb $s6, ($s0)
					
					
					# Increment and access next str[j]	
					addi $s2, $s2, 1	# Increment index
					add $s0, $s5, $s2	# Add Index to addr of str
					lb $s4, ($s0)		# Load new index to $s4
					
					
					j FORINWHILE
					
					#Append a null to end of string
					addi $s6, $0, 10
					sb $s6, ($s0)
					
				ENDFORINWHILE:
				## END FOR LOOP IN WHILE


			ENDREMOVEWHILE:
			## WHILE LOOP END


			# Access str[i]		
			addi $s1, $s1, 1	# Increment index
			add $s0, $s5, $s1	# Add Index to addr of str
			lb $s3, ($s0)		# Load new index to $s3
			
			j REMOVEFOR
		
		ENDREMOVEFOR:
		# FOR LOOP END
		
		
		# Load $a0 with str
		la $a0, ($s5)
		
		jal countVowelConsotant
		
		# Replace $ra and sp
		lw $ra, ($sp)
		add $sp, $sp, 4
		
		jr $ra
		
	countVowelConsotant:
	
		######
		# $s0 = str
		# $s1 = i
		# $s2 = vCount
		# $s3 = cCount
		# $s4 = current char
		# $s5 = index ?
		######

		
		# Set $s0 to string address from $a0
		move $s0, $a0
		
		# Set other variables to 0
		li $s1, 0
		li $s2, 0
		li $s3, 0
		li $s4, 0
		li $s5, 0
		
		# Prompt message - just alphabets
		li $v0, 4
		la $a0, strWithAlpha
		syscall
		
		# Print str
		li $v0, 4
		la $a0, ($s0)
		syscall
		
		# Load $s4 with first char
		lb $s4, ($s0)
		
		# WHILE LOOP IN COUNT START
		COUNTWHILELOOP:
			beq $s4, 0, ENDCOUNTWHILE	
			
###################### ## IF STATEMENT IN WHILE
			
				# #If equal to vowel, goto if
				beq $s4, 65, COUNTIF
				beq $s4, 69, COUNTIF
				beq $s4, 73, COUNTIF
				beq $s4, 79, COUNTIF
				beq $s4, 85, COUNTIF
			
				beq $s4, 97, COUNTIF
				beq $s4, 101, COUNTIF
				beq $s4, 105, COUNTIF
				beq $s4, 111, COUNTIF
				beq $s4, 117, COUNTIF
				
				#Else goto else
				b COUNTELSE
			
				COUNTIF:
					# Increment vCount
					addi $s2, $s2, 1
				
				b ENDCOUNTIF
			
				# ELSE STATEMENT IN WHILE
				COUNTELSE:
					# Increment cCount
					addi $s3, $s3, 1
				
			# END IF STATEMENT
			ENDCOUNTIF:
			
			# Increment i			
			addi $s1, $s1, 1	# Increment index
			add $s5, $s0, $s1	# Add Index to addr of str
			lb $s4, ($s5)		# Load new index to $s4

			j COUNTWHILELOOP
			
		ENDCOUNTWHILE:
		# WHILE LOOP IN COUNT END
		
		# Print statement for num vowels
		li $v0, 4
		la $a0, numVowels
		syscall
		
		# Print numVowels
		li $v0, 1
		la $a0, ($s2)
		syscall
		
		#Print newline
		li $v0, 4
		la $a0, newLine
		syscall
		
		# Print statement for num consonants
		li $v0, 4
		la $a0, numConsonants
		syscall

		# Print numConsonants
		li $v0, 1
		la $a0, ($s3)
		syscall		
		
		#Return				
		jr $ra
