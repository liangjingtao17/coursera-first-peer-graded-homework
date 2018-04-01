	.data
lat:	
	.asciiz
	"lpha ","ravo ","hina ","elta ","cho ","oxtrot ","olf ","otel ","ndia ","uliet ","ilo ","ima ","ary ","ovember ","scar ","aper ","uebec ","esearch ","ierra ","ango ","niform ","ictor ","hisky ","-ray ","ankee ","ulu "
lat_shf:
	.word
	0,6,12,18,24,29,37,42,48,54,61,66,71,76,85,91,97,104,113,120,126,134,141,148,154,161

num:
	.asciiz
	"zero ", "First ", "Second ", "Third ", "Fourth ","Fifth ", "Sixth ", "Seventh ","Eighth ","Ninth "
num_shf:
	.word
    0,6,13,21,28,36,43,50,59,67

	.text
	.globl main
main:
	li $v0, 12 #input a character
    	syscall
	sub $t0, $v0, 63 #compare to the '?'
	beqz $t0, end
	
	move $t1, $v0 #save the $v0
	li $a0, 58
	li $v0, 11
	syscall #output the ':'
	move $v0, $t1 #recover the $v0
	
	li $t1, 47
	slt $t0, $t1, $v0 #compare to the '0'-1
	beqz $t0, output_star
	
	li $t1, 57
	slt $t0, $t1, $v0 #compare to the '9'
	beqz $t0, output_num
	
	li $t1, 64
	slt $t0, $t1, $v0 #'A' - 1
	beqz $t0, output_star
	
	li $t1, 90
	slt $t0, $t1, $v0 #'Z'
	beqz $t0, output_lat_big
	
	li $t1, 96
	slt $t0, $t1, $v0 #'a' - 1
	beqz $t0, output_star
	
	li $t1, 122
	slt $t0, $t1, $v0 #'z'
	beqz $t0, output_lat_small
	j output_star
output_num:
	sub $t0, $v0, 48
	sll $t0, $t0, 2
	lw $t0, num_shf($t0)
	
	la $t1, num
	add $t0, $t0, $t1 #find the address of num string
	
	move $a0, $t0
	li $v0, 4
	syscall
	j main_newline
output_lat_big:
	move $a0, $v0
	li $v0, 11
	syscall
	sub $t0, $a0, 65 
output_lat_big_main:
	sll $t0, $t0, 2
	lw $t0, lat_shf($t0)
	
	la $t1, lat
	add $t0, $t0, $t1	#find the address of latin string
	move $a0, $t0
	li $v0, 4
	syscall
	j main_newline
output_lat_small:
	move $a0, $v0
	li $v0, 11
	syscall
	sub $t0, $a0, 97
	j output_lat_big_main
output_star:
	li $v0, 11
	li $a0, 42
	syscall
	j main_newline
main_newline:
	li $a0, 10
	li $v0, 11
	syscall
	j main
end:
	 li $v0, 10 #exit the task
         syscall
