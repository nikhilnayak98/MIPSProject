#----------------------------------------------------------------------------------

#MATRIX MANIPULATOR:
#matrix operation calculator using MIPS

#----------------------------------------------------------------------------------

.data
jumptable: .word L1 L2 L3 L4 L5
line1:	 .ascii  "ENTER CHOICE:\n"
	 .ascii	 "1.addition\n"
	 .ascii	 "2.subtraction\n"
	 .ascii	 "3.transpose\n"
	 .ascii	 "4.scaling\n"
	 .asciiz "5.exit\n"
line2_1: .asciiz "MATRIX A\n"
line2_2: .asciiz "MATRIX B\n"
line2_3: .asciiz "RESULTANT MATRIX\n"
line2: 	 .asciiz "\nenter the elements\n"
line3:	 .asciiz "\n"
line4: 	 .asciiz "\t"
line5:	 .asciiz "enter the no. of rows:(<5)"
line6:   .asciiz "enter the no. of columns:(<5)"
line7_1: .asciiz "ADDITION\n"
line7_2: .asciiz "SUBTRACTION\n"
line7_3: .asciiz "TRANSPOSE\n"
line7_4: .asciiz "SCALING(scaler multiplication)\n"
line8_1: .asciiz "ERROR:wrong choice"
line8_2: .asciiz "ERROR:size not match"
line9:	 .asciiz "enter the scalar no. to multiply:"

array_A: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
array_B: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

row_A: 	 .word 0
column_A:.word 0
row_B: 	 .word 0
column_B:.word 0

#----------------------------------------------------------------------------------
.text
main:

	la $a0,line1			#prints line1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0			#choice is stored in $t0 

	li $s7,1
	blt $t0,$s7,error_choice	#if(choice<1)
	li $s7,5
	bgt $t0,$s7,error_choice	#if(choice>5)

	add $t1,$t0,-1
	mul $t1,$t1,4		
	la $s2,jumptable
	add $t1,$t1,$s2
	lw $t2,($t1)
	jr $t2

L1:
	la $a0,line2_1
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t8,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t9,$v0		#read the no. of column and store in $s2

	
	la $a3,array_A
	move $a1,$t8
	move $a2,$t9
	jal read_matrix			#read matrix A

	la $a0,line2_2
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $k0,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $k1,$v0		#read the no. of column and store in $s2

	la $a3,array_B
	move $a1,$k0
	move $a2,$k1

	jal read_matrix			#read matrix B

	sw $t8,row_A
	sw $t9,column_A
	sw $k0,row_B
	sw $k1,column_B
	bne $t8,$k0,error_size		#if(row(A)==row(B))
	bne $t9,$k1,error_size		#if(column(A)==column(B))

	la $a0,line7_1
	li $v0,4
	syscall

	la $a0,line2_1
	li $v0,4
	syscall

	la $a3,array_A
	jal display			#diaplay matrix A

	la $a0,line2_2
	li $v0,4
	syscall

	la $a3,array_B
	jal display			#display matrix B

	la $a0,line2_3
	li $v0,4
	syscall
	jal matrix_add			#fuction call to add matrix A and B
	j exit

L2:
	la $a0,line2_1
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall

	li $v0,5
	syscall
	move $t8,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t9,$v0		#read the no. of column and store in $s2

	
	la $a3,array_A
	move $a1,$t8
	move $a2,$t9
	jal read_matrix			#read matrix A

	la $a0,line2_2
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall

	li $v0,5
	syscall
	move $k0,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall

	li $v0,5
	syscall
	move $k1,$v0		#read the no. of column and store in $s2

	la $a3,array_B
	move $a1,$k0
	move $a2,$k1

	jal read_matrix			#read matrix B

	sw $t8,row_A
	sw $t9,column_A
	sw $k0,row_B
	sw $k1,column_B
	bne $t8,$k0,error_size		#if(row(A)==row(B))
	bne $t9,$k1,error_size		#if(column(A)==column(B))

	la $a0,line7_2
	li $v0,4
	syscall

	la $a0,line2_1
	li $v0,4
	syscall

	la $a3,array_A
	jal display			#diaplay matrix A

	la $a0,line2_2
	li $v0,4
	syscall

	la $a3,array_B
	jal display			#display matrix B

	la $a0,line2_3
	li $v0,4
	syscall
	jal matrix_sub			#fuction call to add matrix A and B
	j exit

