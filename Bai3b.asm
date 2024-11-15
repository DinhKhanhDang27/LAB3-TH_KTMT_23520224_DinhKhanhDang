.data
n:      .word 0           
array1: .space 400       
tb_khong_hop_le: .asciiz "Chi so khong hop le.\n"
tb_nhap_n:      .asciiz "Nhap vao so phan tu cua mang: "
tb_nhap_mang:   .asciiz "Nhap cac phan tu cua mang:\n"
tb_kq:          .asciiz "Mang sau khi thay doi: "

.text
.globl main

main:
    li $v0, 4
    la $a0, tb_nhap_n
    syscall

    li $v0, 5
    syscall
    sw $v0, n           

    li $v0, 4
    la $a0, tb_nhap_mang
    syscall

    lw $t0, n           
    li $t1, 0           
    la $t2, array1      

nhap_input:
    bge $t1, $t0, ket_thuc_nhap  
    li $v0, 5           
    syscall
    sw $v0, 0($t2)      
    addi $t2, $t2, 4    
    addi $t1, $t1, 1    
    j nhap_input        

ket_thuc_nhap:
    lw $t0, n           
    la $t2, array1      
    li $t1, 0           

vong_for_1:
    bge $t1, $t0, in_mang    
    li $t3, 0                
    la $t4, array1           

vong_for_2:
    bge $t3, $t0, tang_i  
    blt $t1, $t3, gan_i   
    sw $t3, 0($t4)        
    j tang_j

gan_i:
    sw $t1, 0($t4)        

tang_j:
    addi $t4, $t4, 4      
    addi $t3, $t3, 1      
    j vong_for_2

tang_i:
    addi $t1, $t1, 1      
    j vong_for_1

in_mang:
    li $v0, 4
    la $a0, tb_kq
    syscall

    lw $t0, n         
    li $t1, 0 
    la $t2, array1    

vong_in:
    bge $t1, $t0, end 
    lw $a0, 0($t2)   
    li $v0, 1        
    syscall
    li $a0, 32       
    li $v0, 11
    syscall
    addi $t2, $t2, 4  
    addi $t1, $t1, 1  
    j vong_in

end:
    li $a0, 10       
    li $v0, 11
    syscall
    li $v0, 10       
    syscall
