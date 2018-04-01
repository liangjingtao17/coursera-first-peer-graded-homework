	.data
msg_success:  
	.asciiz "Success! Location: "
msg_fail:  
	.asciiz "Fail!"
string:
	.space 100


	.text
	.globl main
main:
	li $v0, 8 #input a string
	li $a1, 100
	la $a0, string
	syscall

main_loop:
	li $v0, 12
	syscall
	
    	sub $t0, $v0, 63 #compare to the '?'
	beqz $t0, end
	
	move $t0, $v0 #save the $v0
	li $a0, 58
	li $v0, 11
	syscall #output the ':'
	move $v0, $t0 #recover the $v0
	
	
	li $t0, 0
rep:	
	lb $t1, string($t0)
	sub $t1, $t1, $v0
	beqz $t1 success
	
	add $t0, $t0, 1
	sub $t1, $a1, $t0
	beqz $t1 fail
	j rep
success:
	la $a0, msg_success
	li $v0, 4
	syscall
	
	add $t0, $t0, 1
	move $a0, $t0
	li $v0, 1
	syscall
	j newline
fail:
	la $a0, msg_fail
	li $v0, 4
	syscall
	
	j newline
newline:
	li $a0, 10
	li $v0, 11
	syscall
	
	
	j main_loop
end:
	 li $v0, 10 #exit the task
         syscall
