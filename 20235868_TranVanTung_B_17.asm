.data
    msgN:   .string "Nhap n: "
    msgVal: .string "Nhap so: "
    msgRes: .string "Ket qua la: "
    msgErr: .string "Loi / Khong co so thoa man!"
    arr:    .space 400

.text
.globl main
main:
    # 1. Nhập N
    li a7, 4
    la a0, msgN
    ecall
    li a7, 5
    ecall
    blez a0, bao_loi      # NGOẠI LỆ 1: Nếu n <= 0 thì báo lỗi
    mv s0, a0

    # 2. Nhập mảng
    li t0, 0
    la s1, arr
nhap_mang:
    bge t0, s0, tim_min_odd
    li a7, 4
    la a0, msgVal
    ecall
    li a7, 5
    ecall
    slli t1, t0, 2
    add t2, s1, t1
    sw a0, 0(t2)
    addi t0, t0, 1
    j nhap_mang

    # 3. Tìm số lẻ nhỏ nhất (min_odd -> s2)
tim_min_odd:
    li s2, 9999999
    li t0, 0
duyet_1:
    bge t0, s0, kiem_tra_mang
    slli t1, t0, 2
    add t2, s1, t1
    lw t3, 0(t2)
    
    andi t4, t3, 1
    beqz t4, bo_qua_1
    bge t3, s2, bo_qua_1
    mv s2, t3
bo_qua_1:
    addi t0, t0, 1
    j duyet_1

    # KIỂM TRA: Nếu mảng không có số lẻ nào (s2 vẫn là 9999999) -> Báo lỗi
kiem_tra_mang:
    li t5, 9999999
    beq s2, t5, bao_loi

    # 4. Tìm số chẵn lớn nhất < min_odd (max_even -> s3)
tim_max_even:
    li s3, -9999999
    li s4, 0              # Cờ (Flag) s4 = 0 (chưa tìm thấy)
    li t0, 0
duyet_2:
    bge t0, s0, in_ket_qua
    slli t1, t0, 2
    add t2, s1, t1
    lw t3, 0(t2)
    
    andi t4, t3, 1
    bnez t4, bo_qua_2
    bge t3, s2, bo_qua_2
    ble t3, s3, bo_qua_2
    mv s3, t3
    li s4, 1              # Đánh dấu s4 = 1 (Đã tìm thấy ít nhất 1 số)
bo_qua_2:
    addi t0, t0, 1
    j duyet_2

    # 5. Kết thúc
in_ket_qua:
    beqz s4, bao_loi      # NGOẠI LỆ 2: Quét xong mảng mà cờ s4 vẫn = 0 -> Báo lỗi
    li a7, 4
    la a0, msgRes
    ecall
    li a7, 1
    mv a0, s3
    ecall
    j thoat

bao_loi:
    li a7, 4
    la a0, msgErr
    ecall

thoat:
    li a7, 10
    ecall