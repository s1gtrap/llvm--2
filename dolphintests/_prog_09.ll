declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a60 = alloca i64
 %tmp59 = add i64 100, 100
 store i64 %tmp59, i64* %a60
 ret i64 0
}
