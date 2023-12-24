declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %tmp6 = add i64 1, 5
 call void @print_integer (i64 %tmp6)
 ret i64 0
}
