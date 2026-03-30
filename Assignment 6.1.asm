# Bài tập: Assignment 1 - Max Prefix-Sum (Test case mới)
# -----------------------------------
# Theo dõi các thanh ghi này khi chạy Step:
# t0: i (chỉ số mảng đang duyệt)
# t1: current_sum (tổng hiện tại)
# t2: max_sum (tổng kỷ lục, khởi tạo âm vô cùng)
# t3: max_index (vị trí đạt kỷ lục)
# -----------------------------------

.data
    # Đã thay đổi bộ giá trị mới cho mảng
    arr:        .word 10, -5, 20, -15, 30, -8   
    n:          .word 6                 
    msg_res:    .string "Max prefix sum: "
    msg_idx:    .string "\nSo phan tu: "

.text
.globl main
main:
    # --- SETUP DỮ LIỆU ---
    la      a0, arr         
    lw      a1, n           

    li      t1, 0           
    li      t2, 0x80000000  # Khởi tạo max_sum = INT_MIN
    li      t3, -1          
    li      t0, 0           

loop:
    bge     t0, a1, done    

    # --- LẤY ARR[i] VÀ CỘNG DỒN ---
    slli    t4, t0, 2       
    add     t4, a0, t4      
    lw      t5, 0(t4)       

    add     t1, t1, t5      # current_sum += arr[i]

    # --- SO SÁNH TÌM MAX ---
    ble     t1, t2, next    
    
    mv      t2, t1          # Kỷ lục mới -> update max_sum
    mv      t3, t0          # update vị trí max

next:
    addi    t0, t0, 1       
    j       loop            

done:
    # --- IN KẾT QUẢ ---
    la      a0, msg_res
    li      a7, 4
    ecall

    mv      a0, t2
    li      a7, 1
    ecall

    la      a0, msg_idx
    li      a7, 4
    ecall

    addi    a0, t3, 1
    li      a7, 1
    ecall

    li      a7, 10
    ecall