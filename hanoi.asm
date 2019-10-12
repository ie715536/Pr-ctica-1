#Bonifacio Benavides Yadira Vanessa 714415
#Rodríguez Pérez Urik Paul 715536

.text
	addi $s0, $zero, 6 #Guarda el valor de N
	add $t0, $zero, $s0 #iterador de N (i = N)
	addi $s1, $s1, 0x10010000 #torre 1
	addi $s2, $s2, 0x10010020 #torre 2
	addi $s3, $s3, 0x10010040 #torre 3
	
Do:
	#LLENA LA PRIMERA TORRE
	sw $t0, ($s1) #Ingresa el valor de i actual en la posición indicada
	addi $s1, $s1, 4 #Desplaza el apuntador de la torre
	addi $t0, $t0, -1 #Disminuye el valor de i
	bne $t0, $zero, Do #Se repite si es que no se ha llenado la torre
	
	jal hanoi #Manda a llamar la función recursiva hanoi
	j exit #Termina el código 
	
hanoi:
	bne $s0, 1, else #Salta a loop si N es diferente de 1
	
	#IF N == 1
	addi $s1, $s1, -4 #Posicionas tu apuntador de la torre apuntada por $s1
	lw $t2, ($s1) #Guarda el valor de la posición en $t2
	sw $zero, ($s1) #Guarda 0 en la posición actual
	sw $t2, ($s3) #Guarda el valor que contenía la torre apuntada por $s1, en la apuntada por $s3
	addi $s3, $s3, 4	 #Mueve a la siguiente posición tu apuntador de la torre apuntada por $s3
	jr $ra	#Regresa a donde fue llamada la función
	
else:
	#(N - 1) TORRE 1 TORRE 3 TORRE 2	
	addi $sp, $sp, -8 #Reservas memoria para $ra y para el valor de N actual
	sw $ra, 0($sp) #Guarda en la primer posición de la memoria reservada la dirección de retorno
	sw $s0, 4($sp) #Guarda en la segunda posición de la memoria reservada el valor de N actual
	
	addi $s0, $s0, -1 #Disminuyeen 1 el valor de N actual
	
	#INTERCAMBIA LOS APUNTADORES ENTRE LA TORRE 2 CON LA 3
	add $t1, $zero, $s2 #$t1 apunta a la torre 2
	add $s2, $s3, $zero #El apuntador de la torre 2 ahora apunta a la torre 3
	add $s3, $zero, $t1 #El apuntador de la torre 3 ahora apunta a la torre 2
	
	jal  hanoi #Manda a llamar la función hanoi
	
	lw $ra, 0($sp) #Recuperas el valor de retorno guardado en la memoria
	lw $s0, 4($sp) #Recuperas el valor de N guardado en memoria
	addi $sp, $sp, 8 #Desplazas el apuntador de memoria
	
	#VUELVE A INTERCAMBIAR LOS APUNTADORES ENTRE LA TORRE 2 CON LA TORRE 3
	add $t1, $zero, $s3 #$t1 apunta a la torre 3
	add $s3, $s2, $zero #El apuntador de la torre 3 ahora apunta a la torre 2
	add $s2, $zero, $t1 #El apuntador de la torre 2 ahora apunta a la torre 3
	
	addi $s1, $s1, -4 #Posicionas tu apuntador de la torre apuntada por $s1
	lw $t2, ($s1) #Guarda el valor de la posición en $t2
	sw $zero, ($s1) #Guarda 0 en la posición actual
	sw $t2, ($s3) #Guarda el valor que contenía la torre apuntada por $s1, en la apuntada por $s3
	addi $s3, $s3, 4	 #Mueve a la siguiente posición tu apuntador de la torre apuntada 
	
	#(n - 1) TORRE 2 TORRE 1 TORRE 3
	addi $sp, $sp, -8 #Reservas memoria para $ra y para el valor de N actual
	sw $ra, 0($sp) #Guarda en la primer posición de la memoria reservada la dirección de retorno
	sw $s0, 4($sp) #Guarda en la segunda posición de la memoria reservada el valor de N actual
	
	addi $s0, $s0, -1 #Disminuye en 1 el valor de N actual
	
	#INTERCAMBIA LOS APUNTADORES ENTRE LA TORRE 1 CON LA 2
	add $t1, $zero, $s1 #$t1 apunta a la torre 1
	add $s1, $s2, $zero #El apuntador de la torre 1 ahora apunta a la torre 2
	add $s2, $zero, $t1 #El apuntador de la torre 2 ahora apunta a la torre 1
	
	jal  hanoi #manda a llamar la función hanoi
	
	lw $ra, 0($sp) #Recuperas el valor de retorno guardado en la memoria
	lw $s0, 4($sp) #Recuperas el valor de N guardado en memoria
	addi $sp, $sp, 8 #Desplazas el apuntador de memoria

	#VUELVE A INTERCAMBIAR LOS APUNTADORES ENTRE LA TORRE 1 CON LA TORRE 2
	add $t1, $zero, $s2 #$t1 apunta a la torre 2
	add $s2, $s1, $zero #El apuntador de la torre 2 ahora apunta a la torre 1
	add $s1, $zero, $t1 #El apuntador de la torre 1 ahora apunta a la torre 2
	
	jr $ra #Regresa a la dirección guardada por $ra
	
exit:
