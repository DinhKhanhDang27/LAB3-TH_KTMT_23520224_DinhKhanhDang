.data
n:      .word 0           
mang:    .space 400       
tb_max:    .asciiz "\nGia tri lon nhat trong mang: "
tb_min:    .asciiz "\nGia tri nho nhat trong mang: "
tb_tong:    .asciiz "\nTong tat ca cac phan tu trong mang: "
tb_chi_so:  .asciiz "\nNhap vao chi so cua phan tu can lay gia tri: "
tb_khong_hop_le:.asciiz "Chi so khong hop le.\n"
tb_nhap_n:  .asciiz "Nhap vao so phan tu cua mang: "
tb_nhap_mang: .asciiz "Nhap cac phan tu cua mang:\n"

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
    la $t2, mang         

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
    la $t2, mang        
    lw $t3, 0($t2)      
    move $t4, $t3       
    move $t5, $t3       
    li $t6, 0           
    li $t1, 0           

tinhToan:
    bge $t1, $t0, ket_thuc_tinh  

    lw $t3, 0($t2)      

    bgt $t3, $t4, cap_nhat_max
    j kiem_tra_min
cap_nhat_max:
    move $t4, $t3       
kiem_tra_min:
    blt $t3, $t5, cap_nhat_min
    j cap_nhat_tong
cap_nhat_min:
    move $t5, $t3       

cap_nhat_tong:
    add $t6, $t6, $t3   
    addi $t2, $t2, 4    
    addi $t1, $t1, 1    
    j tinhToan      

ket_thuc_tinh:
    li $v0, 4
    la $a0, tb_max
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, tb_min
    syscall
    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, tb_tong
    syscall
    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, tb_chi_so
    syscall

    li $v0, 5
    syscall
    move $t7, $v0      

    lw $t0, n           
    blt $t7, $zero, khong_hop_le
    bge $t7, $t0, khong_hop_le

    la $t2, mang         
    sll $t8, $t7, 2     
    add $t2, $t2, $t8   
    lw $t9, 0($t2)      

    li $v0, 1
    move $a0, $t9
    syscall
    j ket_thuc

khong_hop_le:
    li $v0, 4
    la $a0, tb_khong_hop_le
    syscall

ket_thuc:
    li $v0, 10
    syscall
