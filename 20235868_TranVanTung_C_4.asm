.data
    str: .space 256
    msg: .string "Nhap chuoi: "
    msgErr: .string "Chuoi rong hoac khong hop le!"

.text
.globl main
main:
    # 1. Nhập chuỗi
    li a7, 4
    la a0, msg
    ecall
    li a7, 8
    la a0, str
    li a1, 256
    ecall

    # 2. Khởi tạo
    la t0, str
    li t1, 0            # Chiều dài từ hiện tại
    li t2, 0            # Chiều dài MAX
    la t3, str          # Vị trí bắt đầu từ MAX

    # 3. Duyệt chuỗi
duyet_chuoi:
    lb t4, 0(t0)
    beqz t4, in_tu_max
    
    li t5, 32           # Space
    beq t4, t5, het_mot_tu
    li t5, 10           # \n
    beq t4, t5, het_mot_tu

    addi t1, t1, 1      # Chữ cái bình thường -> tăng độ dài
    j tiep_tuc

het_mot_tu:
    ble t1, t2, reset_dem
    mv t2, t1           # Cập nhật MAX
    sub t3, t0, t1      # Lưu vị trí bắt đầu

reset_dem:
    li t1, 0            # Reset đếm

tiep_tuc:
    addi t0, t0, 1
    j duyet_chuoi

    # 4. Kết thúc
in_tu_max:
    beqz t2, bao_loi    # NGOẠI LỆ: Nếu duyệt xong mà MAX vẫn = 0 -> Chuỗi rỗng -> Báo lỗi

    mv t0, t3           
    mv t1, t2           
lap_in_tu:
    beqz t1, thoat      
    lb a0, 0(t0)        
    li a7, 11           
    ecall
    addi t0, t0, 1      
    addi t1, t1, -1     
    j lap_in_tu

bao_loi:
    li a7, 4
    la a0, msgErr
    ecall

thoat:
    li a7, 10
    ecall