declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x20 = alloca i64
 %tmp19 = call i64 @read_integer ()
 store i64 %tmp19, i64* %x20
 %temp22 = load i64, i64* %x20
 %tmp23 = add i64 1, %temp22
 call void @print_integer (i64 %tmp23)
 ret i64 0
}
