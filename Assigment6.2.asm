# Bài tập: Assignment 2 - Selection Sort (Pointer) + Print Subroutine
# -----------------------------------

.data
    # 1. Khởi tạo bộ giá trị mới cho mảng
    arr:        .word 45, 12, 89, 33, 71, 8   # Mảng test mới
    n:          .word 6
    space:      .string " "
    newline:    .string "\n"
    msg_pass:   .string "Mang hien tai: "

.text
.globl main
main:
    # --- SETUP CON TRỎ BAN ĐẦU ---
    la      a0, arr         # a0: base pointer (đầu mảng)
    lw      t2, n           
    
    addi    t2, t2, -1      
    slli    t2, t2, 2       
    add     a1, a0, t2      # a1: end pointer (cuối mảng chưa sort)

    # In mảng mốc ban đầu cho dễ so sánh
    jal     print_array

outer_loop:
    bge     a0, a1, done    # Sort xong hết thì nghỉ

    # --- TÌM MAX ---
    mv      s0, a0          # s0: max pointer
    lw      s1, 0(s0)       # s1: max value
    mv      t0, a0          # t0: cur pointer

find_max:
    bgt     t0, a1, do_swap # Duyệt xong vùng chưa sort thì đi swap
    lw      t1, 0(t0)       
    ble     t1, s1, skip    
    
    # Cập nhật max mới
    mv      s0, t0          
    mv      s1, t1          

skip:
    addi    t0, t0, 4       
    j       find_max

do_swap:
    # --- ĐỔI CHỖ MAX VỀ CUỐI ---
    lw      t3, 0(a1)       
    sw      s1, 0(a1)       
    sw      t3, 0(s0)       

    # --- GỌI CHƯƠNG TRÌNH CON IN MẢNG ---
    jal     print_array     # Jump and Link: Nhảy tới hàm in và lưu địa chỉ quay về vào 'ra'

    # --- THU HẸP VÙNG ---
    addi    a1, a1, -4      # Chốt được 1 em max ở cuối, lùi a1 lại
    j       outer_loop      

done:
    li      a7, 10
    ecall


# ==========================================
# CHƯƠNG TRÌNH CON: print_array
# Chức năng: In toàn bộ mảng ra màn hình
# ==========================================
print_array:
    # 1. Backup thanh ghi vào Stack (để không phá hỏng mảng main)
    addi    sp, sp, -16     # Mở rộng stack lấy chỗ chứa 4 biến (4x4=16 bytes)
    sw      a0, 0(sp)       
    sw      t0, 4(sp)
    sw      t1, 8(sp)
    sw      a7, 12(sp)

    # 2. In chữ "Mang hien tai: "
    la      a0, msg_pass
    li      a7, 4
    ecall

    # 3. Khởi tạo biến để lặp in mảng
    la      t0, arr         # t0 trỏ vào đầu mảng
    lw      t1, n           # t1 = n (số lần lặp)

print_loop:
    beqz    t1, print_end   # In hết n phần tử thì thoát

    # In con số
    lw      a0, 0(t0)
    li      a7, 1
    ecall

    # In dấu cách
    la      a0, space
    li      a7, 4
    ecall

    addi    t0, t0, 4       # Nhích sang số tiếp theo
    addi    t1, t1, -1      # Giảm biến đếm
    j       print_loop

print_end:
    # In dấu xuống dòng cho đẹp
    la      a0, newline
    li      a7, 4
    ecall

    # 4. Restore thanh ghi từ Stack trả lại cho main
    lw      a0, 0(sp)
    lw      t0, 4(sp)
    lw      t1, 8(sp)
    lw      a7, 12(sp)
    addi    sp, sp, 16      # Trả lại bộ nhớ stack

    jr      ra              # Jump Register: Quay lại nơi vừa gọi hàm (sau lệnh jal)