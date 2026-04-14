.data
    msgM:   .string "Nhap M: "
    msgN:   .string "Nhap N: "
    msgR:   .string "UCLN la: "
    msgErr: .string "Loi: Phai nhap so > 0!"

.text
.globl main
main:
    # 1. Nhập M (t0)
    li a7, 4
    la a0, msgM
    ecall
    li a7, 5
    ecall
    mv t0, a0
    blez t0, bao_loi      # NGOẠI LỆ: Nếu M <= 0 thì nhảy ra báo lỗi

    # 2. Nhập N (t1)
    li a7, 4
    la a0, msgN
    ecall
    li a7, 5
    ecall
    mv t1, a0
    blez t1, bao_loi      # NGOẠI LỆ: Nếu N <= 0 thì nhảy ra báo lỗi

    # 3. Vòng lặp tìm UCLN (Euclid)
lap_tim:
    beqz t1, in_ket_qua
    rem t2, t0, t1
    mv t0, t1
    mv t1, t2
    j lap_tim

    # 4. Kết thúc
in_ket_qua:
    li a7, 4
    la a0, msgR
    ecall
    li a7, 1
    mv a0, t0
    ecall
    j thoat

bao_loi:
    li a7, 4
    la a0, msgErr
    ecall

thoat:
    li a7, 10
    ecall