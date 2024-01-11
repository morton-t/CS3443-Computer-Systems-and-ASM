@.section _init


.global _start

@ Set base address for GPIO 
.equ baseAddr, 0x3F200000

@ Set function select
.equ GPFSEL2, 0x08

@ Set offset for GPIO _21_
.equ outputGPIO, 0x08

@ Set offset to set pin
.equ GPFSET0, 0x1c
.equ GPFCLR0, 0x28

@ Set bit position for pin 21
.equ pinGPIO, 0x200000

@ Set delay value
.equ delay, 0x00FFFFFF

_start:

	@ Load register with looping sentinal
	ldr r0, =sentinal

	@ Load GPIO base address
	ldr r1, =baseAddr

	@ Set GPIO 21 as an output
 	ldr r2, =outputGPIO		
	str r2, [r1, #GPFSEL2]  @ Add function select to base addr


	loopStart$:
	     @ Trigger LED to turn on

		@ Set register 2 with GPIO bit position for pin 21 & set register
		ldr r2, =pinGPIO
		str r2, [r1, #GPFSET0]
	
		@ Create a delay
		ldr r3, =delay
		ldr r4, =#0x00000000
		wait1$:	
			add r4, r4, #0x00000001
			cmp r3, r4
			bne wait1$

	     @ Trigger LED to turn off

		@ Set register 2 with GPIO bit position for pin 21 & clear register
		ldr r2, =pinGPIO
		str r2, [r1, #GPFCLR0]

		
		@ Create a delay
		ldr r3, =delay
		ldr r4, =#0x00000000
		wait2$:
			add r4, r4, #0x00000001
			cmp r3, r4
			bne wait2$

		b loopStart$


@ Safety loop

loop$:
	b loop$

