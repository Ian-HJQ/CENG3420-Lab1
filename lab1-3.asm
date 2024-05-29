.eqv	PRINT_INT	1	# System call: print_int
.eqv	PRINT_STRING	4	# System call: print_string
.eqv	EXIT		10	# Sysstem call: exit

.globl _start

.data
arr: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
newline: .string "\n"
space: .string " "
msg1: .string "Array before quicksort:\n"
msg2: .string "Array after quicksort:\n"

.text
j _start 	#jump to the main code

print_arr:	#function for printing array
addi sp, sp, -4
sw ra, 0(sp)
la s2, arr
li s3, 0
loop_arr:
li a7, PRINT_INT
lw a0, (s2)
ecall
li a7, PRINT_STRING
la a0, space
ecall
addi s2, s2, 4
addi s3, s3, 1
addi t3, a3, 1
slti t1 ,s3 ,10
beq t1, zero, end_loop_arr
j loop_arr
end_loop_arr:
lw ra, 0(sp)
addi sp, sp, 4
jr ra

#################################################

sort:
bge a2, a3, sort_return #return if lo>=hi
addi sp, sp, -16
sw ra, 0(sp)

add s9, a2, zero #load lo to s9
add s10, a3, zero #load hi to s10

jal part

add s11, a4, zero #load pivot to s11

sw s9, 4(sp) #s9 = lo
sw s10, 8(sp) #s10 = hi
sw s11, 12(sp)#s11 = pivot

#quicksort left
add a2, s9, zero#lo = lo
addi a3, s11, -1 #hi = pivot-1
jal sort

#quicksort right
addi a2, s11, 1 #lo = pivot + 1
add a3, s10, zero #hi = hi
jal sort

lw ra, 0(sp)
lw s9, 4(sp)
lw s10, 8(sp)
lw s11, 12(sp)
addi sp, sp, 16
sort_return:
jr ra

#################################################

part:
addi sp, sp, -16
sw ra, 0(sp)
sw s9, 4(sp)
sw s10, 8(sp)
sw s11, 12(sp)

slli s7, a3, 2 #align word
add s7, a1, s7 #s7 = addr of arr[hi] (pivot)
lw t6, 0(s7)	#t6 = arr[hi] pivot

addi t2, a2, -1	#t2 = i = lo-1
add t3, a2, zero #t3 = j = lo

loop1:
slli s4, t3 ,2
add s4, a1, s4  #s4 = addr of arr[j]
lw t4, 0(s4) 	#t4 = arr[j]
if:
bge t4, t6, endif #if arr[j] < pivot, swap
addi t2, t2, 1 # i = i+1
slli s5, t2, 2
add s5, a1, s5 #s5 = addr of arr[i]
lw t5, 0(s5)#t5 = arr[i]
sw t5, 0(s4)
sw t4, 0(s5)
endif:
addi t3, t3, 1 #j++
beq t3, a3, part_return #return if j reaches hi
j loop1

part_return:		
addi a4, t2, 1 # return a4 = pivot

slli s9, a4, 2
add s9, a1, s9 #s9 = arr[i+1]
slli s10, a3, 2
add s10, a1, s10 #s10 = arr[hi]

#swap
lw t5, 0(s9)
lw t6, 0(s10)
sw t5, 0(s10)
sw t6, 0(s9)

lw ra, 0(sp)
lw s9, 4(sp)
lw s10, 8(sp)
lw s11, 12(sp)
addi sp, sp, 16
jr ra

#################################################

_start:
li a7, PRINT_STRING
la a0, msg1
ecall
jal print_arr
la a1, arr 	#a1 = addr. of arr
li a2, 0	#a2 = lo
li a3, 9	#a3 = hi
jal sort
li a7, PRINT_STRING
la a0, newline
ecall
la a0, msg2
ecall
jal print_arr

li a7, EXIT
ecall
