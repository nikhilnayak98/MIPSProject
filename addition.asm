.data
dimension: .asciiz "Enter matrix dimension: "

enter_first: .asciiz "Enter first matrix:\n"
enter_second: .asciiz "Enter second matrix:\n"

show_first: .asciiz "First entered matrix:\n"
show_second: .asciiz "Second entered matrix:\n"

show_result: .asciiz "Result of matrix addition:\n"

space: .asciiz " "
newline: .asciiz "\n"


.text
.globl main
main:

# Prompt and take dimension input from user
	li $v0, 4
	la $a0, dimension
	syscall

	li $v0, 5
	syscall
	addu $s0, $zero, $v0		# $s0 == N

# Size of the 2D is array stored in $a0 for next three steps
	mul $a0, $s0, $s0
	mul $a0, $a0, 4

# Declaring matrix A in $s1
	li $v0, 9
	syscall
	addu $s1, $zero, $v0

# Declaring matrix B in $s2
	li $v0, 9
	syscall
	addu $s2, $zero, $v0

# Declaring resultant matrix in $s3
	li $v0, 9
	syscall
	addu $s3, $zero, $v0

# $s4 = N^2
	mul $s4, $s0, $s0

# Take input in matrix A
	li $v0, 4
	la $a0, enter_first
	syscall

	xor $t1, $t1, $t1		# loop variable
	move $t2, $s1	        # pointer

loop1:

	slt $t0, $t1, $s4
	beq $t0, $zero, exit1

	li $v0, 5
	syscall
	sw $v0, 0($t2)

	addiu $t1, $t1, 1
	addiu $t2, $t2, 4

	j loop1

exit1:

# Take input in matrix B
	li $v0, 4
	la $a0, enter_second
	syscall

	xor $t1, $t1, $t1		# loop variable
	move $t2, $s2			# pointer

loop2:

	slt $t0, $t1, $s4
	beq $t0, $zero, exit2

	li $v0, 5
	syscall
	sw $v0, 0($t2)

	addiu $t1, $t1, 1
	addiu $t2, $t2, 4

	j loop2

exit2:

    xor $t1, $t1, $t1

    L1:
        slt $t0, $t1, $s0
        beq $t0, $zero, endL1
        xor $t2, $t2, $t2

        L2:
            slt $t0, $t2, $s0
            beq $t0, $zero, endL2

            mul $t3, $t1, $s0
            addu $t3, $t3, $t2
            sll $t3, $t3, 2
            addu $t3, $t3, $s3

            mul $t4, $t1, $s0
            addu $t4, $t4, $t2
            sll $t4, $t4, 2
            addu $t4, $t4, $s1

            mul $t5, $t1, $s0
            addu $t5, $t5, $t2
            sll $t5, $t5, 2
            addu $t5, $t5, $s2

            lw $t6, 0($t4)
            lw $t7, 0($t5)

            add $t8, $t6, $t7

            sw $t8, 0($t3)

            addiu $t2, $t2, 1

            j L2

    endL2:
        addiu $t1, $t1, 1
        j L1

endL1:

# Print matrix A
	li $v0, 4
	la $a0, show_first
	syscall

	move $a1, $s1
	jal printMatrix

# Print matrix B
	li $v0, 4
	la $a0, show_second
	syscall

	move $a1, $s2
	jal printMatrix

# Print resultant  addition matrix
	li $v0, 4
	la $a0, show_result
	syscall

	move $a1, $s3
	jal printMatrix

# Terminate program
EXIT:
	li $v0,10
	syscall

# Procedure for printing matrices

printMatrix:

	xor $t1, $t1, $t1				# loop 1 variable

	print1:
		slt $t0, $t1, $s0
		beq $t0, $zero, end_print1
		addiu $t1, $t1, 1

		xor $t2, $t2, $t2			# loop 2 variable

		print2:
			slt $t0, $t2, $s0
			beq $t0, $zero, end_print2
			addiu $t2, $t2, 1

			li $v0, 1
			lw $a0, 0($a1)
			syscall

			addiu $a1, $a1, 4		# increment pointer

			li $v0, 4
			la $a0, space
			syscall

			j print2

        end_print2:

            li $v0, 4
            la $a0, newline
            syscall

            j print1
    end_print1:
            jr $ra