L3:
	la $a0,line2_1
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall

	li $v0,5
	syscall
	move $t8,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t9,$v0		#read the no. of column and store in $s2

	sw $t8,row_A
	sw $t9,column_A
	
	la $a3,array_A
	move $a1,$t8
	move $a2,$t9
	jal read_matrix			#read matrix A

	la $a0,line7_3
	li $v0,4
	syscall

	la $a0,line2_1
	li $v0,4
	syscall

	la $a3,array_A
	jal display			#diaplay matrix A

	la $a0,line2_3
	li $v0,4
	syscall
	jal matrix_transpose		#fuction call to transpose matrix A
	j exit

L4:
	la $a0,line2_1
	li $v0,4
	syscall

	la $a0,line5
	li $v0,4
	syscall

	li $v0,5
	syscall
	move $t8,$v0 		#read the no. of rows and store in $s1

	la $a0,line6
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t9,$v0		#read the no. of column and store in $s2

	sw $t8,row_A
	sw $t9,column_A
	
	la $a3,array_A
	move $a1,$t8
	move $a2,$t9
	jal read_matrix			#read matrix A

	la $a0,line7_4
	li $v0,4
	syscall

	la $a0,line2_1
	li $v0,4
	syscall

	la $a3,array_A
	jal display			#diaplay matrix A

	jal matrix_scaling		#fuction call to scalar multiplication with matrix A
	j exit

L5:
	j exit

error_size:
	la $a0,line8_2
	li $v0,4
	syscall
	j exit

error_choice:
	la $a0,line8_1
	li $v0,4
	syscall
	j exit

exit:
	li $v0,10
	syscall

#------------------------------------------------------------------------
#		function to read a matrix
#------------------------------------------------------------------------
.globl read_matrix
.ent read_matrix
read_matrix:
	move $s0,$a3
	move $s1,$a1
	move $s2,$a2


	la $a0,line2
	li $v0,4
	syscall
	li $t2,0		#i=0

loop_read1:
	beq $t2,$s1,end_read
	li $t3,0		#j=0
loop_read2:
	beq $t3,$s2,increment_read
	li $v0,5
	syscall
	move $t7,$v0
	sw $t7,($s0)
	add $s0,$s0,4
	addi $t3,$t3,1
	j loop_read2
increment_read:
	addi $t2,$t2,1
	j loop_read1

end_read:
	jr $ra
.end read_matrix


#------------------------------------------------------------------------
#		function to display a matrix
#------------------------------------------------------------------------

.globl display
.ent display
display:
	move $s0,$a3		#base address of matrix
	li $t2,0		#i=0
	lw $s1,row_A
	lw $s2,column_A

loop_display1:
	beq $t2,$s1,end_display
	li $t3,0		#j=0
loop_display2:
	beq $t3,$s2,increment_display
	lw $t7,($s0)
	move $a0,$t7
	li $v0,1
	syscall
	add $s0,$s0,4
	la $a0,line4
	li $v0,4
	syscall
	addi $t3,$t3,1
	j loop_display2
increment_display:
	la $a0,line3
	li $v0,4
	syscall
	addi $t2,$t2,1
	j loop_display1

end_display:
	jr $ra
.end display

#------------------------------------------------------------------------
#		function to add 2 matrix
#------------------------------------------------------------------------

.globl matrix_add
.ent matrix_add
matrix_add:
	la $s4,array_A
	la $s5,array_B
	lw $s1,row_A
	lw $s2,column_A

	li $t2,0
