declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a90 = alloca i1
 %cmp84 = icmp eq i1 1, 0
 br i1 %cmp84, label %leftFalse85, label %leftTrue86
leftFalse85:
 br label %merge87
leftTrue86:
 %tmp88 = icmp eq i64 1, 1
 br label %merge87
merge87:
 %tmp89 = phi i1 [0, %leftFalse85], [%tmp88, %leftTrue86]
 store i1 %tmp89, i1* %a90
 ret i64 0
}
