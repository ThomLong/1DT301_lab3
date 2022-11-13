.thumb_func		     		@ Necessary because sdk uses BLX
.global main	        @ Provide program starting address to linker

main:
	BL	stdio_init_all	@ initialize uart or usb

loop:
	LDR	R0, =array		@ load address of array
	MOV R1,	#0					@ 8 elements in the array
	BL	average
	@ Print string and average value 
	LDR	R0, =averageStr	@ load address of average string
	BL	printf					@ Call pico_printf
	B	loop							@ loop forever

average:
	push {lr}
	BL sum
	LSR R1,	#3
	pop {pc}
	bx lr

sum:
	LDR R2, [R0, R7]
	ADD R1, R2
	LDR R2, [R0, #4]
	ADD R1, R2
	LDR R2, [R0, #8]
	ADD R1, R2
	LDR R2, [R0, #12]
	ADD R1, R2
	LDR R2, [R0, #16]
	ADD R1, R2
	LDR R2, [R0, #20]
	ADD R1, R2
	LDR R2, [R0, #24]
	ADD R1, R2
	LDR R2, [R0, #28]
	ADD R1, R2
	bx 	lr
	
.data
	.align 4						@ necessary alignment
	array: .word 10, 20, 30, 40, 50, 60, 70, 80
	averageStr: .asciz   "Average string: %d\n"
