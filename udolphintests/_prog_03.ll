declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x11 = alloca i64
 store i64 10, i64* %x11
 %temp13 = load i64, i64* %x11
 %tmp14 = add i64 1, %temp13
 call void @print_integer (i64 %tmp14)
 ret i64 0
}

