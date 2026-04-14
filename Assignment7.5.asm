# Chương trình con: find_max_min
# Input: 8 số nguyên có dấu nằm trong a0, a1, a2, a3, a4, a5, a6, a7
# Output: 
#   a0 = Giá trị lớn nhất
#   a1 = Vị trí của giá trị lớn nhất (0 đến 7)
#   a2 = Giá trị nhỏ nhất
#   a3 = Vị trí của giá trị nhỏ nhất (0 đến 7)

find_max_min:
    # 1. Khởi tạo: Giả sử a0 (vị trí 0) vừa là Max vừa là Min
    mv t0, a0       # t0 lưu giá trị Max tạm thời
    li t1, 0        # t1 lưu vị trí của Max
    
    mv t2, a0       # t2 lưu giá trị Min tạm thời
    li t3, 0        # t3 lưu vị trí của Min

    # 2. Kiểm tra thanh ghi a1 (vị trí 1)
    ble a1, t0, skip_max_1  # Nếu a1 <= Max hiện tại, bỏ qua cập nhật Max
    mv t0, a1               # Cập nhật Max = a1
    li t1, 1                # Cập nhật vị trí Max = 1
skip_max_1:
    bge a1, t2, skip_min_1  # Nếu a1 >= Min hiện tại, bỏ qua cập nhật Min
    mv t2, a1               # Cập nhật Min = a1
    li t3, 1                # Cập nhật vị trí Min = 1
skip_min_1:

    # 3. Kiểm tra thanh ghi a2 (vị trí 2)
    ble a2, t0, skip_max_2
    mv t0, a2
    li t1, 2
skip_max_2:
    bge a2, t2, skip_min_2
    mv t2, a2
    li t3, 2
skip_min_2:

    # 4. Kiểm tra thanh ghi a3 (vị trí 3)
    ble a3, t0, skip_max_3
    mv t0, a3
    li t1, 3
skip_max_3:
    bge a3, t2, skip_min_3
    mv t2, a3
    li t3, 3
skip_min_3:

    # 5. Kiểm tra thanh ghi a4 (vị trí 4)
    ble a4, t0, skip_max_4
    mv t0, a4
    li t1, 4
skip_max_4:
    bge a4, t2, skip_min_4
    mv t2, a4
    li t3, 4
skip_min_4:

    # 6. Kiểm tra thanh ghi a5 (vị trí 5)
    ble a5, t0, skip_max_5
    mv t0, a5
    li t1, 5
skip_max_5:
    bge a5, t2, skip_min_5
    mv t2, a5
    li t3, 5
skip_min_5:

    # 7. Kiểm tra thanh ghi a6 (vị trí 6)
    ble a6, t0, skip_max_6
    mv t0, a6
    li t1, 6
skip_max_6:
    bge a6, t2, skip_min_6
    mv t2, a6
    li t3, 6
skip_min_6:

    # 8. Kiểm tra thanh ghi a7 (vị trí 7)
    ble a7, t0, skip_max_7
    mv t0, a7
    li t1, 7
skip_max_7:
    bge a7, t2, skip_min_7
    mv t2, a7
    li t3, 7
skip_min_7:

    # 9. Đưa kết quả vào các thanh ghi trả về (Return Registers)
    mv a0, t0       # Trả về Giá trị lớn nhất
    mv a1, t1       # Trả về Vị trí lớn nhất
    mv a2, t2       # Trả về Giá trị nhỏ nhất
    mv a3, t3       # Trả về Vị trí nhỏ nhất

    ret             # Kết thúc chương trình con (Return)