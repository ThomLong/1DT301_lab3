
	.EQU	BUTTON_ON, 0
	.EQU	BUTTON_OFF, 1
	.EQU	LED_PIN1, 2
	.EQU	GPIO_OUT, 1
	.EQU	GPIO_IN, 0

.thumb_func		@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_PIN1
	BL	gpio_init
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #BUTTON_ON
	BL	gpio_init
	MOV	R0, #BUTTON_ON
	MOV	R1, #GPIO_IN
	BL	link_gpio_set_dir
	
	MOV	R0, #BUTTON_OFF
	BL	gpio_init
	MOV	R0, #BUTTON_OFF
	MOV	R1, #GPIO_IN
	BL	link_gpio_set_dir
	B 	loop
	
loop:   
	MOV R0, #BUTTON_ON
	BL  link_gpio_get
	CMP R0, #1
	BEQ turn_on
	B loop
	
turn_on:
	MOV R0, #LED_PIN1	
	MOV R1, #1
	BL link_gpio_put
	MOV R0, #BUTTON_OFF
	BL  link_gpio_get
	CMP R0, #1
	BEQ turn_off
	B	turn_on 
	
turn_off:
	MOV R0, #LED_PIN1
	MOV R1, #0
	BL  link_gpio_put
	B	loop 
