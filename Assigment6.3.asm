# Bài tập: Thuật toán Sắp xếp nổi bọt (Bubble Sort)
# -----------------------------------
# Mapping thanh ghi:
# a0: địa chỉ đầu mảng
# a1: n (số phần tử)
# t0: i (biến đếm vòng lặp ngoài)
# t1: j (biến đếm vòng lặp trong)
# t2: n - 1 (giới hạn vòng lặp)
# -----------------------------------

.data
    arr:        .word 34, 7, 23, 32, 5, 62   # Mảng đầu vào
    n:          .word 6
    msg_start:  .string "Dang sap xep nổi bọt...\n"
    msg_done:   .string "Sap xep xong!"

.text
.globl main
main:
    la      a0, arr
    lw      a1, n
    
    addi    t2, a1, -1      # t2 = n - 1
    li      t0, 0           # i = 0 (vòng lặp ngoài)

outer_loop:
    bge     t0, t2, done    # if i >= n-1 then finish
    
    li      t1, 0           # j = 0 (vòng lặp trong)
    sub     t3, t2, t0      # t3 = (n - 1) - i (giới hạn j để tránh so sánh phần tử đã sort)

inner_loop:
    bge     t1, t3, next_outer # if j >= (n-1-i) then next i

    # --- Lấy cặp arr[j] và arr[j+1] ---
    slli    t4, t1, 2       # t4 = j * 4
    add     t4, a0, t4      # t4 = địa chỉ arr[j]
    
    lw      s0, 0(t4)       # s0 = arr[j]
    lw      s1, 4(t4)       # s1 = arr[j+1]

    # --- So sánh và Swap ---
    ble     s0, s1, no_swap # Nếu arr[j] <= arr[j+1] thì không làm gì
    
    sw      s1, 0(t4)       # Swap: arr[j] = s1
    sw      s0, 4(t4)       # Swap: arr[j+1] = s0

no_swap:
    addi    t1, t1, 1       # j++
    j       inner_loop

next_outer:
    addi    t0, t0, 1       # i++
    j       outer_loop

done:
    # Kết thúc
    li      a7, 10
    ecall