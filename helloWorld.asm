# Program to print "Hello World"

.data 0x10000100
	msg: .asciiz "Hello World"

.text
	main: 	li $v0,4
		la $a0, msg
		syscall

		#Exit the program
		li $v0, 10
		syscall

		