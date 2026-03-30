# Bài tập: Thuật toán Sắp xếp chèn (Insertion Sort)
# -----------------------------------
# Mapping thanh ghi:
# a0: địa chỉ đầu mảng (base)
# a1: n (số phần tử)
# t0: i (chỉ số phần tử đang xét - bắt đầu từ 1)
# t1: j (chỉ số dùng để duyệt ngược về trước: j = i - 1)
# t2: key (giá trị của phần tử arr[i] đang cần tìm chỗ chèn)
# -----------------------------------

.data
    arr:    .word 15, 5, 24, 8, 1, 3, 12   # Mảng test mới
    n:      .word 7

.text
.globl main
main:
    la      a0, arr
    lw      a1, n
    
    li      t0, 1           # i = 1 (Phần tử đầu tiên arr[0] coi như đã sort)

outer_loop:
    bge     t0, a1, done    # Nếu i >= n thì xong

    # Lấy key = arr[i]
    slli    t3, t0, 2       
    add     t3, a0, t3      
    lw      t2, 0(t3)       # t2 = key

    addi    t1, t0, -1      # j = i - 1

inner_loop:
    blt     t1, zero, insert # Nếu j < 0 thì dừng để chèn key
    
    # Lấy arr[j] để so sánh với key
    slli    t4, t1, 2
    add     t4, a0, t4
    lw      t5, 0(t4)       # t5 = arr[j]

    ble     t5, t2, insert  # Nếu arr[j] <= key thì dừng (đã tìm thấy chỗ)

    # Nếu arr[j] > key: Đẩy arr[j] sang phải (vào vị trí j+1)
    sw      t5, 4(t4)       # arr[j+1] = arr[j]

    addi    t1, t1, -1      # j--
    j       inner_loop

insert:
    # Chèn key vào vị trí trống (j + 1)
    # t1 đang là j, nên (t1 + 1) * 4 là offset của vị trí cần chèn
    addi    t6, t1, 1       
    slli    t6, t6, 2
    add     t6, a0, t6
    sw      t2, 0(t6)       # arr[j+1] = key

    addi    t0, t0, 1       # i++ (xét phần tử tiếp theo)
    j       outer_loop

done:
    # Thoát chương trình
    li      a7, 10
    ecall