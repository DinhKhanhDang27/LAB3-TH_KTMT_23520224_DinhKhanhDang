.data
array1: .word 5, 6, 7, 8, 1, 2, 3, 9, 10, 4
size1: .word 10
array2: .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
size2: .word 16
array3: .space 8
size3: .word 8

nhap_mang: .asciiz "Nhap mang (1 hoac 2): "
nhap_vitri: .asciiz "Nhap vi tri: "
in_loi: .asciiz "Mang hoac vi tri khong hop le.\n"
xuong_dong: .asciiz "\n"

.text
.globl main
main:
    la $t0, array1
    lw $t1, size1
    li $t2, 0

in_mang1:
    beq $t2, $t1, xuong_dong_mang1
    lw $a0, 0($t0)
    li $v0, 1
    syscall
    li $a0, 32
    li $v0, 11
    syscall
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j in_mang1

xuong_dong_mang1:
    li $a0, 10
    li $v0, 11
    syscall

    la $t0, array2
    lw $t1, size2
    li $t2, 0

in_mang2:
    beq $t2, $t1, xuong_dong_mang2
    lb $a0, 0($t0)
    li $v0, 1
    syscall
    li $a0, 32
    li $v0, 11
    syscall
    addi $t0, $t0, 1
    addi $t2, $t2, 1
    j in_mang2

xuong_dong_mang2:
    li $a0, 10
    li $v0, 11
    syscall

    la $t0, array2
    la $t1, array3
    lw $t2, size2
    li $t3, 0

tinh_mang3:
    lw $t4, size3
    beq $t3, $t4, in_mang3
    lb $a0, 0($t0)
    sub $t5, $t2, $t3
    add $t5, $t5, -1
    la $t6, array2
    add $t5, $t6, $t5
    lb $a1, 0($t5)
    add $a0, $a0, $a1
    sb $a0, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    addi $t3, $t3, 1
    j tinh_mang3

in_mang3:
    la $t0, array3
    lw $t1, size3
    li $t2, 0

in_ra_mang3:
    beq $t2, $t1, xuong_dong_mang3
    lb $a0, 0($t0)
    li $v0, 1
    syscall
    li $a0, 32
    li $v0, 11
    syscall
    addi $t0, $t0, 1
    addi $t2, $t2, 1
    j in_ra_mang3

xuong_dong_mang3:
    li $a0, 10
    li $v0, 11
    syscall


    # Yêu cầu nhập mảng và nhập vị trí 
yeu_cau_nhap:
    li $v0, 4
    la $a0, nhap_mang
    syscall
    li $v0, 5
    syscall
    move $t7, $v0
    li $v0, 4
    la $a0, nhap_vitri
    syscall
    li $v0, 5
    syscall
    move $t8, $v0
    li $t9, 1
    beq $t7, $t9, kiem_tra_vitri_mang1
    li $t9, 2
    beq $t7, $t9, kiem_tra_vitri_mang2
    la $a0, in_loi
    li $v0, 4
    syscall
    j ket_thuc

kiem_tra_vitri_mang1:
    lw $t1, size1
    bge $t8, $t1, in_loi_nhap
    j lay_phan_tu_mang1

kiem_tra_vitri_mang2:
    lw $t1, size2
    bge $t8, $t1, in_loi_nhap
    j lay_phan_tu_mang2

lay_phan_tu_mang1:
    la $t0, array1
    sll $t8, $t8, 2
    add $t0, $t0, $t8
    lw $a0, 0($t0)
    li $v0, 1
    syscall
    j ket_thuc

lay_phan_tu_mang2:
    la $t0, array2
    add $t0, $t0, $t8
    lb $a0, 0($t0)
    li $v0, 1
    syscall
    j ket_thuc

in_loi_nhap:
    la $a0, in_loi
    li $v0, 4
    syscall
    j ket_thuc

ket_thuc:
    li $v0, 10
    syscall
