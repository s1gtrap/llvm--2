declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a70 = alloca i1
 %cmp64 = icmp eq i1 1, 1
 br i1 %cmp64, label %leftTrue65, label %leftFalse66
leftTrue65:
 br label %merge67
leftFalse66:
 %tmp68 = icmp eq i64 1, 1
 br label %merge67
merge67:
 %tmp69 = phi i1 [1, %leftTrue65], [%tmp68, %leftFalse66]
 store i1 %tmp69, i1* %a70
 ret i64 0
}
