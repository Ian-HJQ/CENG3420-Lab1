.eqv	PRINT_INT	1	# System call: print_int
.eqv	PRINT_STRING	4	# System call: print_string
.eqv	EXIT		10	# Sysstem call: exit

.globl _start

.data
var1: .word 15
var2: .word 19
newline: .string "\n"
addr_var1: .string "Address of var1: "
addr_var2: .string "Address of var2: "
msg1: .string "var1: "
msg2: .string "var2: "

.text
_start:
	li a7, PRINT_STRING
	la a0, addr_var1
	ecall
	
	la a0, var1
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	li a7, PRINT_STRING
	la a0, addr_var2
	ecall
	
	la a0, var2
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	
	lw s1, var1
	lw s2, var2
	
	addi s1, s1, 1
	addi t0, zero, 4
	mul s2, s2, t0
	
	sw s1, var1, t1
	sw s2, var2, t2
	
	li a7, PRINT_STRING
	la a0, msg1
	ecall
	
	lw a0, var1
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	li a7, PRINT_STRING
	la a0, msg2
	ecall
	
	lw a0, var2
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	lw t1, var1
	lw t2, var2
	sw t2, var1, t3
	sw t1, var2, t4
	
	li a7, PRINT_STRING
	la a0, msg1
	ecall
	
	lw a0, var1
	li a7, 1
	ecall
	
	la a0, newline
	li a7, 4
	ecall
	
	li a7, PRINT_STRING
	la a0, msg2
	ecall
	
	lw a0, var2
	li a7, 1
	ecall
	
	
