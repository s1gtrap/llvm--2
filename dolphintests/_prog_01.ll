declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 call void @print_integer (i64 5)
 ret i64 0
}
