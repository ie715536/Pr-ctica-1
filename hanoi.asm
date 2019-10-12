#Bonifacio Benavides Yadira Vanessa 714415
#Rodríguez Pérez Urik Paul 715536

.text
	addi $s0, $zero, 8 #save the value N
	add $t0, $zero, $s0 #iterator on N (i = N)
	addi $s1, $s1, 0x10010000 #tower 1
	addi $s2, $s2, 0x10010020 #tower 2
	addi $s3, $s3, 0x10010040 #tower 3
	
Do:
	#FILL THE FIRST TOWER
	sw $t0, ($s1) #enter the value of i at the indicated position 
	addi $s1, $s1, 4 #move the tower pointer
	addi $t0, $t0, -1 #i = i - 1
	bne $t0, $zero, Do #i != 0? Do : out
	
	jal hanoi #call hanoi function 
	j exit #the code ends  
	
hanoi:
	bne $s0, 1, else #N != 1? else : out
	
	#if N == 1
	addi $s1, $s1, -4 #decreasing the value of the tower s1 pointer
	lw $t2, ($s1) #save the value on t2
	sw $zero, ($s1) #save 0 
	sw $t2, ($s3) #save the value of tower s1 on tower s3
	addi $s3, $s3, 4 #move de tower s3 pointer 
	jr $ra	#go back to where the function was called 
	
else:
	#(N - 1) TOWER 1 TOWER 3 TOWER 2	
	addi $sp, $sp, -8 #decreasing the stack pointer 
	sw $ra, 0($sp) #storing the return address
	sw $s0, 4($sp) #storing N
	
	addi $s0, $s0, -1 #N = N - 1
	
	#EXCHANGE THE POINTERS OF TOWER 2 AND 3
	add $t1, $zero, $s2 #t1 point to tower 2
	add $s2, $s3, $zero #the tower 2 pointer point to tower 3
	add $s3, $zero, $t1 #now the tower 3 pointer point to tower 2
	
	jal  hanoi #call hanoi function 
	
	lw $ra, 0($sp) #loading values from stack 
	lw $s0, 4($sp) #loading values from stack 
	addi $sp, $sp, 8 #increasing stack pointer
	
	#EXCHANGE ONE MORE TIME THE POINTERS OF TOWER 2 AND 3
	add $t1, $zero, $s3 #t1 point to tower 3
	add $s3, $s2, $zero #the tower 3 pointer point to tower 2
	add $s2, $zero, $t1 #now the tower 2 pointer point to tower 3
	
	addi $s1, $s1, -4 #decreasing the value of the tower s1 pointer
	lw $t2, ($s1) #save the value on t2
	sw $zero, ($s1) #save 0
	sw $t2, ($s3) #save the value of tower s1 on tower s3
	addi $s3, $s3, 4 #move de tower s3 pointer 
	
	#(N - 1) TOWER 2 TOWER 1 TOWER 3
	addi $sp, $sp, -8 #decreasing the stack pointer 
	sw $ra, 0($sp) #storing the return address
	sw $s0, 4($sp) #storing N
	
	addi $s0, $s0, -1 #N = N - 1
	
	#EXCHANGE THE POINTERS OF TOWER 1 AND 2
	add $t1, $zero, $s1 #t1 point to tower 1
	add $s1, $s2, $zero #the tower 1 pointer point to tower 2
	add $s2, $zero, $t1 #now the tower 2 pointer point to tower 1
	
	jal  hanoi #call hanoi function 
	
	lw $ra, 0($sp) #loading values from stack 
	lw $s0, 4($sp) #loading values from stack 
	addi $sp, $sp, 8 #increasing stack pointer

	#EXCHANGE ONE MORE TIME THE POINTERS OF TOWER 1 AND 2
	add $t1, $zero, $s2 #t1 point to tower 2
	add $s2, $s1, $zero #the tower 2 pointer point to tower 1
	add $s1, $zero, $t1 #now the tower 1 pointer point to tower 2
	
	jr $ra #return to address ra
	
exit:
