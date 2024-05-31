.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480	
.include "basicFigures.s"


boatFlag:
//parametros x1 = alto de la bander x3= coordenada x de la punta, x4= coordenada y de la punta
sub SP, SP, 8 						
stur X30, [SP, 0]
//mov x23, x3				//guarda coordenada x de la punta
//mov x24, x4				//guarda coordenada y de la punta
	
mov x4, SCREEN_HEIGH
	lsr x4, x4, 1
	sub x4, x4, 100

	movz x10, 0x92, lsl 16
	movk x10, 0x7e5e, lsl 00
	//mov x3, x23
	//mov x4, x24
bl triangle2

ldr X30, [SP, 0]					 			
add SP, SP, 8	
ret

boat: 
//parametros x1 = alto del barco, x3= coordenada x de la punta, x4= coordenada y de la punta
sub SP, SP, 8
stur X30, [SP, 0]
	lsr x4, x4, 1
	//sub x4, x4, 20
	movz x10, 0xFFFF, lsl 16
	movk x10, 0xFFaa, lsl 00
    bl triangle2
        mov x1, 60				//ancho del barco
        mov x2, 15				//alto del barco
	movz x10, 0x92, lsl 16		// color barco
	movk x10, 0x7efe, lsl 00	//color barco
    bl rectangle

ldr X30, [SP, 0]
add SP, SP, 8
ret 
