declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a178 = alloca i1
 %tmp177 = icmp eq i64 5, 5
 store i1 %tmp177, i1* %a178
 ret i64 0
}
