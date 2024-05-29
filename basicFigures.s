.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480	


//----------------------------- Para calcular el pixel -----------------------------------
pixel_calculation:
    //params: x3 coordeanadas en x ,x4 coordenadas en y

	mov x0, 640							// x0 = 640.
	mul x0, x0, x4						// x0 = 640 * y.		
	add x0, x0, x3						// x0 = (640 * y) + x.
	lsl x0, x0, 2						// x0 = ((640 * y) + x) * 4.
	add x0, x0, x20						// x0 = ((640 * y) + x) * 4 + framebuffer[0]
ret	
//------------------------------ Fin calcular pixel -----------------------------------------

//------------------------------- imprimir pixel --------------------------------------------
//params x3 = x coord, x4 = y coord  w10 = color
paint_pixel:

// SP es un puntero a pila que apunta a la direccion de retorno de la funcion
sub SP, SP, 8               // Reservo espacio en la pila para almacenar un valor de 64 bits 						
stur X30, [SP, 0]		    // Guardo el valor de retorno en la pila

	bl pixel_calculation    // x0 = ((640 * y) + x) * 4 + framebuffer[0]
	stur w10, [x0]          // Guardo el color en la direccion de memoria correspondiente

ldr X30, [SP, 0]			// Recupero el valor de retorno de la pila		 			
add SP, SP, 8	            // Libero el espacio de la pila

ret
//------------------------------- fin imprimir pixel ----------------------------------------

//------------------------------- Rectangulo -----------------------------------------

//params x3 = x coord, x4 = y coord, x5 = width, x6 = height, w10 = color
rectangle: 

	sub SP, SP, 8 						
	stur X30, [SP, 0]					
	bl pixel_calculation			
	ldr X30, [SP, 0]					 			
	add SP, SP, 8						
	// Usamos los registros temporales: x9, x11, x12, x13
	mov x9, x2		// x9 = contador altura				
	mov x13, x0							
	rectangleLoop:
		mov x11, x1     // x11 = contador de ancho
		mov x12, x13	//x12 va a ser un registro donde guardo el pixel inicial de cada fila, lo necesito tener pq voy a estar haciendo operaciones en x13				
		printRectangle:
			stur w10, [x13]				
			add x13, x13, 4	    //avanzo al siguiente pixel			
			sub x11, x11, 1		//resto el contador de ancho	    	
			cbnz x11, printRectangle    //si no llegue al final de la fila, vuelvo a pintar el siguiente pixel	
			mov x13, x12				//si llegue al final de la fila, me vuelvo a parar en el primer pixel de la fila
			add x13, x13, 2560			//sumo 2560, equivalente a saltar a la fila de debajo
			sub x9, x9, 1				//resto el contador de altura
			cbnz x9, rectangleLoop	    // si no llegue a la ultima fila, vuelvo a pintar
ret 