loop_add1:
	beq $t2,$s1,end_add
	li $t3,0
loop_add2:
	beq $t3,$s2,increment_add
	mul $t4,$t2,$s2
	add $t4,$t4,$t3
	mul $t4,$t4,4
	add $t5,$s4,$t4
	add $t6,$s5,$t4
	lw $t0,($t5)
	lw $t1,($t6)
	add $a0,$t0,$t1
	li $v0,1
	syscall
	la $a0,line4
	li $v0,4
	syscall
	addi $t3,$t3,1
	j loop_add2
increment_add:
	la $a0,line3
	li $v0,4
	syscall
	addi $t2,$t2,1
	j loop_add1

end_add:
	jr $ra
.end matrix_add

#------------------------------------------------------------------------
#		function to sub 2 matrix
#------------------------------------------------------------------------

.globl matrix_sub
.ent matrix_sub
matrix_sub:
	la $s4,array_A
	la $s5,array_B
	lw $s1,row_A
	lw $s2,column_A

	li $t2,0
loop_sub1:
	beq $t2,$s1,end_sub
	li $t3,0
loop_sub2:
	beq $t3,$s2,increment_sub
	mul $t4,$t2,$s2
	add $t4,$t4,$t3
	mul $t4,$t4,4
	add $t5,$s4,$t4
	add $t6,$s5,$t4
	lw $t0,($t5)
	lw $t1,($t6)
	sub $a0,$t0,$t1
	li $v0,1
	syscall
	la $a0,line4
	li $v0,4
	syscall
	addi $t3,$t3,1
	j loop_sub2
increment_sub:
	la $a0,line3
	li $v0,4
	syscall
	addi $t2,$t2,1
	j loop_sub1

end_sub:
	jr $ra
.end matrix_sub

#------------------------------------------------------------------------
#		function to transpose a matrix
#------------------------------------------------------------------------

.globl matrix_transpose
.ent matrix_transpose
matrix_transpose:
	la $s4,array_A
	lw $s1,row_A
	lw $s2,column_A

	li $t2,0
loop_transpose1:
	beq $t2,$s2,end_transpose
	li $t3,0
loop_transpose2:
	beq $t3,$s1,increment_transpose
	mul $t4,$t3,$s2
	add $t4,$t4,$t2
	mul $t4,$t4,4
	add $t4,$s4,$t4
	lw $a0,($t4)
	li $v0,1
	syscall
	la $a0,line4
	li $v0,4
	syscall
	addi $t3,$t3,1
	j loop_transpose2
increment_transpose:
	la $a0,line3
	li $v0,4
	syscall
	addi $t2,$t2,1
	j loop_transpose1

end_transpose:
	jr $ra
.end matrix_transpose

#------------------------------------------------------------------------
#		function to scalar multiplication
#------------------------------------------------------------------------

.globl matrix_scaling
.ent matrix_scaling
matrix_scaling:
	la $s4,array_A

	la $a0,line9
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t0,$v0			#scalar multiple is stored in $t2

	la $a0,line2_3
	li $v0,4
	syscall

	li $t2,0
	lw $s1,row_A
	lw $s2,column_A

loop_scaling1:
	beq $t2,$s1,end_scaling
	li $t3,0
loop_scaling2:
	beq $t3,$s2,increment_scaling
	mul $t4,$t2,$s2
	add $t4,$t4,$t3
	mul $t4,$t4,4
	add $t4,$s4,$t4
	lw $a0,($t4)
	mul $a0,$a0,$t0
	li $v0,1
	syscall
	la $a0,line4
	li $v0,4
	syscall
	addi $t3,$t3,1
	j loop_scaling2
increment_scaling:
	la $a0,line3
	li $v0,4
	syscall

	addi $t2,$t2,1
	j loop_scaling1

end_scaling:
	jr $ra
.end matrix_scaling
