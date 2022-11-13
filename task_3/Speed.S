.thumb_func 	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

	.EQU LED_PIN1, 0				
	.EQU BUTTON_FAST, 1  			
	.EQU BUTTON_SLOW, 2				
	.EQU GPIO_OUT, 1 					
	.EQU GPIO_IN, 0 					
	.EQU sleep_time, 800			
	.EQU max_sleep_time, 2000	


main:
	MOV R0, #LED_PIN1
	BL gpio_init
	MOV R0, #LED_PIN1
	MOV R1, #GPIO_OUT
	BL link_gpio_set_dir
	MOV R0, #BUTTON_FAST
	BL gpio_init
	MOV R0, #BUTTON_FAST
	MOV R1, #GPIO_IN
	BL link_gpio_set_dir
	MOV R0, #BUTTON_SLOW
	BL gpio_init
	MOV R0, #BUTTON_SLOW
	MOV R1, #GPIO_IN
	BL link_gpio_set_dir
	LDR R5, =sleep_time
	BL	loop

loop:
	push {lr}
	MOV R0, #BUTTON_FAST
	BL link_gpio_get 					@ Get button value
	CMP R0, #1 								@ Check if R0 = 1
	BEQ increase 	
	MOV R0, #BUTTON_SLOW
	BL link_gpio_get					@ Get button value
	CMP R0, #1								@ Check if R0 = 1
	BEQ decrease
	MOV R0, #LED_PIN1 				@ Turn ON 
	MOV R1, #1  		
	BL link_gpio_put
	MOV R0, R5
	BL sleep_ms								@ Sleep
	MOV R0, #LED_PIN1  
	MOV R1, #0  							@ Turn OFF
	BL link_gpio_put	
	MOV R0, R5
	BL sleep_ms								@ Sleep
	B loop

increase:
	CMP R5, #100
	BEQ loop
	SUB R5, #100
	BL  loop

decrease:
	LDR R6, =max_sleep_time
	CMP R5, R6
	BEQ loop
	ADD R5, #100
	BL  loop
